import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/models/doctor_data.dart';
import 'package:testapp/others/constants.dart';
import 'package:testapp/screens/loading/waiting_screen.dart';
import 'package:testapp/screens/profile/profile_edit_screen.dart';
import 'package:testapp/widgets/app_default.dart';

class UserListScreen extends StatefulWidget {
  static const String id = 'User_List_Screen';

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
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
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      drawer: AppDrawer(),
      appBar: TestAppAppBar(
        settitle: 'Users',
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
        var name = doctor_data.fromSnapshot(tripSnapshot).name.toLowerCase();

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
    var data = await Firestore.instance.collection('profile').getDocuments();
    setState(() {
      _allResults = data.documents;
    });
    searchResultsList();
    return "complete";
  }

  Future getPost() async {
    var firestore = await Firestore.instance;
    QuerySnapshot query = await firestore.collection('profile').getDocuments();
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
                "List of user",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF3A6F8D),
                    letterSpacing: 1.5),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
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
/*                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingScreen(auth: Auth()),
                    );
                  }*/
                  if (!snapshot.hasData) {
                    return WaittingScreen();
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
  navigateToDetial(DocumentSnapshot documentSnapshot) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileEditScreen(post: documentSnapshot)));
  }

  _pickUpImageForUser() {
    if (document.data['role']) {
      return 'assets/images/administrator.png';
    } else {
      return 'assets/images/groupuser.png';
    }
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.0),
    child: Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 10.0, 0.0),
      child: ListTile(
/*        trailing: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: FlatButton.icon(
            onPressed: () async {
              print('delete');
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 35.0,
            ),
            label: Text(''),
          ),
        ),*/
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 67.0,
            minHeight: 120.0,
            maxWidth: 100.0,
            maxHeight: 120.0,
          ),
          //child: new Image.network(trip.image),
          child: Image.asset(
            _pickUpImageForUser(),
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          document.data['userName'],
          style: TextStyle(fontSize: 20.0),
        ),
        subtitle: Text(document.data['role'] ? 'Admin' : 'User',
            style: TextStyle(fontSize: 16.0)),
        onTap: () => navigateToDetial(document),
      ),
    ),
  );
}
