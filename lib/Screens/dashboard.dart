import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Model/medicine.dart';
import 'package:pharmacy_storeroom/Model/notice.dart';
import 'package:pharmacy_storeroom/myWidgets/dashboard_notice.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
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
            title: Text("Dashboard"),
          ),
          drawer: Drawer(child: CustomDrawer()),
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
                  height: size.height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0),
                  alignment: Alignment.centerLeft,
                  height: size.height * 0.06,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(9.0),
                        topLeft: Radius.circular(9.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75))
                    ],
                    color: Colors.white,
                  ),
                  child: Text(
                    'ALERT ABOUT EXPIRY DATE OF MEDICINE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.039,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.15,
                  child: Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('medicine')
                          .snapshots(),
                      builder: (context, snapshot) {
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
                              MedicineModel medicineModel =
                                  MedicineModel.fromJason(medicine.data());
                              int diff = medicineModel.mExpDate
                                  .difference(DateTime.now())
                                  .inDays;
                              if (diff < 60 && diff > 0) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  child: Text(
                                      "\'${medicineModel.mName}\' expires at $diff day(s)"),
                                );
                              } else if (diff < 0)
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  child: Text(
                                      "\'${medicineModel.mName}\' expired ${-1 * diff} day(s) ago"),
                                );
                              else if (diff == 0)
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  child: Text(
                                      "\'${medicineModel.mName}\' will expire today"),
                                );
                              return Container();
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('medicine')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Something Went Wrong!!'),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text('No Notice Available'),
                        );
                      }
                      double expense = 0;
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        expense +=
                            snapshot.data.documents[i]['price'].toDouble();
                      }
                      return Container(
                        padding: EdgeInsets.only(left: 15.0),
                        alignment: Alignment.centerLeft,
                        height: size.height * 0.2,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 0.75))
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'TOTAL EXPENSES IN MEDICINES',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.blue,
                                ),
                                Text('$expense'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'TOTAL DAMAGE MEDICINE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'TOTAL PRICE OF DAMAGE MEDICINE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  height: size.height * 0.05,
                  color: Color(0xfff6f9fb),
                  //padding: EdgeInsets.only(top: ),
                  child: Row(
                    children: [
                      Text('Subject'),
                      Spacer(),
                      Text('Description'),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  child: Flexible(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('notice')
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Something Went Wrong!!'),
                          );
                        } else {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text('No Notice Available'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot notice =
                                  snapshot.data.documents[index];
                              NoticeModel noticeModel =
                                  NoticeModel.fromJson(notice.data());
                              return DashboardNoticeBox(
                                subject: noticeModel.subject,
                                description: noticeModel.description,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
