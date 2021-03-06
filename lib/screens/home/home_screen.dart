import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/others/screen_size.dart';
import 'package:testapp/screens/doctors/doctor_screen.dart';
import 'package:testapp/screens/hospital/hospitals_screen.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:testapp/widgets/home_screen_widgets.dart';


class HomeScreen extends StatefulWidget {
  static const String id = 'Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

    homeScreenTextStyle(String title) {
      return Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF3A6F8D),
        ),
      );
    }

    return Scaffold(
        //endDrawerEnableOpenDragGesture: false,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        drawer: AppDrawer(),
        appBar: TestAppAppBar(
          settitle: 'Savior',
        ),
        body: WillPopScope(
          onWillPop: () async {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RichAlertDialog(
                    alertTitle: richTitle("Exit the App"),
                    alertSubtitle: richSubtitle('Are you Sure '),
                    alertType: RichAlertType.WARNING,
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          SystemNavigator.pop();
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
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.08,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              splashColor: Colors.purple,
                              child: CardButton(
                                height: screenHeight * 0.2,
                                width: screenWidth * (35 / 100),
                                imagepath: Image.asset('assets/images/hospital_image.png'),
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
                              splashColor: Colors.blueAccent,
                              child: CardButton(
                                height: screenHeight * (20 / 100),
                                width: screenWidth * (35 / 100),
                                imagepath: Image.asset('assets/images/doctor_image.png'),
                              ),
                              onTap: () {
                                print('Doctors');
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
                ],
              ),
            ),
          ),

        ));
  }
}
