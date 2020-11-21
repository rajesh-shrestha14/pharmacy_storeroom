import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Screens/dashboard.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //icons
  final List<IconData> _navIcon = [
    Icons.dashboard,
    Icons.file_upload,
    Icons.info,
    Icons.supervised_user_circle,
    Icons.attach_file,
    Icons.insert_drive_file,
    Icons.receipt,
    Icons.contacts
  ];

  //iconNAME
  final List<String> _navIconName = [
    "Dashboard",
    "Add Medicine",
    "Medicine Information",
    "User Profile",
    "Added Medicine",
    "Register",
    "User Record",
    "Add Notice"
  ];
  final List<Widget> _navWidget = [
    Dashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (char) {},
        items: List.generate(
          _navIcon.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(
              _navIcon[index],
              color: Colors.grey,
            ),
            title: Text(
              _navIconName[index],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
