import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_storeroom/Model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmacy_storeroom/Screens/loginScreen.dart';
import 'package:pharmacy_storeroom/Services/auth_service.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';
import 'package:path/path.dart';
import 'package:pharmacy_storeroom/Services/show_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // this image will be populated after picking up the image
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // upload image file
  Future<String> uploadImage(File _image1) async {
    //create instaince
    FirebaseStorage storage = FirebaseStorage.instance;
    Future<String> url;
    //create collection and upload file
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image1);

    // when completed return url
    await uploadTask.whenComplete(() {
      url = ref.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  //dropdown
  String _selectedUserType;
  final List<String> accountType = ['user', 'admin'];
  //textfield data
  TextEditingController _usernameC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _position = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();
  TextEditingController _email = TextEditingController();

  //checkbox data
  bool rememberMe = false;

  //formState key
  GlobalKey<FormState> _formKey = GlobalKey();

  //registered on pressed
  Future<void> registerUser(contexts) async {
    //TODO : transactions unhandled, currentUser not used in firebaseAuth, Provider not used for state management
    //first get the url of the image stored in firestore
    DialogService().forRegistration(contexts);
    String url = await uploadImage(_image);

    // populating user detail
    AppUser newUser = new AppUser(
        //TODO
        uId: '',
        email: _email.text,
        firstName: _firstName.text,
        lastName: _lastName.text,
        address: _address.text,
        position: _position.text,
        phoneNumber: _phoneNo.text,
        imageURL: url,
        username: _usernameC.text,
        userType: _selectedUserType);

    //signing up user / registering
    // it will auto update database
    await AuthService().register(newUser, _passwordC.text);
    await Navigator.pop(contexts);
    afterRegistration(contexts);
  }

  Future<void> afterRegistration(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //then check shared prefs whether user is logged in or not
    String uId = await prefs.get('userId');
    if (uId != null && uId.length > 0) {
      //if user is successfully logged in

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LogInScreen()),
        (Route<dynamic> route) => route is LogInScreen,
      );
      DialogService().forRegistrationSuccess(context);
    }
    //if there is issues in logging in
    else {
      Navigator.pop(context);
      DialogService().forRegistrationError(context);
    }
  }

  @override
  void dispose() {
    _usernameC.dispose();
    _passwordC.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _address.dispose();
    _position.dispose();
    _phoneNo.dispose();
    _email.dispose();
    super.dispose();
  }

  //key for getting scaffold state for snackbar
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  @override
  //this function renders screen data
  Widget build(BuildContext context) {
    //size is size of the display
    final Size size = MediaQuery.of(context).size;
    //creating global key here causes keyboard close automatically
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        // resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            //FIRST ROW
            Container(
              width: size.width,
              height: size.height * 0.3,
              child: Stack(
                children: [
                  //IMAGE
                  Image.asset(
                    'assets/images/background.jpg',
                    width: size.width,
                  ),

                  //TEXT
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      // padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: Center(
                        //heightFactor: size.height * 0.02,
                        //alignment: Alignment.center,
                        child: Text(
                          'WELCOME TO PHARMACY STOREROOM APPLICATION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //second row
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InfoTestBox(
                        text: 'First Name',
                        textHint: 'Enter First Name',
                        size: size,
                        controller: _firstName,
                      ),
                      InfoTestBox(
                        text: 'Last Name',
                        textHint: 'Enter Last Name',
                        size: size,
                        controller: _lastName,
                      ),
                      InfoTestBox(
                        text: 'Address',
                        textHint: 'Enter Address',
                        size: size,
                        controller: _address,
                      ),
                      Form(
                        autovalidate: true,
                        child: InfoTestBox(
                          text: 'Email Address',
                          textHint: 'Enter Email Address',
                          size: size,
                          controller: _email,
                          validatorType: 'email',
                        ),
                      ),
                      InfoTestBox(
                        text: 'Position',
                        textHint: 'Enter Position',
                        size: size,
                        controller: _position,
                      ),
                      FormField<String>(
                        initialValue: null,
                        validator: (value) {
                          if (_image == null) return 'Please Select Image*';
                          return null;
                        },
                        builder: (FormFieldState<String> state) => Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: size.width * 0.05,
                                  left: size.width * 0.05),
                              child: Text(
                                'image',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  child: Text('Choose File'),
                                ),
                                _image == null
                                    ? Container()
                                    : Text(basename(_image.path)),
                                state.hasError
                                    ? Text(
                                        state.errorText,
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InfoTestBox(
                        text: 'Phone Number',
                        textHint: 'Enter Phone Number',
                        size: size,
                        controller: _phoneNo,
                      ),
                      InfoTestBox(
                        text: 'Username',
                        textHint: 'Enter Username',
                        size: size,
                        controller: _usernameC,
                      ),
                      Form(
                        autovalidate: true,
                        child: InfoTestBox(
                          text: 'Password',
                          textHint: 'Enter Password',
                          size: size,
                          controller: _passwordC,
                          validatorType: 'password',
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: size.width * 0.05,
                                  left: size.width * 0.05),
                              child: Text(
                                'UserType',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                            ),
                            FormField<String>(
                              initialValue: null,
                              validator: (value) {
                                if (_selectedUserType == null)
                                  return 'Please Select UserType*';
                                return null;
                              },
                              builder: (FormFieldState<String> state) => Column(
                                children: [
                                  DropdownButton<String>(
                                    hint: Text(
                                      'Select User Type',
                                    ),
                                    value: _selectedUserType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedUserType = newValue;
                                      });
                                    },
                                    items: accountType.map((accountType) {
                                      return DropdownMenuItem(
                                        value: accountType,
                                        child: Center(child: Text(accountType)),
                                      );
                                    }).toList(),
                                  ),
                                  state.hasError
                                      ? Text(
                                          state.errorText,
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //third row

                      //forth
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (bool value) {
                              setState(() {
                                this.rememberMe = value;
                              });
                            },
                          ),
                          InkWell(
                            child: Text('Remember Me'),
                          ),
                        ],
                      ),
                      //fifth row
                      Container(
                        padding: EdgeInsets.only(top: size.height * 0.1),
                        width: size.width * 0.5,
                        child: RaisedButton(
                          elevation: 4.0,
                          color: Colors.green,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState.validate())
                              registerUser(context);
                            // final snackBar = SnackBar(
                            //   content: Text('Registered Successfully'),
                            //   action: SnackBarAction(
                            //     label: 'Ok',
                            //     onPressed: () {
                            //       // Some code to undo the change.
                            //     },
                            //   ),
                            // );
                            //
                            // _scaffoldState.currentState.showSnackBar(snackBar);
                          },
                          child: Text(
                            'Register New User',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTestBox extends StatefulWidget {
  final String validatorType;
  final bool obscure;
  final TextEditingController controller;
  final Size size;
  final String text;
  final String textHint;
  InfoTestBox(
      {this.controller,
      this.text,
      this.textHint,
      this.size,
      this.obscure,
      this.validatorType = 'usual'});

  @override
  _InfoTestBoxState createState() => _InfoTestBoxState();
}

class _InfoTestBoxState extends State<InfoTestBox> {
  var focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.size.width * 0.05,
                vertical: widget.size.width * 0.05),
            child: TextFormField(
              //onChanged: (input) => widget.controller.text = input,
              focusNode: focusNode,
              obscureText: widget.obscure == null ? false : widget.obscure,
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: widget.text,
                //hintText: widget.textHint,
              ),
              validator: widget.validatorType == "email"
                  ? (value) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value) || value == null)
                        return 'Enter a valid email address';
                      else
                        return null;
                    }
                  : widget.validatorType == "password"
                      ? (value) {
                          if (value.length < 6) {
                            return 'Weak password*';
                          }
                          return null;
                        }
                      : (value) {
                          if (value.isEmpty) {
                            return 'Field Required*';
                          }
                          return null;
                        },
            ),
          ),
        ),
      ],
    );
  }
}
