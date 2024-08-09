import 'package:flutter/material.dart';
import 'package:newtokteck_task/screens/user/location_list_screen.dart';
import 'package:newtokteck_task/screens/user/upload_excel_screen.dart';
import 'package:newtokteck_task/utils/constants.dart';
import 'package:newtokteck_task/widgets/footer.dart';

import '../../auth_services.dart';
import '../../widgets/nav_bar.dart';

class UserDashboardScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/user-dashboard');
    return false;
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
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: NavbarWidget(),
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
                          ' Actions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            ElevatedButton.icon(
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
                              icon:
                                  Icon(Icons.location_on, color: Colors.white),
                              label: Text(
                                'View Locations',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
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
                              icon:
                                  Icon(Icons.file_upload, color: Colors.white),
                              label: Text(
                                'Upload Excel File',
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
