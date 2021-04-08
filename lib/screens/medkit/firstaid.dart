import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/models/firstaid_data.dart';
import 'package:testapp/others/constants.dart';
import 'package:testapp/screens/loading/waiting_screen.dart';
import 'package:testapp/screens/medkit/meddetails.dart';
import 'package:testapp/widgets/app_default.dart';

import 'add_new_firsaid.dart';



class FirstAid extends StatefulWidget {
  static const String id = 'First_Aid';

  @override
  _FirstAidState createState() => _FirstAidState();
}

class _FirstAidState extends State<FirstAid> {

  String userId;


  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child:                     new StreamBuilder(
            stream: Firestore.instance.collection('profile').document(userId).snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return WaittingScreen();
              }
              var userDocument = snapshot.data;
              if(userDocument['role']) {
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return AddNewFirstAid();
                        }));
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  child: Icon(
                    Icons.add_circle_sharp,
                    color: Colors.red,
                    size: 65.0,
                  ),
                );
              }else{
                return FloatingActionButton(
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
                );
              }
            }
        ),

      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      drawer: AppDrawer(),
      appBar: TestAppAppBar(
        settitle: 'First Aid',
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/default_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListPage(),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;
  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  void initState() {
    super.initState();
    _data = getPost();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

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

    if (_searchController.text != "") {
      for (var tripSnapshot in _allResults) {
        var name = FirstAid_data.fromSnapshot(tripSnapshot).title.toLowerCase();

        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    var data = await Firestore.instance.collection('firstaid').getDocuments();
    setState(() {
      _allResults = data.documents;
    });
    searchResultsList();
    return "complete";
  }

  Future getPost() async {
    var firestore = await Firestore.instance;
    QuerySnapshot query = await firestore.collection('firstaid').getDocuments();
    return query.documents;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0,vertical: 25.0),
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
            ),
            Expanded(
              child: FutureBuilder(
                future: _data,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return WaittingScreen();
                  }
                    else {
                    return Theme(
                      data: ThemeData(
                        highlightColor: Color(0XFF3A6F8D),
                      ),
                      child: Scrollbar(
                        isAlwaysShown: _resultsList.length > 5 ? true : false,
                        controller: _scrollController,
                        thickness: 10.0,
                        radius: Radius.circular(27.0),
/*                        child: ListView.builder(
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
              height: 80.0,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDoctorCard(BuildContext context, DocumentSnapshot document) {
  final FirstAiddata = FirstAid_data.fromSnapshot(document);

  navigateToDetial(DocumentSnapshot documentSnapshot) {
    print('Med Details');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MedDetails(snapshot: documentSnapshot)));
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.0),
    child: Card(
      color: Color(0XFFC4EBF2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(

/*        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 67.0,
            minHeight: 120.0,
            maxWidth: 100.0,
            maxHeight: 120.0,
          ),
          //child: new Image.network(trip.image),
          child: Image.asset(pickUpImageForDoctor(),fit: BoxFit.fill,),
        ),*/
        title: Center(child: Text(FirstAiddata.title,style: TextStyle(fontSize: 23.5,),)),
/*        subtitle: Text('${doctorData.medicalspecialty} \n'
            'City: ${doctorData.city} \n'
            'Work Tome: Form : ${doctorData.workstart}',
          style: TextStyle(fontSize: 16.0),),*/
        onTap: () => navigateToDetial(document),
      ),
    ),
  );
}

