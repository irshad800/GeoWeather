import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared_components/utils/constants.dart';
import '../../../shared_components/utils/helpers.dart';
import '../../../shared_components/widgets/Custom_textfeild.dart';
import '../services/location_services.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locationService = Provider.of<LocationService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text(
          'Enter Location Details',
          style: TextStyle(fontFamily: "Airbnb", color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColors, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        CustomTextField(
                          labeltext: 'Country',
                          controller: _countryController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a country';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          labeltext: 'State',
                          controller: _stateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a state';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          labeltext: 'District',
                          controller: _districtController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a district';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          labeltext: 'City',
                          controller: _cityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a city';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              _buildAddLocationButton(context, locationService),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAddLocationButton(
      BuildContext context, LocationService locationService) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final country = _countryController.text;
            final state = _stateController.text;
            final district = _districtController.text;
            final city = _cityController.text;

            await locationService.addLocation(country, state, district, city);
            Navigator.pop(context);
            showCustomSnackBar(
                context: context, message: "Location Added succesfully");
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColors,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          minimumSize: Size(double.infinity, 50),
          elevation: 5,
          shadowColor: Colors.black45,
        ),
        child: Text(
          'Add Location',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
