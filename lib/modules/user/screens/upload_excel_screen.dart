import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:newtokteck_task/modules/user/screens/weather_report_screen.dart';
import 'package:provider/provider.dart';

import '../../../shared_components/utils/constants.dart';
import '../models/weather_model.dart';
import '../services/excel_service.dart';

class UploadExcelScreen extends StatefulWidget {
  @override
  _UploadExcelScreenState createState() => _UploadExcelScreenState();
}

class _UploadExcelScreenState extends State<UploadExcelScreen> {
  Future<List<WeatherDataa>>? _weatherDataFuture;
  bool _isProcessing = false;

  Future<void> _processExcelFile() async {
    final excelService = Provider.of<ExcelService>(context, listen: false);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        final filePath = result.files.single.path;

        if (filePath != null) {
          setState(() {
            _isProcessing = true;
          });

          final weatherDataList = await excelService.uploadExcel(filePath);
          setState(() {
            _isProcessing = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeatherReportScreen(
                weatherDataList: weatherDataList,
              ),
            ),
          );
        } else {
          throw Exception('File path is null');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No file selected'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error processing file: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text(
          'Upload Excel',
          style: TextStyle(color: Colors.white, fontFamily: "Airbnb"),
        ),
      ),
      body: Center(
        child: _isProcessing
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Upload an Excel File',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryColors,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColors,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          onPressed: _processExcelFile,
                          child: Text(
                            'Select Excel File',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
