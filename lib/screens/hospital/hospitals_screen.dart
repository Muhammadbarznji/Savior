import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/models/hospital_data.dart';
import 'package:testapp/others/auth.dart';
import 'package:testapp/screens/loading/loading_screen.dart';
import 'package:testapp/widgets/app_default.dart';
import 'package:testapp/widgets/constant.dart';
import 'hospital_detail.dart';

class Hospital extends StatefulWidget {
  static const String id = 'Hospital';

  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
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
        var name = hospital_data.fromSnapshot(tripSnapshot).name.toLowerCase();

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

/*  getUsersPastTripsStreamSnapshots() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    var data = await Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('trips')
        .where("endDate", isLessThanOrEqualTo: DateTime.now())
        .orderBy('endDate')
        .getDocuments();
    setState(() {
      _allResults = data.documents;
    });
    searchResultsList();
    return "complete";
  }*/

  getUsersPastTripsStreamSnapshots() async {
    var data = await Firestore.instance.collection('hospital').getDocuments();
    setState(() {
      _allResults = data.documents;
    });
    searchResultsList();
    return "complete";
  }

  Future getPost() async {
    var firestore = await Firestore.instance;
    QuerySnapshot query = await firestore.collection('hospital').getDocuments();
    return query.documents;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
              child: Text(
                "List of Hospital",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF3A6F8D),
                    letterSpacing: 1.5),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                 // const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingScreen(auth: Auth()),
                    );
                  } else {
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
                              buildHospitalCard(context, _resultsList[index]),
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

Widget buildHospitalCard(BuildContext context, DocumentSnapshot document) {
  final hospitalData = hospital_data.fromSnapshot(document);

  navigateToDetial(DocumentSnapshot documentSnapshot) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(documentSnapshot)));
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.0),
    child: Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 40,
            minHeight: 40,
            maxWidth: 60,
            maxHeight: 60,
          ),
          //child: new Image.network(hospitalData.image),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: Text(hospitalData.name),
        subtitle: Text(hospitalData.phone),
        onTap: () => navigateToDetial(document),
      ),
    ),
  );
}

//make a different class for that
/*
class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage(this.post);
  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.data['name']),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.post.data['name']),
            subtitle: Text(widget.post.data['phone']),
          ),
        ),
      ),
    );
  }
}
*/
