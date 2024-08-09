import 'dart:io';

import 'package:excel/excel.dart';
import 'package:newtokteck_task/services/weather_services.dart';

import '../models/weather_model.dart';

class ExcelService {
  final WeatherService weatherService;

  ExcelService({required this.weatherService});

  Future<void> uploadExcel(String filePath) async {
    File file = File(filePath);
    try {
      // Fetch weather data from the Excel file
      List<WeatherDataa> weatherDataList =
          await fetchWeatherDataFromExcel(file);

      // Handle the fetched weather data as needed
      print(
          'Weather data fetched successfully: ${weatherDataList.length} entries');
    } catch (e) {
      print('Error uploading or processing Excel file: $e');
      rethrow; // Rethrow the exception to handle it in the UI or higher-level code
    }
  }

  Future<List<Map<String, double>>> parseExcelFile(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<Map<String, double>> locations = [];

    for (var table in excel.tables.keys) {
      var sheet = excel.tables[table];
      print('Sheet: $table');

      for (var row in sheet!.rows) {
        print(row); // Print the entire row
        if (row.length >= 4) {
          double? lat = _parseDouble(row[2]?.toString());
          double? lon = _parseDouble(row[3]?.toString());

          if (lat != null && lon != null) {
            locations.add({'latitude': lat, 'longitude': lon});
          }
        }
      }
    }

    return locations;
  }

  double? _parseDouble(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    try {
      return double.parse(value);
    } catch (e) {
      print('Error parsing value to double: $value');
      return null;
    }
  }

  Future<List<WeatherDataa>> fetchWeatherDataFromExcel(File file) async {
    List<Map<String, double>> locations = await parseExcelFile(file);
    List<WeatherDataa> weatherDataList = [];

    for (var location in locations) {
      try {
        final weatherData = await weatherService.fetchWeatherData(
          latitude: location['latitude']!,
          longitude: location['longitude']!,
        );
        if (weatherData != null) {
          weatherDataList.add(weatherData);
        }
      } catch (e) {
        print(
            'Error fetching weather data for (Lat: ${location['latitude']}, Lon: ${location['longitude']}): $e');
      }
    }

    return weatherDataList;
  }
}
