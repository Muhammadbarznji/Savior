import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewFirstAid extends StatefulWidget {
  @override
  _AddNewFirstAidState createState() => _AddNewFirstAidState();
}

class _AddNewFirstAidState extends State<AddNewFirstAid> {
  TextEditingController
  medicalDescriptionController,
      medicalNameController,
      medicalTimeController,
      doctorController,
      titleController;

  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    medicalDescriptionController = TextEditingController();
    medicalNameController = TextEditingController();
    medicalTimeController = TextEditingController();
    titleController = TextEditingController();
    doctorController = TextEditingController();
    super.initState();
  }

  Future addFisrtAid() async {
    try {
      await Firestore.instance.collection('firstaid').document().setData({
        'meddesc': titleController.text,
        'medname': medicalNameController.text,
        'medtime': medicalTimeController.text,
        'title': titleController.text,
        'doctor': doctorController.text,
      });
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Image.asset('assets/images/firstaidadd.png'),
            ),
            Form(
              key: _registerFormKey,
              child: Card(
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Add new First Aid',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: titleController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter First Aid Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter first aid name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: medicalNameController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter Medical Name(s)',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter medical name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: medicalTimeController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Medical Usage period',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter medical time';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: medicalDescriptionController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Medical Description',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter medical description';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: doctorController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter Doctor Name (optional)',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Icon(
                          Icons.medical_services_sharp,
                          color: Colors.white,
                        ),
                        color: Colors.green.shade300,
                        padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                        onPressed: () async {
                          if (_registerFormKey.currentState.validate()) {
                            await addFisrtAid();
                          }
                        },
                        label: Text(
                          '  Add ',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: FlatButton(
                                shape: CircleBorder(),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: MediaQuery.of(context).size.height *
                                      0.045,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    medicalDescriptionController.dispose();
    medicalNameController.dispose();
    medicalTimeController.dispose();
    titleController.dispose();
    super.dispose();
  }
}

