import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharmacy_storeroom/Model/medicine.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';
import 'package:pharmacy_storeroom/Services/get_from_shared_preference.dart';
import 'package:pharmacy_storeroom/Services/table_builder.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';
import 'package:pharmacy_storeroom/myWidgets/medicine_info_box_in_added_medicine.dart';
import 'package:pharmacy_storeroom/myWidgets/medicine_info_box_in_medicine_info.dart';

//import 'dart:core';
class AddedMedicine extends StatefulWidget {
  @override
  _AddedMedicineState createState() => _AddedMedicineState();
}

class _AddedMedicineState extends State<AddedMedicine> {
  @override
  void initState() {
    super.initState();
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
              FutureBuilder(
                future: FromSharedPref().getString('userId'),
                builder: (context, value) {
                  if (value.hasData &&
                      (value.connectionState == ConnectionState.done)) {
                    print(value);
                    return Flexible(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('medicine')
                            .where('issueBy', isEqualTo: value.data)
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Something Went Wrong!!'),
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot medicine =
                                    snapshot.data.documents[index];
                                print(medicine.toString());
                                return MedicineInfoBoxInMedicineInfo(
                                  medicine:
                                      MedicineModel.fromJason(medicine.data()),
                                );
                              },
                            );
                          }
                        },
                      ),
                    );
                  } else
                    return Center(
                      child: Text(
                          'You are not logged in! No shared Prefs data found'),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
