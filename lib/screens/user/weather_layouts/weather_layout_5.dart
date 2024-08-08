import 'package:flutter/material.dart';

class WeatherLayout5 extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  WeatherLayout5({this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'Weather Layout 5',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.thermostat_outlined,
                    size: 40,
                    color: Colors.red,
                  ),
                  SizedBox(height: 5),
                  Text(
                      'Temperature: ${weatherData?['temperature'] ?? 'N/A'} °C'),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.water,
                    size: 40,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text('Humidity: ${weatherData?['humidity'] ?? 'N/A'} %'),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.air,
                    size: 40,
                    color: Colors.green,
                  ),
                  SizedBox(height: 5),
                  Text(
                      'Wind Speed: ${weatherData?['windSpeed'] ?? 'N/A'} km/h'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
