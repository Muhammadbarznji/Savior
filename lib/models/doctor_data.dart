import 'package:cloud_firestore/cloud_firestore.dart';

class doctor_data {
  String address,
      city,
      country,
      graduationuniversity,
      holidays,
      medicalspecialty,
      name,
      otherexperiance,
      reservationmobileno,
      universityofspecialization,
      workstart,
      hospital,
      gender;

  doctor_data({
    this.address,
    this.city,
    this.country,
    this.graduationuniversity,
    this.holidays,
    this.medicalspecialty,
    this.name,
    this.otherexperiance,
    this.reservationmobileno,
    this.universityofspecialization,
    this.workstart,
    this.gender,
    this.hospital,
  });

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'address': address,
        'city': city,
        'country': country,
        'graduationuniversity': graduationuniversity,
        'holiday': holidays,
        'medicalspecialty': medicalspecialty,
        'name': name,
        'otherexperiance': otherexperiance,
        'reservationmobileno': reservationmobileno,
        'universityofspecialization': universityofspecialization,
        'workstart': workstart,
        'gender': gender,
        'hospital': hospital,
      };

  // creating a Trip object from a firebase snapshot
  doctor_data.fromSnapshot(DocumentSnapshot snapshot)
      : address = snapshot['address'],
        city = snapshot['city'],
        country = snapshot['country'],
        graduationuniversity = snapshot['graduationuniversity'],
        holidays = snapshot['holidays'],
        medicalspecialty = snapshot['medicalspecialty'],
        name = snapshot['name'],
        otherexperiance = snapshot['otherexperiance'],
        reservationmobileno = snapshot['reservationmobileno'],
        universityofspecialization = snapshot['universityofspecialization'],
        workstart = snapshot['workstart'],
        gender = snapshot['gender'],
        hospital = snapshot['hospital'];
}
