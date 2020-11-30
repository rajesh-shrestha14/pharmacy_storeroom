import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy_storeroom/Model/medicine.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';

class MedicineInfoBoxInAddedMedicine extends StatelessWidget {
  MedicineModel medicine;
  MedicineInfoBoxInAddedMedicine({@required this.medicine});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.03),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(size.height * 0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            medicine.mName,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.height * 0.03),
          ),
          Text(
            'Issued by:\n ${medicine.mIssueBy}',
            textAlign: TextAlign.center,
            style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: size.height * 0.02),
          ),
          Text(
            'Medicine Id:\n ${medicine.mId}',
            textAlign: TextAlign.center,
            style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: size.height * 0.02),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: RaisedButton(
                    onPressed: () {
                      DatabaseService().deleteData(
                          collectionName: 'medicine', documentId: medicine.mId);
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
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
    );
  }
}
