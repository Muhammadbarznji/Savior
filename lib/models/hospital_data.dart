import 'package:cloud_firestore/cloud_firestore.dart';

class hospital_data {
  String name, phone, image, address, info, web;

  hospital_data(
    this.name,
    this.phone,
    this.image,
    this.address,
    this.info,
    this.web,
  );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'image': image,
        'address': address,
        'info': info,
        'web': web,
      };

  // creating a Trip object from a firebase snapshot
  hospital_data.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        phone = snapshot['phone'],
        image = snapshot['image'],
        address = snapshot['address'],
        info = snapshot['info'],
        web = snapshot['web'];
}
