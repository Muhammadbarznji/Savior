import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'file:///C:/Users/kimmm/AndroidStudioProjects/testapp/lib/widgets/readpdf.dart';
import 'package:testapp/others/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';

class doctorID extends StatefulWidget {
  final DocumentSnapshot post;
  final String imagePath;

  const doctorID({this.post, this.imagePath});

  @override
  _doctorIDState createState() => _doctorIDState();
}

class _doctorIDState extends State<doctorID> {

  PDFDocument doc;

  //function for Text field
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
                Container(
                  width: getDeviceWidth(context) * 0.8,
                  child: Text(
                    widget.post.data[typeofdata] != null ? widget.post.data[typeofdata]:'',
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
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

    //if pdf file can not found this fun handle that
    Dialog noDataFound = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 150.0,
        width: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('can not found CV!',style: TextStyle(fontSize: 20.0),),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );

    //for lunch contact and chose between call or message
    Dialog contactDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 220.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/phone-call.png',
                      scale: 5.5,
                    ),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Text(
                      'Call',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                onTap: () async{
                  await launch("tel://${widget.post.data['reservationmobileno']}");
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/send-message.png',
                      scale: 5.5,
                    ),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Text(
                      'Message',
                      style: TextStyle(
                        color: Colors.yellow[600],
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                onTap: () async{
                  String uri = 'sms:${widget.post.data['reservationmobileno']}?body=';
                  await launch(uri);
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,size: 30.0,),
            onPressed: () => Navigator.pop(context),
          ),
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
                      Expanded(
                        child: Text(
                          widget.post.data['name'],
                          style: TextStyle(
                            color: Color(0XFF3A6F8D),
                            letterSpacing: 2.0,
                              fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
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
            buildTextDetial('Hospital :', 'hospital'),
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
            ),InkWell(
              child: buildTextDetial('Reservation Mobile No: ', 'reservationmobileno'),
              onTap: () async{
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                    contactDialog);
              },
            ),

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
            FlatButton.icon(
              minWidth: getDeviceWidth(context) * 0.85,
              icon: Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
              ),
              color: Colors.blue,
              padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
              onPressed: () async {
                var pdfURL = widget.post.data['pdf'];
                if(pdfURL != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPdf(),
                          settings: RouteSettings(
                            arguments: pdfURL,
                          )
                      )
                  );
                }else{
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      noDataFound);
                }
              },
              label: Text(
                '  CV ',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
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