class WeatherService {
  Future<Map<String, dynamic>> fetchWeatherData() async {
    return {
      'temperature': 25,
      'humidity': 60,
      'windSpeed': 10,
    };
  }
}
