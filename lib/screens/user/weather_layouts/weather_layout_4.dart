import 'package:flutter/material.dart';

class WeatherLayout4 extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  WeatherLayout4({this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.orange[100],
      child: ListTile(
        leading: Icon(
          Icons.thermostat,
          size: 40,
          color: Colors.orange,
        ),
        title: Text(
          'Weather Layout 4',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Temperature: ${weatherData?['temperature'] ?? 'N/A'} °C'),
            Text('Humidity: ${weatherData?['humidity'] ?? 'N/A'} %'),
            Text('Wind Speed: ${weatherData?['windSpeed'] ?? 'N/A'} km/h'),
          ],
        ),
      ),
    );
  }
}
