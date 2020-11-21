import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Screens/register.dart';
import 'package:pharmacy_storeroom/Services/auth_service.dart';
import 'package:pharmacy_storeroom/Services/show_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //firebase instance
  //final FirebaseFirestore db = FirebaseFirestore.instance;
  //adding data to firebase
  // add() {
  //   instance.collection("collectionName").add(jasonfile);
  // }
  //textfield data
  TextEditingController _usernameC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();

  //validate form
  validate() {
    final form = _formKey.currentState;
    form.save();

    //validate will return true if is validate,else viceversa
    if (form.validate()) {
      print("$_usernameC $_passwordC");
    }
  }

  //checkbox data
  bool rememberMe = false;
  //formkey
  final _formKey = GlobalKey<FormState>();
  // login form
  Widget loginForm(size) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * 0.05, left: size.width * 0.05),
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
                ),
              ),
              Flexible(
                // constraints: BoxConstraints(
                //   minHeight: size.height * 0.1,
                //   maxHeight: size.height,
                //   minWidth: size.width * 0.4,
                // ),
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * 0.05),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernameC,
                    decoration: InputDecoration(
                      hintText: 'Enter Username',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * 0.05, left: size.width * 0.05),
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * 0.05),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _passwordC,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
              ),
            ],
          ),

          //forth
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: (bool value) {
                  setState(() {
                    this.rememberMe = value;
                  });
                },
              ),
              InkWell(
                child: Text('Remember Me'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //when we leave app on background or close it
  @override
  void dispose() {
    _passwordC.dispose();
    _usernameC.dispose();
    super.dispose();
  }

  @override
  //this function renders screen data
  Widget build(BuildContext context) {
    //size is size of the display
    final Size size = MediaQuery.of(context).size;

    //this is returning portion
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //FIRST ROW
              Container(
                width: size.width,
                height: size.height * 0.3,
                child: Stack(
                  children: [
                    //IMAGE
                    Image.asset(
                      'assets/images/background.jpg',
                      width: size.width,
                    ),

                    //TEXT
                    Positioned(
                      child: Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Center(
                          //heightFactor: size.height * 0.02,
                          //alignment: Alignment.center,
                          child: Text(
                            'WELCOME TO PHARMACY STOREROOM APPLICATION',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //second row
              SizedBox(
                height: size.height * 0.07,
              ),
              loginForm(size),

              //fifth row
              Container(
                padding: EdgeInsets.only(top: size.height * 0.1),
                width: size.width * 0.5,
                child: RaisedButton(
                  elevation: 4.0,
                  color: Colors.green,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    //validate form
                    if (_formKey.currentState.validate() == true) {
                      //opening shared preference before doing anything else
                      //and setting previous user id to null
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('userId', null);

                      //wait for sign in
                      await AuthService().signIn(
                          email: _usernameC.text, password: _passwordC.text);

                      //then check shared prefs whether user is logged in or not
                      String uId = await prefs.get('userId');
                      if (uId != null && uId.length > 0) {
                        //if user is successfully logged in
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Dashboard()));
                      }
                      //if there is issues in logging in
                      else {
                        DialogService().forLogInError(context);
                      }
                    }
                  },
                  child: Text('Login'),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text(
                  'Register Here!!',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
