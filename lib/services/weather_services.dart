import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';
import '../utils/constants.dart'; // Ensure you have the API key defined in this file

class WeatherService {
  Future<WeatherDataa?> fetchWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));

      if (response.statusCode == 200) {
        return WeatherDataa.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to load weather data');
        return null;
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }
}
