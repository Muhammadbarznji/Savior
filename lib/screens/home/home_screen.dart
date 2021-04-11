import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart'
    as PermissionManager;
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:testapp/others/screen_size.dart';
import 'package:testapp/screens/doctors/doctor_screen.dart';
import 'package:testapp/screens/emergencysituation/emergency.dart';
import 'package:testapp/screens/hospital/hospitals_screen.dart';
import 'package:testapp/screens/medkit/firstaid.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:testapp/widgets/home_screen_widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool permissionGranted = false;
  bool serviceEnabled = false;
  PermissionManager.PermissionStatus permission;

  Future checkLocationPermission() async {
    permission = await PermissionManager.PermissionHandler()
        .checkPermissionStatus(PermissionManager.PermissionGroup.location);
    PermissionManager.ServiceStatus serviceStatus =
        await PermissionManager.PermissionHandler()
            .checkServiceStatus(PermissionManager.PermissionGroup.location);

    if (permission == PermissionManager.PermissionStatus.granted) {
      setState(() {
        permissionGranted = true;
      });

      if (serviceStatus == PermissionManager.ServiceStatus.enabled) {
        setState(() {
          serviceEnabled = true;
        });
      } else {
        await location.requestService();
      }
    } else if (permission == PermissionManager.PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog(
                alertTitle: richTitle("Exit the App"),
                alertSubtitle: richSubtitle('Are you Sure '),
                alertType: RichAlertType.WARNING,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes", style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  FlatButton(
                    child: Text("No", style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            })) ??
        false;
  }

  @override
  Widget build(BuildContext context) {

/*    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

    homeScreenTextStyle(String title) {
      return Text(
        title,
        style: TextStyle(
          fontSize: 23.5,
          fontWeight: FontWeight.bold,
          color: Color(0XFF3A6F8D),
        ),
        textAlign: TextAlign.center,
      );
    }*/

    return Scaffold(
      //endDrawerEnableOpenDragGesture: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      drawer: AppDrawer(),
      appBar: TestAppAppBar(
        settitle: 'Savior',
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/homepagebg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return true;
            },
            child: ListHomeButton(),
          ),
        ),
      ),
    );
  }
}

class ListHomeButton extends StatefulWidget {
  @override
  _ListHomeButtonState createState() => _ListHomeButtonState();
}

class _ListHomeButtonState extends State<ListHomeButton> {
  bool permissionGranted = false;
  bool serviceEnabled = false;
  PermissionManager.PermissionStatus permission;

  Future checkLocationPermission() async {
    permission = await PermissionManager.PermissionHandler()
        .checkPermissionStatus(PermissionManager.PermissionGroup.location);
    PermissionManager.ServiceStatus serviceStatus =
        await PermissionManager.PermissionHandler()
            .checkServiceStatus(PermissionManager.PermissionGroup.location);

    if (permission == PermissionManager.PermissionStatus.granted) {
      setState(() {
        permissionGranted = true;
      });

      if (serviceStatus == PermissionManager.ServiceStatus.enabled) {
        setState(() {
          serviceEnabled = true;
        });
      } else {
        await location.requestService();
      }
    } else if (permission == PermissionManager.PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

    homeScreenTextStyle(String title) {
      return Text(
        title,
        style: TextStyle(
          fontSize: 23.5,
          fontWeight: FontWeight.bold,
          color: Color(0XFF3A6F8D),
        ),
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 65.0),
        child: ListView(
          //itemExtent: screenWidth,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: CardButton(
                          height: screenHeight * 0.2,
                          width: screenWidth * (35 / 100),
                          imagepath:
                              Image.asset('assets/images/hospital_image.png'),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, Hospital.id);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.7),
                        child: homeScreenTextStyle('Hospital'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: CardButton(
                          height: screenHeight * (20 / 100),
                          width: screenWidth * (35 / 100),
                          imagepath:
                              Image.asset('assets/images/doctor_image.png'),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, Doctor.id);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: homeScreenTextStyle('Doctor'),
                      )
                    ],
                  ),
                )
              ],
            ),

            //Space between row
            SizedBox(
              height: screenHeight * 0.03,
            ),

            //second row
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: CardButton(
                          height: screenHeight * 0.2,
                          width: screenWidth * (35 / 100),
                          imagepath: Image.asset('assets/images/firstaid.png'),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, FirstAid.id);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.7),
                        child: homeScreenTextStyle('First Aid'),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: CardButton(
                          height: screenHeight * 0.2,
                          width: screenWidth * (35 / 100),
                          imagepath: Image.asset('assets/images/emc.png'),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, EmergencySituation.id);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.7),
                        child: homeScreenTextStyle('EMC'),
                      ),
                    ],
                  ),
                ),

/*                Expanded(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: CardButton(
                          height: screenHeight * 0.2,
                          width: screenWidth * (35 / 100),
                          imagepath: Image.asset(
                              'assets/images/hospital_location.png'),
                        ),
                        onTap: () async {
                          await checkLocationPermission();
                          if (serviceEnabled && permissionGranted) {
                            Navigator.pushNamed(
                                context, n.NearbyHospitalScreen.id);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.7),
                        child: homeScreenTextStyle('Locate Nearby Hospital'),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
