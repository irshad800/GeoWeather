import 'package:flutter/material.dart';

import '../../models/weather_model.dart';

class WeatherWithImageLayout extends StatelessWidget {
  final List<WeatherDataa> weatherDataList;

  WeatherWithImageLayout({required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weatherDataList
          .map((weatherData) => Card(
                margin: EdgeInsets.all(8),
                color: Colors.green.shade100,
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(Icons.wb_sunny, size: 40),
                  title: Text(weatherData.name ?? 'Unknown Location'),
                  subtitle: Text(
                    '${(weatherData.main!.temp! - 273.15).toStringAsFixed(0)}°C\n'
                    'Weather: ${weatherData.weather?.first.description ?? 'N/A'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
