import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/screens/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.0,),
          Text('Hello From User'),
          Center(
            child: FlatButton.icon(
              icon: Icon(Icons.logout),
              label: Text("Sign Out"),
              onPressed: () async {
                await _auth.signOut();
                Navigator.popAndPushNamed(context, LoginScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
