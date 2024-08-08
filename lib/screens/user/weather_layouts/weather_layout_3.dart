import 'package:flutter/material.dart';

class WeatherLayout3 extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  WeatherLayout3({this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(10),
      color: Colors.lightGreen[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather Layout 3',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Temperature: ${weatherData?['temperature'] ?? 'N/A'} °C'),
              Text('Humidity: ${weatherData?['humidity'] ?? 'N/A'} %'),
              Text('Wind Speed: ${weatherData?['windSpeed'] ?? 'N/A'} km/h'),
            ],
          ),
          Icon(
            Icons.cloud,
            size: 60,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
