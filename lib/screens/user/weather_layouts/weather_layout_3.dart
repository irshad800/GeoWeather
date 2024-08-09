import 'package:flutter/material.dart';

class WeatherLayout3 extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherLayout3({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.red[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Layout 3',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text('Temperature: ${weatherData['main']['temp']}K'),
          Text('Weather: ${weatherData['weather'][0]['description']}'),
          Text('Pressure: ${weatherData['main']['pressure']} hPa'),
        ],
      ),
    );
  }
}
