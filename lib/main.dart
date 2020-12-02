import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Screens/add_medicine.dart';
import 'package:pharmacy_storeroom/Screens/add_notice.dart';
import 'package:pharmacy_storeroom/Screens/added_medicine.dart';
import 'package:pharmacy_storeroom/Screens/dashboard.dart';
import 'package:pharmacy_storeroom/Screens/loginScreen.dart';
import 'package:pharmacy_storeroom/Screens/med_info.dart';
import 'package:pharmacy_storeroom/Screens/register.dart';
import 'package:pharmacy_storeroom/Screens/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool loggedIn = false;

  Future<Null> checkLoggedIn() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userId')) {
      var uId = await prefs.getString('userId');
      setState(() {
        if (uId != null) {
          loggedIn = true;
        } else {
          loggedIn = false;
        }
      });
    }
  }

  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.none) {
          return Container(
            child: Center(
              child: Text('Something Went Wrong!'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            title: 'Pharmacy Storeroom',
            home: loggedIn ? Dashboard() : LogInScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: Center(
            child: Container(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
