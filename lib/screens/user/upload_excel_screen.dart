import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:newtokteck_task/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../services/excel_service.dart';

class UploadExcelScreen extends StatefulWidget {
  @override
  _UploadExcelScreenState createState() => _UploadExcelScreenState();
}

class _UploadExcelScreenState extends State<UploadExcelScreen> {
  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final excelService = Provider.of<ExcelService>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColors,
          title: Text(
            'Upload Excel',
            style: TextStyle(color: Colors.white, fontFamily: "Airbnb"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
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
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['xlsx'],
                        );
                        if (result != null) {
                          try {
                            final filePath = result.files.single.path;
                            if (filePath != null) {
                              await excelService.uploadExcel(filePath);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Excel file processed successfully'),
                                ),
                              );
                              Navigator.pop(context); // Navigate back
                            } else {
                              throw Exception('File path is null');
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Error processing file: ${e.toString()}'),
                              ),
                            );
                          }
                        } else {
                          // User canceled the picker
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No file selected'),
                            ),
                          );
                        }
                      },
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
      ),
    );
  }
}
