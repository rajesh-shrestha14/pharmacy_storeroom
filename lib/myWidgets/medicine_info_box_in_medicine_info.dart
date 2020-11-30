import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy_storeroom/Model/medicine.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';

class MedicineInfoBoxInMedicineInfo extends StatelessWidget {
  MedicineModel medicine;
  MedicineInfoBoxInMedicineInfo({@required this.medicine});
  String checkDate() {
    int day = medicine.mExpDate.difference(DateTime.now()).inDays;
    if (day > 0)
      return '$day day(s) remaining';
    else if (day < 0)
      return 'expired $day day(s) ag0';
    else
      return 'medicine will expire today';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: size.height * 0.03),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.03),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius:
                  BorderRadius.all(Radius.circular(size.height * 0.05))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.mName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height * 0.03),
              ),
              Container(
                width: size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01),
                child: Column(
                  children: [
                    Text(
                      'Medicine Id: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      medicine.mId,
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01),
                child: Column(
                  children: [
                    Text(
                      'Quantity: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${medicine.mQuantity}',
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01),
                child: Column(
                  children: [
                    Text(
                      'Issued By: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      medicine.mIssueBy,
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01),
                child: Column(
                  children: [
                    Text(
                      'Expiry Reminder: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      checkDate(),
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: RaisedButton(
                        onPressed: () {
                          DatabaseService().deleteData(
                              collectionName: 'medicine',
                              documentId: medicine.mId);
                        },
                        color: Colors.blue,
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('Update'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: size.width * 0.6,
          bottom: size.height * 0.36,
          child: IconButton(
            onPressed: () {
              final DocumentReference docRef = FirebaseFirestore.instance
                  .collection("medicine")
                  .doc(medicine.mId);
              docRef.update({"quantity": FieldValue.increment(1)});
            },
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          ),
        ),
        Positioned(
          right: size.width * 0.6,
          bottom: size.height * 0.36,
          child: IconButton(
            onPressed: () {
              final DocumentReference docRef = FirebaseFirestore.instance
                  .collection("medicine")
                  .doc(medicine.mId);
              docRef.update({"quantity": FieldValue.increment(-1)});
            },
            icon: Icon(
              Icons.minimize,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
