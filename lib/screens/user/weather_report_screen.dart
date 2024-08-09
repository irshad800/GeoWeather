import 'package:flutter/material.dart';
import 'package:newtokteck_task/screens/user/weather_layouts/weather_layout_1.dart';
import 'package:newtokteck_task/screens/user/weather_layouts/weather_layout_2.dart';
import 'package:newtokteck_task/screens/user/weather_layouts/weather_layout_3.dart';
import 'package:newtokteck_task/screens/user/weather_layouts/weather_layout_4.dart';
import 'package:newtokteck_task/screens/user/weather_layouts/weather_layout_5.dart';
import 'package:newtokteck_task/utils/constants.dart';

import '../../models/weather_model.dart';

class WeatherReportScreen extends StatelessWidget {
  final List<WeatherDataa>? weatherDataList;

  WeatherReportScreen({this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Weather Report',
            style: TextStyle(color: Colors.white, fontFamily: "Airbnb"),
          ),
          backgroundColor: primaryColors),
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
                    child:
                        BasicListTileLayout(weatherDataList: weatherDataList!),
                  ),

                  // Layout 2: Weather Data Card
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WeatherDataCardLayout(
                        weatherDataList: weatherDataList!),
                  ),

                  // Layout 3: Grid View
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WeatherGridLayout(weatherDataList: weatherDataList!),
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
    );
  }
}
