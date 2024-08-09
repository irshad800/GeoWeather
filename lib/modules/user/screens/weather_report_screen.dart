import 'package:flutter/material.dart';
import 'package:newtokteck_task/modules/user/screens/user_dashboard_screen.dart';
import 'package:newtokteck_task/modules/user/screens/weather_layouts/weather_layout_1.dart';
import 'package:newtokteck_task/modules/user/screens/weather_layouts/weather_layout_2.dart';
import 'package:newtokteck_task/modules/user/screens/weather_layouts/weather_layout_3.dart';
import 'package:newtokteck_task/modules/user/screens/weather_layouts/weather_layout_4.dart';
import 'package:newtokteck_task/modules/user/screens/weather_layouts/weather_layout_5.dart';

import '../../../shared_components/utils/constants.dart';
import '../models/weather_model.dart';

class WeatherReportScreen extends StatelessWidget {
  final List<WeatherDataa>? weatherDataList;

  WeatherReportScreen({this.weatherDataList});

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDashboardScreen(),
        ));
    return false; // Prevent the default back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather Report',
            style: TextStyle(color: Colors.white, fontFamily: "Airbnb"),
          ),
          backgroundColor: primaryColors,
        ),
        body: weatherDataList == null || weatherDataList!.isEmpty
            ? Center(
                child: Text('No weather data available'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Layout 1: Basic ListTile
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BasicListTileLayout(
                          weatherDataList: weatherDataList!),
                    ),

                    // Layout 2: Grid View
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          WeatherGridLayout(weatherDataList: weatherDataList!),
                    ),

                    // Layout 3: Weather Data Card
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WeatherDataCardLayout(
                          weatherDataList: weatherDataList!),
                    ),

                    // Layout 4: Weather Data with Image
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WeatherWithImageLayout(
                          weatherDataList: weatherDataList!),
                    ),

                    // Layout 5: Detailed Weather Card
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DetailedWeatherCardLayout(
                          weatherDataList: weatherDataList!),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
