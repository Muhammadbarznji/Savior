import 'package:flutter/material.dart';
import 'package:testapp/others/auth.dart';
import 'package:testapp/screens/login/login_screen.dart';

class Admin extends StatefulWidget {
  static const String id = 'Admin';
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.0,),
          Text('Hello From Admin'),
          Center(
            child: FlatButton.icon(
              icon: Icon(Icons.logout),
              label: Text("Sign Out"),
              onPressed: () async {
                await Auth().signOut();
                Navigator.popAndPushNamed(context, LoginScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
