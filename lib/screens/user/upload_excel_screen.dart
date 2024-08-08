import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/excel_service.dart';

class UploadExcelScreen extends StatefulWidget {
  @override
  _UploadExcelScreenState createState() => _UploadExcelScreenState();
}

class _UploadExcelScreenState extends State<UploadExcelScreen> {
  @override
  Widget build(BuildContext context) {
    final excelService = Provider.of<ExcelService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Excel'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            print("Button Pressed");
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              print("File Selected: ${result.files.single.name}");
              await excelService.uploadExcel(result.files.single.path!);
            } else {
              print("File selection canceled");
            }
          },
          child: Text('Select Excel File'),
        ),
      ),
    );
  }
}
