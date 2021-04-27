import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddHospitalScreen extends StatefulWidget {
  @override
  _AddHospitalScreenState createState() => _AddHospitalScreenState();
}

class _AddHospitalScreenState extends State<AddHospitalScreen> {
  RegExp regPhoneNumber;
  TextEditingController nameController,
      phoneController,
      emailController,
      addressController,
      informationController,
      webSiteController,
      generalController;

  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    informationController = TextEditingController();
    webSiteController = TextEditingController();
    generalController = TextEditingController();

    regPhoneNumber = RegExp(
        r"\s*(?:(\d{1,3}))?[-. (]*(\d{3,4})[-. )]*(\d{3})[-. ]*(\d{6})(?: *x(\d+))?\s*$");

    super.initState();
  }

  Future addHospital() async {
    try {
      await Firestore.instance.collection('hospital').document().setData({
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'address': addressController.text,
        'info': informationController.text,
        'general': generalController.text,
        'image':
            'https://firebasestorage.googleapis.com/v0/b/test-app-5764a.appspot.com/o/logo.png?alt=media&token=ac4f26cf-6e3f-4c96-b779-b75f82280340',
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
              child: Image.asset('assets/images/hospitaladd.png'),
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
                          'Add new Hospital',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: nameController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter Hospital Name',
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
                              return 'Please enter hospital name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: phoneController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
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
                              return 'Please enter phone number';
                            }
                            if (value.length < 11) {
                              return 'Phone number too small';
                            }
                            if (regPhoneNumber.hasMatch(value.toString())) {
                              return 'Please enter validate phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: addressController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Address',
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
                              return 'Please enter Address';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Email',
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
                              return 'Please enter email';
                            }
                            if (!value.contains('@') || value.length < 5) {
                              return 'Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: webSiteController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'WebSite',
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
                              return 'Please enter Web Site Link';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: generalController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'General',
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
                              return 'Please enter General';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: informationController,
                          style: TextStyle(),
                          //keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            hintText: 'Information',
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
                              return 'Please enter some info';
                            }
                            return null;
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
                            await addHospital();
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
/*                            child: Text(
                              'Already have an account? ',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),*/
                          ),
/*                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text('Log in',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  )),
                            ),
                          ),*/
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
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
