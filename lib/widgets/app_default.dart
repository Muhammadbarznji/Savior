import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:testapp/screens/doctors/doctor_screen.dart';
import 'package:testapp/screens/home/home_screen.dart';
import 'package:testapp/screens/hospital/hospitals_screen.dart';
import 'package:testapp/screens/loading/loading_screen.dart';
import 'package:testapp/screens/profile/profile_screen.dart';

final auth = FirebaseAuth.instance;

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Drawer(
        elevation: 1.0,
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          color: Color(0XFF3A6F8D),
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: Divider.createBorderSide(context,
                                        color: Colors.transparent,
                                        width: 0.0))),
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                          'assets/images/logo.png')),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    'Savior',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 52.0,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListButtons(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          },
                          icon: 'assets/images/home_icon.png',
                          text: 'Home',
                        ),
                        ListButtons(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Doctor();
                            }));
                          },
                          icon: 'assets/images/doctor_icon.png',
                          text: 'Doctors',
                        ),
                        ListButtons(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Hospital();
                            }));
                          },
                          icon: 'assets/images/hospital_icon.png',
                          text: 'Hospitalise',
                        ),
                      ],
                    ),
                    Container(
                      color: Color(0XFFC4EBF2),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: ListButtons(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RichAlertDialog(
                                        alertTitle:
                                            richTitle("Log-out from the App"),
                                        alertSubtitle:
                                            richSubtitle('Are you Sure '),
                                        alertType: RichAlertType.WARNING,
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Yes",
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                            onPressed: () async {
                                              await auth.signOut();
                                              Navigator.pushNamed(
                                                  context, LoadingScreen.id);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("No",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: 'assets/images/log-out.png',
                              text: 'Sign Out',
                            ),
                          ),
/*                        ListButtons(
                            onTap: () {},
                            icon: Icons.share,
                            text: 'Share Companion ',
                          ),
                          ListButtons(
                            onTap: () {},
                            icon: Icons.help_outline,
                            text: 'Help and Feedback',
                          ),*/
                          SizedBox(
                            height: 5.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(500),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(500),
                              splashColor: Colors.black45,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                radius: 18.75,
                                backgroundColor: Colors.black,
                                child:
                                    Icon(Icons.arrow_back, color: Colors.white),
                              ),
                            ),
                          ),
/*                        ListButtons(
                            onTap: () {Navigator.of(context).pop();},
                            icon: Icons.arrow_back,
                            text: '',
                          ),*/
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListButtons extends StatelessWidget {
  final String text;
  final icon;
  final onTap;

  ListButtons({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 9),
      child: InkWell(
        splashColor: Color(0xffBA6ABC3),
        onTap: onTap,
        focusColor: Colors.green,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            leading: ImageIcon(
              new AssetImage(icon),
              color: Colors.black,
              size: 32.5,
            ),
          ),
        ),
      ),
    );
  }
}

/*
class FormItem extends StatelessWidget {
  final String hintText;
  final String helperText;
  final Function onChanged;
  final bool isNumber;
  final IconData icon;
  final controller;
  FormItem(
      {this.hintText,
      this.helperText,
      this.onChanged,
      this.icon,
      this.isNumber: false,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(5),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Colors.indigo, style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
        ),
        onChanged: (String value) {
          onChanged(value);
        },
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
*/

class TestAppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 56.0;
  final String settitle;

  const TestAppAppBar({this.settitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: new Image.asset(
              'assets/images/navigation_draw_icon.png',
              width: 30.0,
              height: 30.0,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //after first aid
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                settitle,
                style: TextStyle(
                  color: Colors.white,
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
          elevation: 0.0,
          actions: <Widget>[
/*            IconButton(icon: Icon(Icons.icecream), onPressed: (){
              print('User Profile');
            }),*/
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.id);
                },
                child: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.perm_identity,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
