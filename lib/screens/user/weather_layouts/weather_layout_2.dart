import 'package:flutter/material.dart';

class WeatherLayout2 extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  WeatherLayout2({this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Weather Layout 2',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Icon(
              Icons.wb_sunny,
              size: 50,
              color: Colors.yellow,
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
