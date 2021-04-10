import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewDoctor extends StatefulWidget {
  @override
  _AddNewDoctorState createState() => _AddNewDoctorState();
}

class _AddNewDoctorState extends State<AddNewDoctor> {
  RegExp regPhoneNumber;
  TextEditingController docNameController,
      phoneNumberController,
      addressController,
      cityController,
      countryController,
      graduationUniversityController,
      holidayController,
      hospitalController,
      medicalSpecialtyController,
      otherExperienceController,
      universityofspecializationController,
      workstartController;

  String gender;

  final List<String> genderList = ['Male', 'Female', 'Not say'];
  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    docNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    graduationUniversityController = TextEditingController();
    holidayController = TextEditingController();
    hospitalController = TextEditingController();
    medicalSpecialtyController = TextEditingController();
    otherExperienceController = TextEditingController();
    universityofspecializationController = TextEditingController();
    workstartController = TextEditingController();

    regPhoneNumber = RegExp(
        r"\s*(?:(\d{1,3}))?[-. (]*(\d{3,4})[-. )]*(\d{3})[-. ]*(\d{6})(?: *x(\d+))?\s*$");

    super.initState();
  }

  Future addDoctor() async {
    try {
      await Firestore.instance.collection('doctor').document().setData({
        'name': docNameController.text,
        'reservationmobileno': phoneNumberController.text,
        'address': addressController.text,
        'city': cityController.text,
        'country': countryController.text,
        'gender': gender,
        'graduationuniversity': graduationUniversityController.text,
        'holidays': holidayController.text,
        'hospital': hospitalController.text,
        'medicalspecialty': medicalSpecialtyController.text,
        'otherexperiances': otherExperienceController.text,
        'universityofspecialization': universityofspecializationController.text,
        'workstart': workstartController.text,
      });
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Image.asset('assets/images/doctorG.png'),
            ),
            Form(
              key: _registerFormKey,
              child: Card(
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Add new Doctor',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: docNameController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter doctor name',
/*                            prefixIcon:
                            Icon(Icons.person, color: Colors.indigo),*/
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Doctor name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: phoneNumberController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (value.length < 11) {
                              return 'Phone number too small';
                            }
                            if (regPhoneNumber.hasMatch(value.toString())) {
                              return 'Please enter validate phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: medicalSpecialtyController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'medical specialty',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter medical specialty';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: cityController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'City',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter city';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: countryController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Country',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter country';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: addressController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: graduationUniversityController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Graduation University',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Graduation University';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: hospitalController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Hospital',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Hospital';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: holidayController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Holiday',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Holiday';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: otherExperienceController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Other Experience',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Other Experience';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: universityofspecializationController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'University of Specialization',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Specialization';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: workstartController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Work Start',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Work Start';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'Gender',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          items: genderList.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            );
                          }).toList(),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                            setState(() {
                              gender = v;
                            });
                          },
                          validator: (value) {
                            if (!genderList.contains(value.toString())) {
                              return 'Please select gender';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        color: Colors.green.shade300,
                        padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                        onPressed: () async {
                          if (_registerFormKey.currentState.validate()) {
                            await addDoctor();
                          }
                        },
                        label: Text(
                          '  Add ',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: FlatButton(
                                shape: CircleBorder(),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: MediaQuery.of(context).size.height *
                                      0.045,
                                )),
/*                            child: Text(
                              'Already have an account? ',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),*/
                          ),
/*                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text('Log in',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  )),
                            ),
                          ),*/
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    docNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    countryController.dispose();
    graduationUniversityController.dispose();
    holidayController.dispose();
    hospitalController.dispose();
    medicalSpecialtyController.dispose();
    otherExperienceController.dispose();
    universityofspecializationController.dispose();
    workstartController.dispose();
    super.dispose();
  }
}
