import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/others/auth.dart';
import 'package:testapp/screens/loading/loading_screen.dart';
import 'package:testapp/widgets/app_default.dart';

class Doctor extends StatefulWidget {
  static const String id = 'Doctor';

  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      drawer: AppDrawer(),
      appBar: TestAppAppBar(
        settitle: 'Doctor',
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

  void initState() {
    super.initState();
    _data = getPost();
  }

  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot query = await firestore.collection('doctor').getDocuments();
    return query.documents;
  }

  navigateToDetial(DocumentSnapshot post) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage(post)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingScreen(auth: Auth()),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
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
                          ), //agar null bu defult bgarentawa agrna image
                          child: Image.asset('assets/images/doctor_icon.png'),
                        ),
                        title: Text(snapshot.data[index].data['name']),
                        subtitle: Text(snapshot.data[index].data['phone']),
                        onTap: () => navigateToDetial(snapshot.data[index]),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

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
