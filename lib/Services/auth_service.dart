import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharmacy_storeroom/Model/user.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //instance to deal with firebase user
  FirebaseAuth authRef = FirebaseAuth.instance;
  String currentUserId;

  Future<void> register(AppUser user, String password) async {
    var email = user.email;
    //getting uid
    currentUserId = (await authRef.createUserWithEmailAndPassword(
            email: user.email, password: password))
        .user
        .uid;

    //setting user uid
    user.uId = currentUserId;
    //adding user to database
    await DatabaseService().userToDatabase(user);

    // saving id and user type to shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', currentUserId);
    prefs.setString('accountType', user.userType);
  }

//signing in via email and password for users who have already registered
  Future<void> signIn(
      {@required String email, @required String password}) async {
    //ensuring user exists if not function returns with null
    try {
      currentUserId = (await authRef.signInWithEmailAndPassword(
              email: email, password: password))
          .user
          .uid;
    } catch (e) {
      // this exception doesnot execute below code which can help in handling this event wherever called
      return;
    }
    print("----------user loggedIn : $email and $password-------------");
    //if user found then update shared preferences of userId and accountType
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', currentUserId);
    prefs.setString(
        'accountType',
        await DatabaseService()
            .userAttributeFromDatabase(currentUserId, 'userType'));
    print("----------preference set-------------");
  }

  Future<void> signOut() async {
    //signing out
    authRef.signOut();

    //setting user id and accoutn type null - removing user history in shared preferences
    currentUserId = null;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userId', currentUserId);
    await pref.setString('accountType', null);
    print("signedOut");
  }
}
