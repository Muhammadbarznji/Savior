import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/screens/home/home_screen.dart';
import 'package:testapp/screens/home/home_screen_admin.dart';
import 'package:testapp/screens/loading/loading_screen.dart';
import 'package:testapp/screens/login/login_screen.dart';

import 'others/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/loadingimage.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      initialRoute: LoadingScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        HomeScreenAdmin.id: (context) => HomeScreenAdmin(),
        LoadingScreen.id: (context) => LoadingScreen(auth: Auth(),),
        LoginScreen.id: (context) => LoginScreen(auth: Auth(),),
      },
      theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white,
          textTheme:
              TextTheme().apply(fontFamily: GoogleFonts.lato().fontFamily)),
    );
  }
}