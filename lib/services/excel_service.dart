import 'dart:io';

import 'package:excel/excel.dart';
import 'package:newtokteck_task/services/weather_services.dart';

import '../models/weather_model.dart';

class ExcelService {
  final WeatherService weatherService;

  ExcelService({required this.weatherService});

  Future<void> uploadExcel(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = file.readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      final List<WeatherDataa> weatherDataList = [];

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        for (var row in sheet!.rows) {
          String cityName = row[0]?.value?.toString() ?? '';
          if (cityName.isNotEmpty) {
            final weatherData = await weatherService.fetchWeatherDataByCityName(
                cityName: cityName);
            if (weatherData != null) {
              weatherDataList.add(weatherData);
            }
          }
        }
      }

      // You can now use weatherDataList as needed
      // For example, you can print the data or save it to a database
      print('Processed ${weatherDataList.length} weather data entries.');
    } catch (e) {
      print('Error processing Excel file: $e');
      rethrow;
    }
  }
}
