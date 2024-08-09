import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/location_model.dart';

class LocationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addLocation(
      String country, String state, String district, String city) async {
    final location = Location(
      country: country,
      state: state,
      district: district,
      city: city,
    );

    try {
      await _db.collection('locations').add(location.toJson());
    } catch (e) {
      print('Error adding location: $e');
    }
  }

  Future<List<Location>> getLocations() async {
    try {
      QuerySnapshot snapshot = await _db.collection('locations').get();
      return snapshot.docs
          .map((doc) => Location.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching locations: $e');
      return [];
    }
  }
}
