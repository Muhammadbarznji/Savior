import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/models/doctor_data.dart';
import 'package:testapp/others/auth.dart';
import 'package:testapp/screens/doctors/doctor_detial.dart';
import 'package:testapp/screens/loading/loading_screen.dart';
import 'package:testapp/screens/loading/waiting_screen.dart';


class ListOfDoctorInHospital extends StatefulWidget {

  final String hospitalName;

  ListOfDoctorInHospital({this.hospitalName});

  @override
  _ListOfDoctorInHospitalState createState() => _ListOfDoctorInHospitalState();
}

class _ListOfDoctorInHospitalState extends State<ListOfDoctorInHospital> {

  Future _data;
  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  ScrollController _scrollController = ScrollController();
  //TextEditingController _searchController = TextEditingController();



  void initState() {
    super.initState();
    _data = getPost();
    //_searchController.addListener(_onSearchChanged);
    _onSearchChanged();
  }

/*  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }*/

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }


  searchResultsList() {
    var showResults = [];

    for (var tripSnapshot in _allResults) {
      var hospital = doctor_data.fromSnapshot(tripSnapshot).hospital.toLowerCase();

      if (hospital.contains(widget.hospitalName.toLowerCase())) {
        showResults.add(tripSnapshot);
      }
    }
    setState(() {
      _resultsList = showResults;
    });
  }


  getUsersPastTripsStreamSnapshots() async {
    var data = await Firestore.instance.collection('doctor').getDocuments();
    setState(() {
      _allResults = data.documents;
    });
    searchResultsList();
    return "complete";
  }

  Future getPost() async {
    var firestore = await Firestore.instance;
    QuerySnapshot query = await firestore.collection('doctor').getDocuments();
    return query.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 7.0, 0.0, 7.0),
                child: Text(
                  "List of Doctor:",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF3A6F8D),
                      letterSpacing: 1.5),
                ),
              ),
            ],
          ),
/*            Padding(
            padding:
            const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
            child: TextField(
              controller: _searchController,
              decoration: textInputDecoration.copyWith(
                hintText: 'Search',
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0XFF3A6F8D),
                  size: 27.5,
                ),
              ),
            ),
          ),*/
          Expanded(
            child: FutureBuilder(
              future: _data,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return WaittingScreen();
                } else {
                  return Theme(
                    data: ThemeData(
                      highlightColor: Color(0XFF3A6F8D),
                    ),
                    child: Scrollbar(
                      isAlwaysShown: _resultsList.length > 3 ? true : false,
                      controller: _scrollController,
                      thickness: 10.0,
                      radius: Radius.circular(27.0),
/*                      child: ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        itemCount: 50,
                        itemBuilder: (context, index) => ListTile(
                          title: Text("Item= ${index + 1}"),
                        ),
                      ),*/
                      child: ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        itemCount: _resultsList.length,
                        itemBuilder: (context, index) =>
                            buildDoctorCard(context, _resultsList[index]),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }
}

Widget buildDoctorCard(BuildContext context, DocumentSnapshot document) {
  final doctorData = doctor_data.fromSnapshot(document);

  navigateToDetial(DocumentSnapshot documentSnapshot,String imagepath) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => doctorID(post: documentSnapshot,imagePath: imagepath,)));
  }

  pickUpImageForDoctor(){
    if(doctorData.gender.toString().toLowerCase() == 'male'){
      return 'assets/images/drMale.png';
    }else{
      return 'assets/images/drFemale.png';
    }
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.0),
    child: Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 67.0,
            minHeight: 120.0,
            maxWidth: 100.0,
            maxHeight: 120.0,
          ),
          //child: new Image.network(trip.image),
          child: Image.asset(pickUpImageForDoctor(),fit: BoxFit.fill,),
        ),
        title: Text(doctorData.name,style: TextStyle(fontSize: 20.0),),
        subtitle: Text('${doctorData.medicalspecialty} \n'
            'City: ${doctorData.city} \n'
            'Work Tome: Form : ${doctorData.workstart}',
          style: TextStyle(fontSize: 16.0),),
        onTap: () => navigateToDetial(document,pickUpImageForDoctor()),
      ),
    ),
  );
}