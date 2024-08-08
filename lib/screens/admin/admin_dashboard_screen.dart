import 'package:flutter/material.dart';

import 'add_location.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddLocationScreen(),
                    ));
              },
              child: Text('Add Location'),
            ),
          ],
        ),
      ),
    );
  }
}
