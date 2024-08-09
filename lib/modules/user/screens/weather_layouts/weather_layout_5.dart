import 'package:flutter/material.dart';

import '../../models/weather_model.dart';

class DetailedWeatherCardLayout extends StatelessWidget {
  final List<WeatherDataa> weatherDataList;

  DetailedWeatherCardLayout({required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weatherDataList
          .map((weatherData) => Card(
                margin: EdgeInsets.all(8),
                color: Colors.purple.shade100,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weatherData.name ?? 'Unknown Location',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${(weatherData.main!.temp! - 273.15).toStringAsFixed(0)}°C',
                        style: TextStyle(fontSize: 16, fontFamily: "Airbnb"),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Weather: ${weatherData.weather?.first.description ?? 'N/A'}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
