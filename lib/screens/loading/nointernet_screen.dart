import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NoInternetConnection extends StatelessWidget {
  static const String id = 'NoInternetConnection_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/no-wifi.png',
                scale: 1.8,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Whoops!',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'No Internet Connection found. Check',
                style: TextStyle(color: Colors.grey[600], fontSize: 20.0),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                'your connection',
                style: TextStyle(color: Colors.grey[600], fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Automatic refresh after 10 seconds',
                style: TextStyle(color: Colors.grey[700], fontSize: 15.0),
              ),
              SizedBox(
                height: 40.0,
              ),
              SpinKitCircle(
                color: Colors.greenAccent,
                size: 65.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
