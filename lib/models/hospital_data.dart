import 'package:cloud_firestore/cloud_firestore.dart';

class hospital_data {
  String name, phone, image, address;

  hospital_data(
      this.name,
      this.phone,
      this.image,
      this.address,
      );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'image': image,
    'address': address,
  };

  // creating a Trip object from a firebase snapshot
  hospital_data.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        phone = snapshot['phone'],
        image = snapshot['image'],
        address = snapshot['address'];
}