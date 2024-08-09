import 'package:flutter/material.dart';

class WeatherLayout5 extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherLayout5({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.purple[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Layout 5',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text('Temperature: ${weatherData['main']['temp']}K'),
          Text('Weather: ${weatherData['weather'][0]['description']}'),
          Text('Visibility: ${weatherData['visibility']} meters'),
        ],
      ),
    );
  }
}
