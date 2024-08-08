import 'package:flutter/material.dart';

class WeatherLayout1 extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  WeatherLayout1({this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Layout 1',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Temperature: ${weatherData?['temperature'] ?? 'N/A'} °C'),
            Text('Humidity: ${weatherData?['humidity'] ?? 'N/A'} %'),
            Text('Wind Speed: ${weatherData?['windSpeed'] ?? 'N/A'} km/h'),
          ],
        ),
      ),
    );
  }
}
