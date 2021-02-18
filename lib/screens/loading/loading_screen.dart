import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testapp/others/auth.dart';
import 'package:testapp/screens/home/home_screen.dart';
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

  @override
  void initState() {
    super.initState();
    myImage = Image.asset('assets/images/loadingimage.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: widget.auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginScreen(
                auth: widget.auth,
              );
            }

            return HomeScreen();
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
                          'Test',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        Text(
                          'APP',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Test APP is Loading',
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
                      color: Colors.greenAccent,
                      size: 50.0,
                    ),
                  )
                ],
              ),
            );
          }
        }
        );
  }
}
