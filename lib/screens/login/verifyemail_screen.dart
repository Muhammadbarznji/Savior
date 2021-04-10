import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens/loading/onBoarding_screen.dart';

class VerifyScreen extends StatefulWidget {
  static const String id = 'Ver';
  FirebaseUser user;

  VerifyScreen({this.user});

  @override
  _VerifyScreenState createState() => _VerifyScreenState(user);
}

class _VerifyScreenState extends State<VerifyScreen> {
  FirebaseUser user;
  Timer timer;

  _VerifyScreenState(this.user);

  @override
  void initState() {
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'An email has been sent to ${user.isEmailVerified} please verify'),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    await user.reload();
    print('reload email ver');
    if (user.isEmailVerified) {
      timer.cancel();
      print('verified email');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return OnBoardingScreen();
      }));
    }
  }
}
