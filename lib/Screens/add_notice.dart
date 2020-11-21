import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy_storeroom/Services/table_builder.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

class AddNotice extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<String> array = [
    'Subject',
    'Description',
    'Update Notice Info',
    'Delete'
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //creating focus where tapped
        FocusScopeNode currentFocus = FocusScope.of(context);
        //if it still lacks focus unfocus the focus item
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(child: CustomDrawer()),
          appBar: AppBar(
            title: Text('Add Notice'),
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
          ),
          body: Container(
            width: size.width,
            color: Color(0xffebf1f6),
            padding: EdgeInsets.all(19.0),
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
                  'Add Notice about Medicine',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(size.height * 0.03),
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Subject',
                              hintText: 'Subject',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              hintText: 'Description',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          FlatButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.02),
                                side: BorderSide(color: Colors.blue)),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.

                              }
                            },
                            icon: Icon(
                              Icons.lock_open,
                              color: Colors.blue,
                            ),
                            label: Text(
                              'Add Notice Details',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Flexible(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: TableBuilder().buildCells(
                                    array.length, array, context,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
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
