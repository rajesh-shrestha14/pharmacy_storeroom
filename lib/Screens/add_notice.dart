import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy_storeroom/Model/notice.dart';
import 'package:pharmacy_storeroom/Screens/add_medicine.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';
import 'package:pharmacy_storeroom/Services/get_from_shared_preference.dart';
import 'package:pharmacy_storeroom/Services/show_dialogue.dart';
import 'package:pharmacy_storeroom/Services/table_builder.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';
import 'package:pharmacy_storeroom/myWidgets/notice_box.dart';

class AddNotice extends StatefulWidget {
  //for table
  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  List<String> array = [
    'Subject',
    'Description',
    'Update Notice Info',
    'Delete'
  ];

  TextEditingController _subject = TextEditingController();

  TextEditingController _description = TextEditingController();

  _addNotice(BuildContext context) async {
    //getting uid from shared pref
    String uId = await FromSharedPref().getString('userId');
    //initializing notice
    NoticeModel newNotice = NoticeModel(
      noticeId: uId,
      description: _description.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      subject: _subject.text,
    );
    await DatabaseService().noticeToDatabase(newNotice, context);
    Navigator.pop(context);
    DialogService().addedToDatabase(
        context: context,
        message: 'Notice added successfully',
        title: 'Success !');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => AddNotice()),
      (Route<dynamic> route) => route is AddNotice,
    );
  }

  final _formKey = GlobalKey<FormState>();

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
                            controller: _subject,
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
                            controller: _description,
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
                                _addNotice(context);
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
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('notice')
                                  .snapshots(),
                              builder: (_, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return NoticeBox(
                                        notice:
                                            NoticeModel.fromJson(notice.data()),
                                      );
                                    },
                                  );
                                }
                              },
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
