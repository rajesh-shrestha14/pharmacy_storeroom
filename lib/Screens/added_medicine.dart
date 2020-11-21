import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Services/table_builder.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

//import 'dart:core';
class AddedMedicine extends StatefulWidget {
  @override
  _AddedMedicineState createState() => _AddedMedicineState();
}

List<String> _list = [
  'Medicine Id',
  'Medicine Quantity',
  'Issue By',
  'Update Medicine Info',
  'Delete'
];

class _AddedMedicineState extends State<AddedMedicine> {
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
          title: Text('Added Medicine'),
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
                        children: TableBuilder().buildCells(
                            _list.length, _list, context,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
