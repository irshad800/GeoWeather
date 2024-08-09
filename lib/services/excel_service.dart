import 'dart:io';

import 'package:excel/excel.dart';
import 'package:newtokteck_task/services/weather_services.dart';

class ExcelService {
  final WeatherService weatherService;

  ExcelService({required this.weatherService});

  Future<void> uploadExcel(String filePath) async {
    var file = File(filePath);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // Extract file name (without extension) for matching
    var fileName = file.uri.pathSegments.last.split('.').first;

    // Print all values inside the Excel file
    print('--- Excel File Data ---');
    for (var table in excel.tables.keys) {
      print('Sheet: $table'); // Print the sheet name
      var sheet = excel.tables[table];
      if (sheet != null) {
        // Print header row
        if (sheet.rows.isNotEmpty) {
          print(
              'Header: ${sheet.rows[0].map((cell) => cell?.value).join(' | ')}');
        }
        for (var row in sheet.rows.skip(1)) {
          // Skip header row
          print('Row: ${row.map((cell) => cell?.value).join(' | ')}');

          // Check if any cell in the row matches the file name
          if (row.any((cell) => cell?.toString() == fileName)) {
            print(
                'Match found in row: ${row.map((cell) => cell?.value).join(' | ')}');
          }
        }
      }
    }

    List<Map<String, double>> locations = [];

    for (var table in excel.tables.keys) {
      if (excel.tables[table] != null) {
        for (var row in excel.tables[table]!.rows.skip(1)) {
          // Skip header row
          if (row.length >= 4) {
            double lat = double.tryParse(row[2]?.toString() ?? '') ?? 0.0;
            double lon = double.tryParse(row[3]?.toString() ?? '') ?? 0.0;

            if (lat != 0.0 && lon != 0.0) {
              locations.add({'latitude': lat, 'longitude': lon});
            }
          }
        }
      }
    }

    // Print extracted locations
    print('--- Extracted Locations ---');
    for (var location in locations) {
      print('Lat: ${location['latitude']}, Lon: ${location['longitude']}');
    }

    // Fetch weather data for each location and print the report
    print('--- Weather Reports ---');
    for (var location in locations) {
      try {
        final weatherData = await weatherService.fetchWeatherData(
          latitude: location['latitude']!,
          longitude: location['longitude']!,
        );
        var temperature = weatherData['main']['temp'] ?? 'N/A';
        var weatherDescription =
            weatherData['weather'][0]['description'] ?? 'No description';

        print(
            'Weather report for (Lat: ${location['latitude']}, Lon: ${location['longitude']}):');
        print('Temperature: $temperature');
        print('Weather Description: $weatherDescription');
        print('---');
      } catch (e) {
        print(
            'Error fetching weather data for (Lat: ${location['latitude']}, Lon: ${location['longitude']}): $e');
      }
    }
  }
}
