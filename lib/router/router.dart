import 'package:flutter/material.dart';
import 'package:newtokteck_task/modules/auth/SignUp.dart';
import 'package:newtokteck_task/modules/auth/login_screen.dart';

import '../modules/admin/screens/add_location.dart';
import '../modules/admin/screens/admin_dashboard_screen.dart';
import '../modules/user/screens/upload_excel_screen.dart';
import '../modules/user/screens/user_dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/admin':
        return MaterialPageRoute(
          builder: (context) => AdminDashboardScreen(),
        );
      case '/add-location':
        return MaterialPageRoute(builder: (_) => AddLocationScreen());
      case '/user':
        return MaterialPageRoute(builder: (_) => UserDashboardScreen());
      case '/upload-excel':
        return MaterialPageRoute(builder: (_) => UploadExcelScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
