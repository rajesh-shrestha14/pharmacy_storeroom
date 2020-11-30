import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Screens/add_medicine.dart';
import 'package:pharmacy_storeroom/Screens/add_notice.dart';
import 'package:pharmacy_storeroom/Screens/added_medicine.dart';
import 'package:pharmacy_storeroom/Screens/dashboard.dart';
import 'package:pharmacy_storeroom/Screens/med_info.dart';
import 'package:pharmacy_storeroom/Screens/register.dart';
import 'package:pharmacy_storeroom/Screens/user_profile.dart';
import 'package:pharmacy_storeroom/Screens/user_record.dart';
import 'package:pharmacy_storeroom/Services/get_from_shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.dashboard),
                title: Text("Dashboard"),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Dashboard()),
                    (Route<dynamic> route) => route is Dashboard,
                  );
                }),
            Divider(),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: Text("Add Medicine"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddMedicine()),
                  (Route<dynamic> route) => route is AddMedicine,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Medicine Information"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MedInfo()),
                  (Route<dynamic> route) => route is MedInfo,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text("User Profile"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UserProfile()),
                  (Route<dynamic> route) => route is UserProfile,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_file),
              title: Text("Added Medicine"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddedMedicine()),
                  (Route<dynamic> route) => route is AddedMedicine,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text("Register"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => RegisterScreen()),
                  (Route<dynamic> route) => route is RegisterScreen,
                );
              },
            ),
            Divider(),
            FutureBuilder(
              future: FromSharedPref().getString('accountType'),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.receipt),
                        title: Text("User Record"),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UserRecord()),
                            (Route<dynamic> route) => route is UserRecord,
                          );
                        },
                      ),
                      Divider(),
                    ],
                  );
                else
                  return Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Add Notice"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddNotice()),
                  (Route<dynamic> route) => route is AddNotice,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
