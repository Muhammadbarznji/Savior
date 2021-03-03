import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  String name;
  String phone;
  String image;



  Trip(
      this.name,
      this.phone,
      this.image
      );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'image': image,
  };

  // creating a Trip object from a firebase snapshot
  Trip.fromSnapshot(DocumentSnapshot snapshot) :
        name = snapshot['name'],
        phone = snapshot['phone'],
        image = snapshot['image'];
}