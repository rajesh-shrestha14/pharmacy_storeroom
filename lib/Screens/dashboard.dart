import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              //alertbox
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
              SizedBox(
                height: size.height * 0.005,
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0),
                alignment: Alignment.centerLeft,
                height: size.height * 0.2,
                width: size.width,
                child: Text(''),
              ),

              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
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
                      ],
                    ),
                  ],
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
