import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

//import 'dart:core';
class MedInfo extends StatefulWidget {
  @override
  _MedInfoState createState() => _MedInfoState();
}

List<String> _list = [
  'Medicine Id',
  'Medicine Name',
  'Medicine Quantity',
  'Issue By',
  'Expiry Reminder',
  'Update Medicine Info',
  'Delete'
];

class _MedInfoState extends State<MedInfo> {
  List<Widget> _buildCells(int count, List<String> array) {
    return List.generate(
      count,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
        //alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 0.4,
        //color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: Center(child: Text(array[index], style: TextStyle())),
      ),
    );
  }

  List<Widget> _buildRows(int count, List<String> array) {
    return List.generate(
      count,
      (index) => Row(
        children: _buildCells(count, array),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(child: CustomDrawer()),
        backgroundColor: Color(0xffebf1f6),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                AppBarDropDownMenu().showDialogue(context);
              },
            )
          ],
          title: Text("Medicine Information"),
        ),
        //drawer: Drawer(child: SideDrawer(context)),
        body: Container(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INFORMATION',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Medicine Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildCells(_list.length, _list),
                      ),
                      // Flexible(
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: _buildRows(20),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                width: size.width * 0.7,
                child: RaisedButton(
                  color: CupertinoColors.activeBlue,
                  child: Text(
                    "Medicine info in damaged department",
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                width: size.width * 0.7,
                child: RaisedButton(
                  color: CupertinoColors.activeBlue,
                  child: Text(
                    "Medicine info in pharmacy counter",
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
