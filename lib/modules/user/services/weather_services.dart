import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../shared_components/utils/constants.dart';
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherDataa?> fetchWeatherDataByCityName(
      {required String cityName}) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey'));
      print("weather values:${response.body}");
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
