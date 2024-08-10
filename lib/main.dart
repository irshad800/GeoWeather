import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtokteck_task/shared_components/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'modules/admin/screens/admin_dashboard_screen.dart';
import 'modules/admin/services/location_services.dart';
import 'modules/auth/SignUp.dart';
import 'modules/auth/login_screen.dart';
import 'modules/user/screens/upload_excel_screen.dart';
import 'modules/user/screens/user_dashboard_screen.dart';
import 'modules/user/services/excel_service.dart';
import 'modules/user/services/weather_services.dart';

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
