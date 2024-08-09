import 'package:flutter/material.dart';

import '../../../models/weather_model.dart';

class WeatherLayout1 extends StatelessWidget {
  final WeatherDataa weatherData;

  WeatherLayout1({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Temperature: ${weatherData.main?.temp}°C',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Weather: ${weatherData.weather?.first.description ?? 'No description'}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Humidity: ${weatherData.main?.humidity}%',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Wind Speed: ${weatherData.wind?.speed} m/s',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
