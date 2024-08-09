import 'package:flutter/material.dart';

import '../../../models/weather_model.dart';

class WeatherGridLayout extends StatelessWidget {
  final List<WeatherDataa> weatherDataList;

  WeatherGridLayout({required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: weatherDataList.length,
        itemBuilder: (context, index) {
          final weatherData = weatherDataList[index];
          return Card(
            elevation: 5,
            color: Colors.orange.shade100, // Light orange background
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weatherData.name ?? 'Unknown Location',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    'Temperature: ${weatherData.main?.temp?.toStringAsFixed(1) ?? 'N/A'}°C',
                  ),
                  Text(
                    'Weather: ${weatherData.weather?.first.description ?? 'N/A'}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
