import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:testapp/models/user.dart';
import 'package:testapp/screens/loading/loading_screen.dart';
import 'package:testapp/widgets/app_default.dart';

import 'ProfileTextBox.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'Profile_Screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId, imageUrl = '';
  FirebaseUser loggedInUser;
  File imageFile;

  final List<String> genderList = ['Male', 'Female', 'Not say'];
  final List<String> bloodGroupList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
    'Not say'
  ];

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Savior',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.8,
                  fontSize: 28,
                ),
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 70.0,
              ),
            ],
          ),
          centerTitle: true,
          elevation: 1.2,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 5.0,
              ),
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    Icons.perm_identity,
                    size: 30,
                    color: Color(0xff5e444d),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('profile')
                .document(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserProfile userProfile = UserProfile(userId);
                userProfile.setData(snapshot.data.data);
                return ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(2000),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          NetworkImage(userProfile.picture)))),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await getImage();
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ProfileTextBox(
                      name: 'userName',
                      value: userProfile.userName,
                      title: 'name',
                    ),
                    ProfileTextBox(
                      name: 'age',
                      value: userProfile.age,
                      title: 'age',
                    ),
/*                    ProfileTextBox(
                      name: 'gender',
                      value: userProfile.gender,
                      title: 'gender',
                    ),*/
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField(
                          value: userProfile.gender,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffeeeff1)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelStyle: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                            labelText: 'Gender',
                          ),
                          items: genderList.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            await Firestore.instance
                                .collection('profile')
                                .document(userId)
                                .updateData({'gender': value});
                          },
                        ),
                      ),
                    ),
                    ProfileTextBox(
                      name: 'height',
                      value: userProfile.height + ' cm',
                      title: 'height',
                    ),
                    ProfileTextBox(
                      name: 'weight',
                      value: userProfile.weight + ' Kg',
                      title: 'weight',
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField(
                          value: userProfile.bloodGroup,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffeeeff1)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelStyle: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                            labelText: 'Blood Group',
                          ),
                          items: bloodGroupList.map((blood) {
                            return DropdownMenuItem(
                              value: blood,
                              child: Text('$blood'),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            await Firestore.instance
                                .collection('profile')
                                .document(userId)
                                .updateData({'bloodGroup': value});
                          },
                        ),
                      ),
                    ),
                    ProfileTextBox(
                      name: 'bloodPressure',
                      value: userProfile.bloodPressure,
                      title: 'blood pressure',
                    ),
                    ProfileTextBox(
                      name: 'bloodSugar',
                      value: userProfile.bloodSugar,
                      title: 'blood sugar',
                    ),
                    ProfileTextBox(
                      name: 'allergies',
                      value: userProfile.allergies,
                      title: 'allergies',
                    ),
                    ProfileTextBox(
                      name: 'email',
                      value: userProfile.email,
                      title: 'email address',
                    ),
                    ProfileTextBox(
                      name: 'phoneNumber',
                      value: userProfile.phoneNumber,
                      title: 'phone number',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: FlatButton.icon(
                        height: 35.0,
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RichAlertDialog(
                                  alertTitle: Text(
                                    "Delete your Account " +
                                        '\n' +
                                        "you won't be able to access the app",
                                    style: TextStyle(fontSize: 22.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  alertSubtitle: richSubtitle('Are you Sure '),
                                  alertType: RichAlertType.WARNING,
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Yes",
                                          style: TextStyle(color: Colors.blue)),
                                      onPressed: () async {
                                        await FirebaseAuth.instance
                                            .currentUser()
                                            .then((value) => value.delete());
                                        await Firestore.instance
                                            .collection("profile")
                                            .document(userId)
                                            .delete();
                                        Navigator.pushNamed(
                                            context, LoadingScreen.id);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("No",
                                          style: TextStyle(color: Colors.red)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(
                          Icons.person_add_disabled,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Delete Account',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  child: SpinKitWanderingCubes(
                    color: Colors.green,
                    size: 100.0,
                  ),
                );
              }
            }));
  }

  updateData(String name, String value) async {
    await Firestore.instance
        .collection('profile')
        .document(userId)
        .updateData({name: value});
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile.path);
    });
    if (imageFile != null) {
      setState(() {
//        isLoading = true;
      });
      await uploadFile(userId);
    }
  }

  Future uploadFile(String name) async {
    String fileName = name;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;

      setState(() {
//        isLoading = false;
      });
      updateData('picture', imageUrl);
    }, onError: (err) {
      setState(() {
//        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Text('Not an Image.'),
            );
          });
    });
  }
}
