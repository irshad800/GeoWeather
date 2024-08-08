import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addLocation(
      String country, String state, String district, String city) async {
    try {
      await _db.collection('locations').add({
        'country': country,
        'state': state,
        'district': district,
        'city': city,
      });
    } catch (e) {
      print('Error adding location: $e');
      throw e;
    }
  }
}
