import 'package:cloud_firestore/cloud_firestore.dart';

import '../../admin/models/location_model.dart';

class LocationServiceSUser {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Locations>> getLocations() async {
    try {
      QuerySnapshot snapshot = await _db.collection('locations').get();
      return snapshot.docs
          .map((doc) => Locations.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching locations: $e');
      return [];
    }
  }
}
