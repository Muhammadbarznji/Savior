import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:testapp/widgets/bottomAnimation.dart';
import 'package:url_launcher/url_launcher.dart';


class MapUtils {
  MapUtils._();

  static Future<void> openMap(String location) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class MedDetails extends StatefulWidget {
  final DocumentSnapshot snapshot;

  MedDetails({@required this.snapshot});

  @override
  _MedDetailsState createState() => _MedDetailsState();
}

class _MedDetailsState extends State<MedDetails> {
  var location = new Location();
  var currentLocation = LocationData;

  check(){
    String re = widget.snapshot.data['meddesc'].toString();
    if(re.startsWith('1-')){
      return true;
    }return false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.02),
                width: width * 0.75,
                child: Opacity(
                    opacity: 0.3,
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/pill.png'),
                          height: height * 0.1,
                        ),
                        Image(
                          image: AssetImage('assets/images/syrup.png'),
                          height: height * 0.1,
                        ),
                        Image(
                          image: AssetImage('assets/images/tablets.png'),
                          height: height * 0.07,
                        ),
                        Image(
                          image: AssetImage('assets/images/injection.png'),
                          height: height * 0.07,
                        )
                      ],
                    )),
              ),
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BackBtn(),
                Container(
                    width: width,
                    margin:
                    EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.snapshot.data['title'],
                              style: GoogleFonts.abel(fontSize: height * 0.06),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Medicine: ',
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                            WidgetAnimator(
                              Text(
                                widget.snapshot.data['medname'],
                                style: GoogleFonts.averageSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.03),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Dose: ',
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                            WidgetAnimator(
                              Text(
                                widget.snapshot.data['medtime'],

                                style: GoogleFonts.averageSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.03),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          width: width,
                          height: height * 0.43,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            children: <Widget>[
                              Text(
                               // widget.snapshot.data['meddesc'].toString().split(RegExp(r"\d+")).toString(),
                                widget.snapshot.data['meddesc'],
                                style: TextStyle(height: 1.6, fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        WidgetAnimator(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.warning,
                                size: height * 0.02,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                'See a Doctor if condition gets Worse!',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: SizedBox(
                            width: width,
                            height: height * 0.075,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: StadiumBorder(),
                              onPressed: () {
                                MapUtils.openMap('Pharmacy near me');
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    WidgetAnimator(Image.asset(
                                      'assets/images/mapicon.png',
                                      height: height * 0.045,
                                    )),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      'Search Nearest Pharmacy',
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.021),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
