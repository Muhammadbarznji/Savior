import 'package:cloud_firestore/cloud_firestore.dart';

class FirstAid_data {
  String title;

  FirstAid_data(
      this.title
      );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    'title': title,
  };

  // creating a Trip object from a firebase snapshot
FirstAid_data.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'];
}