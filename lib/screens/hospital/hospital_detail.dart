import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/others/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hospitaldoctor.dart';

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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
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
        body: SafeArea(
            child: Column(children: <Widget>[
          Container(
            color: Colors.white,
            //height: MediaQuery.of(context).size.height / 2.70,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
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
                            child: Image.asset('assets/images/pharmacy.png'),
                            radius: 45.0,
                            //backgroundImage: Image.network(''),
                            //backgroundImage:AssetImage('assets/images/pharmacy.png',),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Color(0XAA3A6F8D),
                    thickness: 3.0,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(
                              color: Color(0XFF3A6F8D),
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4.2,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 17.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                width: getDeviceWidth(context) * 0.8,
                                child: InkWell(
                                  child: Text(
                                    widget.post.data['address'],
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  onTap: () {
                                    launch(
                                        'https://www.google.com/maps/dir//${widget.post.data['address']}');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Telephone:',
                        style: TextStyle(
                          color: Color(0XFF3A6F8D),
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4.2,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 17.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            child: Text(
                              widget.post.data['phone'],
                              style: TextStyle(fontSize: 17.0),
                            ),
                            onTap: () async {
                              //launch("tel://${widget.post.data['phone']}");
                              //String uri = 'sms:${widget.post.data['phone']}?body=hello%20there';
                              //await launch(uri);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email:',
                                style: TextStyle(
                                  color: Color(0XFF3A6F8D),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 4.2,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 18.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  InkWell(
                                    child: Text(
                                      widget.post.data['email'],
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.blue),
                                    ),
                                    onTap: () async {
                                      String email = widget.post.data['email'];
                                      if (await canLaunch("mailto:$email")) {
                                        await launch("mailto:$email");
                                      } else {
                                        throw 'Could not launch';
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'WebSite:',
                                  style: TextStyle(
                                    color: Color(0XFF3A6F8D),
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.web,
                                      size: 18.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    InkWell(
                                      child: Text(
                                        widget.post.data['web'],
                                        style: TextStyle(
                                            fontSize: 17.0, color: Colors.blue),
                                      ),
                                      onTap: () async {
                                        const url = "https://cmcph.net";
                                        if (await canLaunch(url))
                                          await launch(url);
                                        else
                                          // can't launch url, there is some error
                                          throw "Could not launch $url";
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'More information:',
                        style: TextStyle(
                          color: Color(0XFF3A6F8D),
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6.2,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Container(
                            width: getDeviceWidth(context) * 0.8,
                            height: getDeviceWidth(context) * 0.42,
                            child: SingleChildScrollView(
                              child: Text(
                                widget.post.data['info'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              icon: Icon(
                                Icons.supervisor_account_rounded,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              color: Colors.green.shade300,
                              padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListOfDoctorInHospital(
                                              hospitalName:
                                                  widget.post.data['name'],
                                            )));
                              },
                              label: Text(
                                '  Doctors ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                ],
              ),
            ),
          ),
/*          Divider(
            color: Color(0XAA3A6F8D),
            thickness: 3.0,
          ),
          Expanded(
            child: ListOfDoctorInHospital(
              hospitalName: widget.post.data['name'],
            ),
          ),*/
        ])));
  }
}
