import 'package:flutter/material.dart';

import '../../models/weather_model.dart';

class WeatherReportScreen extends StatelessWidget {
  final List<WeatherDataa>? weatherDataList;

  WeatherReportScreen({this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Report'),
        backgroundColor: Colors.blue, // Customize as needed
      ),
      body: weatherDataList == null || weatherDataList!.isEmpty
          ? Center(
              child: Text('No weather data available'),
            )
          : ListView.builder(
              itemCount: weatherDataList!.length,
              itemBuilder: (context, index) {
                final weatherData = weatherDataList![index];
                final temperature = weatherData.main?.temp ?? 0.0;
                final weatherDescription =
                    weatherData.weather?.isNotEmpty == true
                        ? weatherData.weather!.first.description
                        : 'No description available';

                return ListTile(
                  title: Text(weatherData.name ?? 'Unknown Location'),
                  subtitle: Text(
                    'Temperature: ${temperature.toStringAsFixed(1)}°C\n'
                    'Weather: $weatherDescription',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    // Handle onTap if you want to navigate to a detailed view
                  },
                );
              },
            ),
    );
  }
}
