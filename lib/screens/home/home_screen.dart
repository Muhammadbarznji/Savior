import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
        appBar: TestAppAppBar(),
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
            child: null,
          ),
        ));
  }
}
