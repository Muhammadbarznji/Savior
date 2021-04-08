import 'package:cloud_firestore/cloud_firestore.dart';

class FirstAid_data {
  String title, medname, medtime, meddesc;

  FirstAid_data(
      this.title,
      this.medname,
      this.medtime,
      this.meddesc,
      );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    'title': title,
    'medname': medname,
    'medtime': medtime,
    'meddesc': meddesc,

  };

  // creating a Trip object from a firebase snapshot
FirstAid_data.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'],
       medname = snapshot['medname'],
      medtime = snapshot['medtime'],
      meddesc = snapshot['meddesc'];
}