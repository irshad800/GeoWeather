import 'package:flutter/material.dart';

import '../../modules/auth/login_screen.dart';
import '../services/auth_services.dart';
import '../utils/constants.dart';

final AuthService _authService = AuthService();

class NavbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? userEmail =
        _authService.getCurrentUserEmail() ?? 'user@example.com';
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User'),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'U',
                style: TextStyle(fontSize: 40.0, color: primaryColors),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColors, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: primaryColors),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/user-dashboard');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout'),
            onTap: () async {
              await _authService.signOut(context: context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
