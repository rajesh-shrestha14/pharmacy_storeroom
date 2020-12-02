import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Model/user.dart';
import 'package:pharmacy_storeroom/Resources/colors.dart';
import 'package:pharmacy_storeroom/Services/auth_service.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';
import 'package:pharmacy_storeroom/Services/get_from_shared_preference.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userId;

  _UserProfileState() {
    FromSharedPref().getString('userId').then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          AppUser user = AppUser.fromJason(snapshot.data.data());
          return ProfileForm(
            user: user,
          );
        }
      },
    );
  }
}

class ProfileForm extends StatefulWidget {
  AppUser user;
  ProfileForm({@required this.user});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController userName = TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey();

  hintStyle() {
    return TextStyle(
      color: Colors.grey,
    );
  }

  _updateAccount() {
    //this is synchronous function
    //checking name
    if (fName.text.isNotEmpty) {
      widget.user.firstName = fName.text;
    }
    //checking name
    if (lName.text.isNotEmpty) {
      widget.user.lastName = lName.text;
    }
    //checking address
    if (address.text.isNotEmpty) {
      widget.user.address = address.text;
    }
    //checking phoneNo
    if (phoneNo.text.isNotEmpty) {
      widget.user.phoneNumber = phoneNo.text;
    }
    //checking username
    if (userName.text.isNotEmpty) {
      widget.user.username = userName.text;
    }
    if (password.text.isNotEmpty) {
      _changeUserData(changePassword: true);
    } else {
      _changeUserData(changePassword: false);
    }
  }

  _changeUserData({bool changePassword}) async {
    await DatabaseService().updateUser(widget.user).then((value) {
      if (changePassword) {
        AuthService()
            .changeCurrentUsersPassword(password.text)
            .then((value) => showDialogBox('Success', 'password Updated'))
            .catchError((e) {
          showDialogBox("Error", e.toString());
        });
      }
      showDialogBox('Success', 'User updated');
    }).catchError((e) {
      showDialogBox('Error', e.toString());
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserProfile()));
  }

  showDialogBox(title, message) {
    showDialog(
      context: context,
      builder: (context) {
        Widget cancelButton = FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            print('Hellow world');
            Navigator.pop(context);
          },
        );
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            cancelButton,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //creating focus where tapped
        FocusScopeNode currentFocus = FocusScope.of(context);
        //if it still lacks focus unfocus the focus item
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.01),
              child: Text(
                'Account Detail',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 6,
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
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(
                              '${widget.user.firstName}  ${widget.user.lastName}'),
                          accountEmail: Text("${widget.user.email}"),
                          currentAccountPicture: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: widget.user.imageURL != null
                                ? NetworkImage("${widget.user.imageURL}")
                                : Text(
                                    "${widget.user.firstName[0].toUpperCase()}",
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: TextFormField(
                            //autofocus: true,

                            controller: fName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'First Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: widget.user.firstName,
                              hintStyle: hintStyle(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: TextFormField(
                            controller: lName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Last Name',
                              hintText: widget.user.lastName,
                              hintStyle: hintStyle(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: TextFormField(
                            //disabling textfield
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            controller: email,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Email',
                              hintText: widget.user.email,
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Address',
                              hintText: widget.user.address,
                              hintStyle: hintStyle(),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: TextFormField(
                            controller: phoneNo,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Phone Number',
                              hintText: widget.user.phoneNumber,
                              hintStyle: hintStyle(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: TextFormField(
                            controller: userName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Username',
                              hintText: widget.user.username,
                              hintStyle: hintStyle(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Password',
                              hintText: '*********',
                              hintStyle: hintStyle(),
                            ),
                          ),
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
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      //if it still lacks focus unfocus the focus item
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            Widget cancelButton = FlatButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            Widget continueButton = FlatButton(
                              child: Text("Continue"),
                              onPressed: () async {
                                Navigator.pop(context);
                                await _updateAccount();
                              },
                            );
                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("AlertDialog"),
                              content: Text(
                                  "Would you like to save changes to profile?"),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );
                            return alert;
                          });
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
    );
  }
}
