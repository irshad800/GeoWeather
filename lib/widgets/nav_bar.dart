import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, '/home'); // Adjust this route if needed
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(
                    context, '/login'); // Navigate to login screen
              } catch (e) {
                // Handle logout error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to log out: $e')),
                );
              }
            },
          ),
          // Add other navigation items
        ],
      ),
    );
  }
}
