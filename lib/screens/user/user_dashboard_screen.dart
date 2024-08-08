import 'package:flutter/material.dart';
import 'package:newtokteck_task/screens/user/upload_excel_screen.dart';
import 'package:newtokteck_task/screens/user/weather_report_screen.dart';

import 'location_list_screen.dart';

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLocationListScreen(),
                    ));
              },
              child: Text('View Locations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadExcelScreen(),
                    ));
              },
              child: Text('Upload Excel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherReportScreen(),
                    ));
              },
              child: Text('Weather Report'),
            ),
          ],
        ),
      ),
    );
  }
}
