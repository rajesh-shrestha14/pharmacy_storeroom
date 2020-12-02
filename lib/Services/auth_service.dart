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
  //var users = authRef.currentUser.uid;

  Future<void> register(AppUser user, String password) async {
    var email = user.email;
    // try{
    //
    // }catch (e){
    //
    // }
    currentUserId = (await authRef.createUserWithEmailAndPassword(
            email: user.email, password: password))
        .user
        .uid;

    //setting user uid
    user.uId = currentUserId;
    //adding user to database
    await DatabaseService().userToDatabase(user);
    //getting uid

    // saving id and user type to shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', currentUserId);
    await prefs.setString('accountType', user.userType);
    //signed out user once registered or
    // optionally add user usinganother app to maintain current
    // user status
    await signOut();
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
      return;
    }
    //if user found then update shared preferences of userId and accountType
    String accountType = await DatabaseService()
        .userAttributeFromDatabase(currentUserId, 'userType');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', currentUserId);
    prefs.setString('accountType', accountType);
  }

  Future<void> signOut() async {
    //signing out
    authRef.signOut();

    //setting user id and accoutn type null - removing user history in shared preferences
    currentUserId = null;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userId', currentUserId);
    await pref.setString('accountType', null);
  }

  Future<void> changeCurrentUsersPassword(String password) async {
    //Create an instance of the current user.
    User user = await FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Your password changed Succesfully ");
    }).catchError((err) {
      print("You can't change the Password" + err.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
