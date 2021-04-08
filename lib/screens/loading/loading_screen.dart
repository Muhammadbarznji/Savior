import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testapp/others/auth.dart';
import 'package:testapp/screens/home/admin.dart';
import 'package:testapp/screens/home/home_screen.dart';
import 'package:testapp/screens/loading/nointernet_screen.dart';
import 'package:testapp/screens/loading/waiting_screen.dart';
import 'package:testapp/screens/login/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'Loading_Screen';

  LoadingScreen({@required this.auth});


  final AuthBase auth;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Image myImage;

  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    myImage = Image.asset('assets/images/loadingimage.jpg');
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;
      default:
        setState(() => _connectionStatus = false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus
        ? StreamBuilder<User>(
            stream: widget.auth.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;
                if (user == null) {
                  return LoginScreen(
                    auth: widget.auth,
                  );
                } else {
                    return new StreamBuilder(
                        stream: Firestore.instance.collection('profile').document(user.uid).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return WaittingScreen();
                          }
                          var userDocument = snapshot.data;
                          if(userDocument['role']) {
                            return Admin();
                          }else{
                            return HomeScreen();
                          }
                        }
                    );
                }
              } else {
                return Scaffold(
                  body: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: myImage,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Savior',
                              style: TextStyle(
                                fontSize: 30.0,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Savior is Loading',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SpinKitFadingCube(
                          color: Color(0XFF59C38F),
                          size: 50.0,
                        ),
                      )
                    ],
                  ),
                );
              }
            })
        : NoInternetConnection();
  }
}
