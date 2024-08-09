import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newtokteck_task/utils/constants.dart';

class WeatherService {
  Future<Map<String, dynamic>> fetchWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse('${baseUrl}weather').replace(queryParameters: {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': apiKey,
    });

    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load weather data. Status code: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error occurred: $e');
    } on TimeoutException {
      throw Exception('The request timed out.');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }
}
