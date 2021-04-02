import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WaittingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
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
        ),
      );
  }
}
