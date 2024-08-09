import 'package:flutter/material.dart';

class WeatherLayout2 extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherLayout2({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.green[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Layout 2',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text('Temperature: ${weatherData['main']['temp']}K'),
          Text('Weather: ${weatherData['weather'][0]['description']}'),
          Text('Wind Speed: ${weatherData['wind']['speed']} m/s'),
        ],
      ),
    );
  }
}
