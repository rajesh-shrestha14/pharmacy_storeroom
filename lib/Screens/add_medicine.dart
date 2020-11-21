import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

class AddMedicine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(child: CustomDrawer()),
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
        title: Text('Add Medicine'),
      ),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.06),
        color: Color(0xffebf1f6),
        child: Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MEDICINE DETAILS',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'INFORMATION',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Add Medicine Information Here',
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
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.03),
                    //height: size.height * 0.5,
                    color: Colors.white,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Medicine Name',
                            hintText: 'type medicine name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Medicine Price',
                            hintText: 'type medicine price',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Manufracture Date',
                            hintText: 'type manufracture date',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
                            hintText: 'type expiry date',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Batch Number',
                            hintText: 'type batch number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            hintText: 'Quantity : Strip*packing',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton.icon(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    side: BorderSide(color: Colors.blue)),
                onPressed: () {},
                icon: Icon(
                  Icons.lock_open,
                  color: Colors.blue,
                ),
                label: Text(
                  'Add Medicine Details',
                  style: TextStyle(
                    color: Colors.blue,
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
