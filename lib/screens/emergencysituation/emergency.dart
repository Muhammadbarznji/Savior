import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:testapp/models/Sick_location.dart';
import 'package:testapp/models/hospital.dart';
import 'package:testapp/models/user.dart';
import 'package:testapp/widgets/app_default.dart';

LocationManager.Location location = LocationManager.Location();

class EmergencySituation extends StatefulWidget {
  static const String id = 'Emergency_Situation';

  @override
  State<StatefulWidget> createState() {
    return EmergencySituationState();
  }
}

class EmergencySituationState extends State<EmergencySituation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Color(0XFF3A6F8D),
            size: 28.0,
          ),
        ),
      ),
/*      appBar:TestAppAppBar(setcolor: 0xff50d490,),
        drawer: AppDrawer(),
        body: ListPage(),*/
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      drawer: AppDrawer(),
      appBar: TestAppAppBar(
        settitle: 'Emergency',
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/default_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: HospitalList(),
      ),
    );
  }
}

class HospitalList extends StatefulWidget {
  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  bool showSpinner = true;
  HospitalData hospitalData;
  SickLocation sickLocation;
  String messageText = '', username = '', userId;
  bool relativesFound = false;
  UserProfile userProfile;
  FirebaseUser user;

  List<String> recipients;

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
        print(userId);
      });
    });
  }

  Future<void> _getUserName() async {
    Firestore.instance
        .collection('profile')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        username = value.data['userName'].toString();
      });
    });
  }

  getLocationDetails() async {
    await sickLocation.getLocationData();
    messageText =
        'Hey , This is $username, find me at ${sickLocation.address} .\n Link to my location : ${sickLocation.url}';
    return sickLocation;
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

/*  _sendSMS(String message, List<String> recipients) async {
    List<String> recipients = ["9647503275785"];
    String _result = await sendSMS(
            message: "https://testdynamiclink.page.link/Zi7X",
            recipients: recipients)
        .catchError((onError) {
      print(onError);
    });
    print(_result);

*/ /*    String _result = await sendSMS(message: message, recipients: recipients)
        .catchError((onError) {
      print(onError);
    });

    print(_result);*/ /*
  }*/

  @override
  initState() {
    super.initState();
    hospitalData = HospitalData();
    hospitalData.getNearbyHospital();
    getCurrentUser();
    _getUserName();
    userProfile = UserProfile(userId);
    sickLocation = SickLocation();
    recipients = List<String>();
    getLocationDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: hospitalData.getNearbyHospital(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitFadingCube(
                            color: Color(0XFF59C38F),
                            size: 100.0,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Fetching data . Please wait ..'),
                          ),
                          Text(' It may take a few moments .'),
                        ],
                      ),
                    );
                  } else {
                    String phoneNumberResult, hospitalName;
                    for (var r in hospitalData.hospitalList) {
                      if (r.phoneNumber != null) {
                        RegExp regPhoneNumber = RegExp(
                            r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3,4})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$");
                        RegExp regName = RegExp(r"^(.*?(\bhospital\b)[^$]*)$");
                        if (regPhoneNumber.hasMatch(r.phoneNumber) &&
                            regName.hasMatch(r.hospitalName.toLowerCase())) {
                          phoneNumberResult = r.phoneNumber.toString();
                          recipients.add(phoneNumberResult);
                          hospitalName = r.hospitalName;
                          print("is match with number: " +
                              regPhoneNumber
                                  .hasMatch(r.phoneNumber)
                                  .toString());
                          relativesFound = true;
                          break;
                        } else {
                          phoneNumberResult = 'not found';
                          hospitalName = 'not found';
                        }
                        //re = r.phoneNumber.toString();
                      }
                    }
/*                    return Center(
                      child: Text(
                        phoneNumberResult + '\n' +  hospitalName,
                        style: TextStyle(fontSize: 25.0),
                      ),
                    );*/
                    if (relativesFound) {
                      return Center(
                        child: GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RichAlertDialog(
                                    alertTitle: richTitle("Alert Relatives"),
                                    alertSubtitle:
                                        richSubtitle('Are you Sure '),
                                    alertType: RichAlertType.INFO,
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () async {
                                          if (relativesFound) {
                                            Navigator.pop(context);
                                            print('hello from sms');
                                            _sendSMS(messageText, recipients);
                                            print(messageText);
                                          }
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                hospitalName + '\n\n' + phoneNumberResult,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 55.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.redAccent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red,
                                      blurRadius: 3.0,
                                      offset: Offset(0, 4.0),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Contact Relatives',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/notfound_icon.png',
                              scale: 3.0,
                            ),
                            Text('Sorry can not find any Hospital'),
                            Text('please try again'),
                            SizedBox(
                              height: 10.0,
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, EmergencySituation.id);
                              },
                              child: Text(
                                'Refresh',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color(0XFF59C38F),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
          ],
        ),
      ),
    );
  }
}
