import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:testapp/models/hospital.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:url_launcher/url_launcher.dart';

LocationManager.Location location = LocationManager.Location();

class NearbyHospitalScreen extends StatefulWidget {
  static const String id = 'Nearby_Hospital_screen';

  @override
  State<StatefulWidget> createState() {
    return NearbyHospitalScreenState();
  }
}

class NearbyHospitalScreenState extends State<NearbyHospitalScreen> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Color(0XFF3A6F8D),
            size: 28.0,
          ),
        ),
      ),
/*      appBar:TestAppAppBar(setcolor: 0xff50d490,),
        drawer: AppDrawer(),
        body: ListPage(),*/
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      drawer: AppDrawer(),
      appBar: TestAppAppBar(
        settitle: 'Hospital',
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/default_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: HospitalList(),
      ),
    );
  }
}

class HospitalList extends StatefulWidget {
  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {

  ScrollController _scrollController = ScrollController();

  bool showSpinner = true;
  HospitalData hospitalData;

  @override
  initState() {
    super.initState();
    hospitalData = HospitalData();
    hospitalData.getNearbyHospital();
  }

  double lat, tempLon;
  String locationUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: hospitalData.getNearbyHospital(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
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
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            highlightColor: Color(0XFF3A6F8D),
                          ),
                          child: Flexible(
                            child: Scrollbar(
                              isAlwaysShown: snapshot.data.hospitalList.length > 5 ? true : false,
                              controller: _scrollController,
                              thickness: 10.0,
                              radius: Radius.circular(27.0),
                              child: ListView.builder(
                                  reverse: false,
                                  controller: _scrollController,
                                  itemCount: snapshot.data.hospitalList.length,
                                  itemBuilder: (context, index) {
                                    if (index % 2 == 0) {
                                      var hosLon = snapshot.data.hospitalList[index]
                                          .hospitalLocationLongitude
                                          .toString();
                                      var hosLat = snapshot.data.hospitalList[index]
                                          .hospitalLocationLatitude
                                          .toString();

                                      return Column(
                                        children: <Widget>[
                                          Card(
                                            margin: EdgeInsets.all(15),
                                            color: Colors.white,
                                            elevation: 2.5,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: Icon(Icons.local_hospital,
                                                    size: 40, color: Colors.red),
                                              ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(snapshot
                                                        .data
                                                        .hospitalList[index]
                                                        .hospitalDistance
                                                        .toString() +
                                                    ' KM '
                                                        +snapshot
                                                            .data
                                                            .hospitalList[index].phoneNumber.toString()),
                                              ),
                                              title: snapshot
                                                          .data
                                                          .hospitalList[index]
                                                          .hospitalName !=
                                                      null
                                                  ? Text(
                                                      snapshot
                                                          .data
                                                          .hospitalList[index]
                                                          .hospitalName,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.blueGrey),
                                                    )
                                                  : Text(''),
                                              onTap: () {
                                                launch(
                                                    'https://www.google.com/maps/dir/${snapshot.data.userLocation.latitude},${snapshot.data.userLocation.longitude}/$hosLat,$hosLon');
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    } else
                                      return SizedBox();
                                  }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
          ],
        ),
      ),
    );
  }
}
