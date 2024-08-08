import 'package:flutter/material.dart';

class UserDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/upload_excel');
              },
              child: Text('Upload Excel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather_report');
              },
              child: Text('Weather Report'),
            ),
          ],
        ),
      ),
    );
  }
}
