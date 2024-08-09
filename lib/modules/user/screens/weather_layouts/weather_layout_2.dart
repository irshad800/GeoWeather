import 'package:flutter/material.dart';

import '../../../../shared_components/utils/constants.dart';
import '../../models/weather_model.dart';

class WeatherDataCardLayout extends StatelessWidget {
  final List<WeatherDataa> weatherDataList;

  WeatherDataCardLayout({required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weatherDataList
          .map((weatherData) => Card(
                margin: EdgeInsets.all(8),
                color: primaryColors,
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    weatherData.name ?? 'Unknown Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Airbnb",
                    ),
                  ),
                  subtitle: Text(
                    '${(weatherData.main!.temp! - 273.15).toStringAsFixed(0)}°C' ??
                        'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Airbnb",
                    ),
                  ),
                  trailing: Text(
                    'Weather: ${weatherData.weather?.first.description ?? 'N/A'}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
