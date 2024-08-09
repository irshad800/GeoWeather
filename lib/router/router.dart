import 'package:flutter/material.dart';
import 'package:newtokteck_task/screens/SignUp.dart';
import 'package:newtokteck_task/screens/admin/add_location.dart';
import 'package:newtokteck_task/screens/admin/admin_dashboard_screen.dart';
import 'package:newtokteck_task/screens/login_screen.dart';
import 'package:newtokteck_task/screens/user/upload_excel_screen.dart';
import 'package:newtokteck_task/screens/user/user_dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/admin':
        return MaterialPageRoute(builder: (_) => AdminDashboardScreen());

      case '/add-location':
        return MaterialPageRoute(builder: (_) => AddLocationScreen());
      case '/user':
        return MaterialPageRoute(builder: (_) => UserDashboardScreen());
      case '/upload-excel':
        return MaterialPageRoute(builder: (_) => UploadExcelScreen());
      // case '/weather-report':
      //   return MaterialPageRoute(builder: (_) => WeatherReportScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
