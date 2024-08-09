import 'package:flutter/material.dart';

import '../../../models/weather_model.dart';

class BasicListTileLayout extends StatelessWidget {
  final List<WeatherDataa> weatherDataList;

  BasicListTileLayout({required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weatherDataList.map((weatherData) {
        final temperatureCelsius = weatherData.main?.temp != null
            ? (weatherData.main!.temp! - 273.15).toStringAsFixed(0)
            : 'N/A';

        return ListTile(
          tileColor: Colors.lightBlue.shade50,
          title: Text(
            weatherData.name ?? 'Unknown Location',
            style: TextStyle(
              fontFamily: "Airbnb",
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            ' ${temperatureCelsius}°C\n',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Airbnb",
            ),
          ),
          trailing: Text(
            'Weather: ${weatherData.weather?.first.description ?? 'N/A'}',
            semanticsLabel: 'Wind: ${weatherData.wind ?? 'N/A'}km',
          ),
        );
      }).toList(),
    );
  }
}
