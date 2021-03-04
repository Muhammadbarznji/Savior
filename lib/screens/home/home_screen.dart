import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/others/screen_size.dart';
import 'package:testapp/screens/doctors/doctor_screen.dart';
import 'package:testapp/screens/hospital/hospitals_screen.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:testapp/widgets/home_screen_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
/*    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
//        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text("Title"),
      ),
      body: Center(child: Text("Content")),
    );*/

    return Scaffold(
        //endDrawerEnableOpenDragGesture: false,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        drawer: AppDrawer(),
        appBar: TestAppAppBar(settitle: 'Savior',),
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
                                icon: FontAwesomeIcons.hospital,
                                size: screenWidth * (25 / 100),
                                color: Color(0xff7b1fa2),
                                borderColor: Color(0xff7b1fa2).withOpacity(0.75),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Hospital.id);
                              },
                            ),


                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text('Hospital',style: TextStyle(),),
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
                                icon: FontAwesomeIcons.userMd,
                                size: screenWidth * 0.2,
                                color: Colors.blueAccent,
                                borderColor: Colors.blueAccent.withOpacity(0.75),
                              ),
                              onTap: () {
                                print('Doctors');
                                Navigator.pushNamed(context, Doctor.id);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text('Doctors'),
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
