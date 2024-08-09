import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_services.dart';
import 'screens/SignUp.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/user/upload_excel_screen.dart';
import 'screens/user/user_dashboard_screen.dart';
import 'services/excel_service.dart';
import 'services/location_services.dart';
import 'services/weather_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<LocationService>(create: (_) => LocationService()),
        Provider<WeatherService>(create: (_) => WeatherService()),
        ProxyProvider<WeatherService, ExcelService>(
          update: (_, weatherService, __) =>
              ExcelService(weatherService: weatherService),
        ),
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
        routes: {
          '/admin': (context) => AdminDashboardScreen(),
          '/user': (context) => UserDashboardScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/upload-excel': (context) => UploadExcelScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          } else {
            return FutureBuilder<String?>(
              future: authService.getUserRole(user),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (roleSnapshot.hasData) {
                  if (roleSnapshot.data == 'admin') {
                    return AdminDashboardScreen();
                  } else {
                    return UserDashboardScreen();
                  }
                } else {
                  return LoginScreen();
                }
              },
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
