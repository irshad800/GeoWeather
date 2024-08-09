import 'package:flutter/material.dart';
import 'package:newtokteck_task/screens/user/weather_layouts/weather_layout_4.dart';
import 'package:newtokteck_task/screens/user/weather_layouts/weather_layout_5.dart';
import 'package:provider/provider.dart';

import '../../models/weather_model.dart';
import '../../services/weather_services.dart';
import 'weather_layouts/weather_layout_1.dart';
import 'weather_layouts/weather_layout_2.dart';
import 'weather_layouts/weather_layout_3.dart';

class WeatherReportScreen extends StatelessWidget {
  final double? latitude;
  final double? longitude;

  WeatherReportScreen({this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Report'),
      ),
      body: latitude != null && longitude != null
          ? FutureBuilder<WeatherDataa?>(
              future: weatherService.fetchWeatherData(
                latitude: latitude!,
                longitude: longitude!,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No data available'));
                } else {
                  final weatherData = snapshot.data!;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        WeatherLayout1(weatherData: weatherData),
                        WeatherLayout2(weatherData: weatherData),
                        WeatherLayout3(weatherData: weatherData),
                        WeatherLayout4(weatherData: weatherData),
                        WeatherLayout5(weatherData: weatherData),
                      ],
                    ),
                  );
                }
              },
            )
          : Center(child: Text('Invalid location data')),
    );
  }
}
