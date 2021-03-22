import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        body: SafeArea(
            child: Column(children: <Widget>[
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2.70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Row(
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
                              SizedBox(height: 4.2,),
                              Text(widget.post.data['address'],style: TextStyle(fontSize: 15.0),),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Telephone:',
                                  style: TextStyle(
                                    color: Color(0XFF3A6F8D),
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.2,),
                                Text(widget.post.data['phone'],style: TextStyle(fontSize: 15.0),),
                              ],
                            ),
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
                            'Email:',
                            style: TextStyle(
                              color: Color(0XFF3A6F8D),
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.2,),
                          Text(widget.post.data['email'],style: TextStyle(fontSize: 15.0),),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0XAA3A6F8D),
                thickness: 3.0,
              ),
              Expanded(
                child: ListOfDoctorInHospital(
                  hospitalName: widget.post.data['name'],
                ),
              ),
            ])));
  }
}