import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Resources/colors.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;

  InputField(
      {@required this.controller, @required this.label, @required this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          labelText: label,
          hintText: hint,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
        child: GestureDetector(
          onTap: () {
            //creating focus where tapped
            FocusScopeNode currentFocus = FocusScope.of(context);
            //if it still lacks focus unfocus the focus item
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            drawer: Drawer(child: CustomDrawer()),
            backgroundColor: ColorTheme().background,
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
              title: Text('User Profile'),
            ),
            body: Padding(
              padding: EdgeInsets.all(size.width * 0.06),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                    child: Text(
                      'Account Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.03,
                          vertical: size.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.width * 0.1),
                      ),
                      height: size.height,
                      width: size.width,
                      //color: Colors.black,

                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              InputField(
                                label: 'First Name',
                              ),
                              InputField(
                                label: 'Last Name',
                              ),
                              InputField(
                                label: ''
                                    'Email',
                              ),
                              InputField(
                                label: 'Address',
                              ),
                              InputField(
                                label: 'Phone Number',
                              ),
                              InputField(
                                label: 'Username',
                              ),
                              InputField(
                                label: 'Password',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            //if it still lacks focus unfocus the focus item
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          color: Colors.blue,
                          child: Text(
                            "Update Account",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
