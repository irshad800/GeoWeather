import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/admin/screens/admin_dashboard_screen.dart';
import '../modules/auth/login_screen.dart';
import '../modules/user/screens/user_dashboard_screen.dart';
import '../shared_components/services/auth_services.dart';

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

// import 'package:flutter/material.dart';
// import 'package:newtokteck_task/modules/auth/SignUp.dart';
// import 'package:newtokteck_task/modules/auth/login_screen.dart';
//
// import '../modules/admin/screens/add_location.dart';
// import '../modules/admin/screens/admin_dashboard_screen.dart';
// import '../modules/user/screens/upload_excel_screen.dart';
// import '../modules/user/screens/user_dashboard_screen.dart';
//
// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/admin':
//         return MaterialPageRoute(
//           builder: (context) => AdminDashboardScreen(),
//         );
//       case '/add-location':
//         return MaterialPageRoute(builder: (_) => AddLocationScreen());
//       case '/user':
//         return MaterialPageRoute(builder: (_) => UserDashboardScreen());
//       case '/upload-excel':
//         return MaterialPageRoute(builder: (_) => UploadExcelScreen());
//       case '/login':
//         return MaterialPageRoute(builder: (_) => LoginScreen());
//       case '/signup':
//         return MaterialPageRoute(builder: (_) => SignupScreen());
//       default:
//         return MaterialPageRoute(builder: (_) => LoginScreen());
//     }
//   }
// }
