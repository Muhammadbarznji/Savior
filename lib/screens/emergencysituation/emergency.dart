import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:testapp/models/Sick_location.dart';
import 'package:testapp/models/hospital.dart';
import 'package:testapp/models/user.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:flutter_sms/flutter_sms.dart';

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
        settitle: 'EMC',
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
  double lat, tempLon;
  String locationUrl;
  SickLocation elderLocation;
  String messageText = '', username = 'user', userId;
  bool relativesFound = false;
  UserProfile userProfile;

  List<String> recipients;

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  getLocationDetails() async {
    await elderLocation.getLocationData();
    messageText =
        'Hey , This is $username find me at ${elderLocation.address} .\n Link to my location : ${elderLocation.url}';
    return elderLocation;
  }

  _sendSMS(String message, List<String> recipients) async {
    List<String> recipients = ["9647503275785"];
    String _result = await sendSMS(
            message: "https://testdynamiclink.page.link/Zi7X",
            recipients: recipients)
        .catchError((onError) {
      print(onError);
    });
    print(_result);

/*    String _result = await sendSMS(message: message, recipients: recipients)
        .catchError((onError) {
      print(onError);
    });

    print(_result);*/
  }

  @override
  initState() {
    super.initState();
    hospitalData = HospitalData();
    hospitalData.getNearbyHospital();
    super.initState();
    getCurrentUser();
    userProfile = UserProfile(userId);
    elderLocation = SickLocation();
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
                    return Center(
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RichAlertDialog(
                                  alertTitle: richTitle("Alert Relatives"),
                                  alertSubtitle: richSubtitle('Are you Sure '),
                                  alertType: RichAlertType.INFO,
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        if (relativesFound) {
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
