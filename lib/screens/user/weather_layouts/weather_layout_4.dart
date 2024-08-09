import 'package:flutter/material.dart';

class WeatherLayout4 extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherLayout4({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.orange[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Layout 4',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text('Temperature: ${weatherData['main']['temp']}K'),
          Text('Weather: ${weatherData['weather'][0]['description']}'),
          Text('Feels Like: ${weatherData['main']['feels_like']}K'),
        ],
      ),
    );
  }
}
