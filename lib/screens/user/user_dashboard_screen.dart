import 'package:flutter/material.dart';
import 'package:newtokteck_task/screens/login_screen.dart';
import 'package:newtokteck_task/screens/user/location_list_screen.dart';
import 'package:newtokteck_task/screens/user/upload_excel_screen.dart';
import 'package:newtokteck_task/screens/user/weather_report_screen.dart';
import 'package:newtokteck_task/utils/constants.dart';
import 'package:newtokteck_task/widgets/footer.dart';

import '../../auth_services.dart';

class UserDashboardScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<bool> _onWillPop(BuildContext context) async {
    // This method is called when the back button is pressed
    // Here you can handle any specific logic you want before popping the screen
    // For this case, it navigates back to the dashboard
    Navigator.pushReplacementNamed(context, '/user-dashboard');
    return false; // Prevent the default back navigation
  }

  @override
  Widget build(BuildContext context) {
    String? userEmail =
        _authService.getCurrentUserEmail() ?? 'user@example.com';

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColors,
          title: Text(
            'User Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: Drawer(
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
              ListTile(
                leading: Icon(Icons.location_on, color: primaryColors),
                title: Text('View Locations'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/locations');
                },
              ),
              ListTile(
                leading: Icon(Icons.file_upload, color: primaryColors),
                title: Text('Upload Excel'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/upload-excel');
                },
              ),
              ListTile(
                leading: Icon(Icons.cloud, color: primaryColors),
                title: Text('Weather Report'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/weather-report');
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  color: Colors.blueGrey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'User Actions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColors,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserLocationListScreen(),
                                    ));
                              },
                              child: Text(
                                'View Locations',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColors,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UploadExcelScreen(),
                                    ));
                              },
                              child: Text(
                                'Upload Excel File',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColors,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WeatherReportScreen(),
                                    ));
                              },
                              child: Text(
                                'Weather Report',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: FooterWidget(),
      ),
    );
  }
}
