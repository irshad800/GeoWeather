import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared_components/utils/constants.dart';
import '../../../shared_components/widgets/footer.dart';
import '../models/location_model.dart';

class AdminLocationListScreen extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text(
          'Added Locations',
          style: TextStyle(fontFamily: "Airbnb", color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, primaryColors],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('locations').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No locations found.'));
                  } else {
                    final locations = snapshot.data!.docs.map((doc) {
                      return Locations.fromJson(
                        doc.data() as Map<String, dynamic>,
                      );
                    }).toList();

                    return ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: primaryColors,
                            ),
                            subtitle: Text(
                              'Country: ${location.country}\n'
                              'State: ${location.state}\n'
                              'District: ${location.district}\n'
                              'City: ${location.city}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            contentPadding: EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            FooterWidget()
          ],
        ),
      ),
    );
  }
}
