import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/screens/loading/onBoarding_screen.dart';

class EmailRegister extends StatefulWidget {
  @override
  _EmailRegisterState createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  RegExp regPhoneNumber;
  TextEditingController passwordController,
      emailController,
      userNameController,
      phoneNumberController,
      confirmPasswordController;
  FirebaseAuth _auth = FirebaseAuth.instance;

  SharedPreferences prefs;
  bool showOnBoarding = false;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    showOnBoarding = prefs.getBool('first') ?? true;
  }

  bool showError = false;
  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    initPrefs();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    confirmPasswordController = TextEditingController();

    regPhoneNumber = RegExp(
        r"\s*(?:(\d{1,3}))?[-. (]*(\d{3,4})[-. )]*(\d{3})[-. ]*(\d{6})(?: *x(\d+))?\s*$");

    super.initState();
  }

  Future test() async{

  }

  Future addUser() async {
    await _auth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((_) async {
      try {
        await Firestore.instance
            .collection('profile')
            .document(_.user.uid.toString())
            .setData({
          'userName': userNameController.text,
          'email': emailController.text,
          'phoneNumber': phoneNumberController.text,
          'uid': _.user.uid,
          'picture':
              'https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png',
          'weight': '',
          'height': '',
          'bloodPressure': 'Normal',
          'bloodSugar': 'Normal',
          'allergies': 'None',
          'bloodGroup': 'Not say',
          'age': '25',
          'gender': 'Not say',
          'role': false,
        });
        prefs.setBool('first', true);
/*        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return VerifyScreen(user: _.user,);
            }));*/

                Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return OnBoardingScreen();
        }));
      } catch (e) {
        print(e.toString());
      }
    });
  }

  bool validatePasswordStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('assets/images/img.jpg'),
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
                          'Register to Saver',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: userNameController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter user name',
                            prefixIcon:
                                Icon(Icons.person, color: Colors.indigo),
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
                              return 'Please enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: phoneNumberController,
                          style: TextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            prefixIcon: Icon(Icons.phone, color: Colors.indigo),
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
                          controller: emailController,
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          style: TextStyle(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!value.contains('@')) {
                              return 'Enter Valid Email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter email-address',
                            prefixIcon: Icon(Icons.email, color: Colors.indigo),
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
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: passwordController,
                          style: TextStyle(),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                            prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (!validatePasswordStructure(value)) {
                              return 'Password must contain Uppercase, Lowercase,'
                                  '\n Number and  Special Character';
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          style: TextStyle(),
                          onChanged: (v) {
                            _registerFormKey.currentState.validate();
                          },
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Confirm password',
                            prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo,
                                    style: BorderStyle.solid)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value != passwordController.text) {
                              return 'Password does not match';
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
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        color: Colors.green.shade300,
                        padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                        onPressed: () async {
                          if (_registerFormKey.currentState.validate()) {
                            await addUser();
                          }
                        },
                        label: Text(
                          '  Sign up',
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
                            child: Text(
                              'Already have an account? ',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ),
                          GestureDetector(
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
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }
}
