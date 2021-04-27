import 'package:cloud_firestore/cloud_firestore.dart';

class hospital_data {
  String name, phone, image, address, info, web, general;

  hospital_data(
    this.name,
    this.phone,
    this.image,
    this.address,
    this.info,
    this.web,
    this.general,
  );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'image': image,
        'address': address,
        'info': info,
        'web': web,
        'general': general,
      };

  // creating a Trip object from a firebase snapshot
  hospital_data.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        phone = snapshot['phone'],
        image = snapshot['image'],
        address = snapshot['address'],
        info = snapshot['info'],
        general = snapshot['general'],
        web = snapshot['web'];
}
