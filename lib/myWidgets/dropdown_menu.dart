import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Screens/loginScreen.dart';
import 'package:pharmacy_storeroom/Screens/user_profile.dart';
import 'package:pharmacy_storeroom/Services/auth_service.dart';

class AppBarDropDownMenu extends StatelessWidget {
  showDialogue(context) {
    showDialog(
      context: context,
      builder: (_) => new SimpleDialog(
        // title: const Text('Select assignment'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () async {
              await Navigator.pop(_);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => UserProfile()),
                (Route<dynamic> route) => route is UserProfile,
              );
            },
            child: Row(
              children: [
                Icon(Icons.supervised_user_circle),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text('Profile'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              await AuthService().signOut();
              await Navigator.pop(_);
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LogInScreen()),
                (Route<dynamic> route) => route is LogInScreen,
              );
            },
            child: Row(
              children: [
                Icon(Icons.input),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text('Log Out'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
