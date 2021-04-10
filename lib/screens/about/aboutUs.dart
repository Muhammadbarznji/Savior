import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens/home/home_screen.dart';
import 'package:testapp/widgets/app_default.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.04, 0, 0),
              child: FlatButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: MediaQuery.of(context).size.height * 0.045,
                  )),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.07),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        height: height * 0.20,
                      ),
                      Text(
                        'Developer Student Club',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Developed By: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.028),
                      ),
                      Text(
                        'Rayan Ibrahim'
                        '\n Muhammad Azad'
                        '\nSazan Hamad'
                        '\n Noora fkry'
                        '\n Ziba Muhammad'
                        '\n Bnar saaed',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: height * 0.024),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        'Supervisor: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.028),
                      ),
                      Text(
                        'Dr.Roojwan Sdeeq Hawezi',
                        style: TextStyle(fontSize: height * 0.024),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Image.asset(
                        'assets/images/EPU_logo.png',
                        height: height * 0.08,
                      ),
                      Text('Erbil Polytechnic University, ISED',
                          style: TextStyle(
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.bold)),
                      Text('@Copyrights All Rights Reserved, 2021',
                          style: TextStyle(fontSize: height * 0.02))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
