import 'package:flutter/material.dart';

import '../../../models/weather_model.dart';

class WeatherLayout4 extends StatelessWidget {
  final WeatherDataa weatherData;

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
    );
  }
}
