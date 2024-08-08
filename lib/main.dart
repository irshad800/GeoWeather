import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtokteck_task/screens/SignUp.dart';
import 'package:newtokteck_task/screens/admin/admin_dashboard_screen.dart';
import 'package:newtokteck_task/screens/user/user_dashboard_screen.dart';
import 'package:provider/provider.dart';

import 'auth_services.dart';
import 'screens/login_screen.dart';

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
        // Provider<LocationService>(create: (_) => LocationService()),
        // Provider<WeatherService>(create: (_) => WeatherService()),
        // ProxyProvider<WeatherService, ExcelService>(
        //   update: (_, weatherService, __) => ExcelService(weatherService: weatherService),
        // ),
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
        routes: {
          '/admin': (context) => AdminDashboardScreen(),
          '/user': (context) => UserDashboardScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          } else {
            return FutureBuilder(
              future: authService.getUserRole(user),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (roleSnapshot.data == 'admin') {
                    return AdminDashboardScreen();
                  } else {
                    return UserDashboardScreen();
                  }
                }
              },
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
