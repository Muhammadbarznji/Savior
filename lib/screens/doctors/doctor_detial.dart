import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class doctorID extends StatefulWidget {
  final DocumentSnapshot post;
  final String imagePath;

  const doctorID({this.post, this.imagePath});

  @override
  _doctorIDState createState() => _doctorIDState();
}

class _doctorIDState extends State<doctorID> {
  buildTextDetial(String titletext, String typeofdata) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 3.0),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  titletext,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  widget.post.data[typeofdata],
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.post.data['name'],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0XFF3A6F8D),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.post.data['name'],
                        style: TextStyle(
                          color: Color(0XFF3A6F8D),
                          letterSpacing: 2.0,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: AssetImage(widget.imagePath),
                          backgroundColor: Colors.grey[850],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Color(0XAA3A6F8D),
                    thickness: 3.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            buildTextDetial('Medical specialty :', 'medicalspecialty'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('country :', 'country'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('City :', 'city'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('Address :', 'address'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('Graduation University :', 'graduationuniversity'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial(
                'University of Specialization :', 'universityofspecialization'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('Holiday(s) :', 'holidays'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('Reservation Mobile No: ', 'reservationmobileno'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('Other experienced :', 'otherexperiances'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
            buildTextDetial('Work Time: ', 'workstart'),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 0.7,
            ),
          ],
        )

        /* Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.post.data['name'],
                  style: TextStyle(
                    color: Color(0XFF3A6F8D),
                    letterSpacing: 2.0,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 70.0,),
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(''),
                  backgroundColor: Colors.grey[850],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              color: Color(0XAA3A6F8D),
              thickness: 2.0,
            ),
            SizedBox(
              height: 10.0,
            ),




          ],
        ),
      ),*/
        );
  }
}
