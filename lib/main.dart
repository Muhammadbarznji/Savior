import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/screens/doctors/doctor_screen.dart';
import 'package:testapp/screens/home/admin.dart';
import 'package:testapp/screens/home/home_screen.dart';
import 'package:testapp/screens/hospital/hospitals_screen.dart';
import 'package:testapp/screens/loading/nointernet_screen.dart';
import 'package:testapp/screens/loading/loading_screen.dart';
import 'package:testapp/screens/loading/onBoarding_screen.dart';
import 'package:testapp/screens/login/login_screen.dart';
import 'package:testapp/screens/medkit/firstaid.dart';
import 'package:testapp/screens/medkit/meddetails.dart';
import 'package:testapp/screens/profile/profile_screen.dart';
import 'others/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    precacheImage(AssetImage('assets/images/loadingimage.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Savior App',
      initialRoute: LoadingScreen.id,
      routes: {
        Admin.id : (context) => Admin(),
        HomeScreen.id: (context) => HomeScreen(),
        LoadingScreen.id: (context) => LoadingScreen(
              auth: Auth(),
            ),
        LoginScreen.id: (context) => LoginScreen(
              auth: Auth(),
            ),
        ProfileScreen.id: (context) => ProfileScreen(),
        //ProfileEdit.id: (context) => ProfileEdit(),
        Hospital.id: (context) => Hospital(),
        Doctor.id: (context) => Doctor(),
        FirstAid.id: (context) => FirstAid(),
        MedDetails.id: (context) => MedDetails(),
        NoInternetConnection.id: (context) => NoInternetConnection(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
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
