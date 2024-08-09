import 'package:flutter/material.dart';

import '../../../models/weather_model.dart';

class BasicListTileLayout extends StatelessWidget {
  final List<WeatherDataa> weatherDataList;

  BasicListTileLayout({required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weatherDataList
          .map((weatherData) => ListTile(
                tileColor: Colors.lightBlue.shade50, // Light blue background
                title: Text(weatherData.name ?? 'Unknown Location'),
                subtitle: Text(
                  'Temperature: ${weatherData.main?.temp?.toStringAsFixed(1) ?? 'N/A'}°C\n'
                  'Weather: ${weatherData.weather?.first.description ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
              ))
          .toList(),
    );
  }
}
