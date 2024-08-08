import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserLocationListScreen extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('locations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No locations found.'));
          } else {
            final locations = snapshot.data!.docs;

            return ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location =
                    locations[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(
                      '${location['city']}, ${location['district']}, ${location['state']}, ${location['country']}'),
                  subtitle: Text(
                      'Country: ${location['country']}, State: ${location['state']}, District: ${location['district']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
