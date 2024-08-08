import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:newtokteck_task/services/weather_services.dart';

class ExcelService {
  final WeatherService weatherService;

  ExcelService({required this.weatherService});

  Future<void> uploadExcel(String filePath) async {
    var file = File(filePath);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      if (excel.tables[table] != null) {
        for (var row in excel.tables[table]!.rows) {
          await FirebaseFirestore.instance.collection('excelData').add({
            'data': row,
          });
        }
      }
    }
  }
}
