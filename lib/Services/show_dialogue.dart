import 'package:flutter/material.dart';

class DialogService {
  addedToDatabase({BuildContext context, String title, String message}) {
    var dialog = AlertDialog(
      title: Center(child: Text(title)),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  addingToDatabase({BuildContext context, String message}) async {
    SimpleDialog dialog = SimpleDialog(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            CircularProgressIndicator(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(message)
          ],
        ),
      ],
    );
    showDialog(context: context, builder: (_) => dialog);
    await Future.delayed(Duration(seconds: 4));
    Navigator.pop(context);
  }

  forLogInError(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Login Failed!!")),
            content: Text(
              "No User Error! / Incorrect Input / No Network Connection",
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  forRegistrationError(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Registration Failed!!")),
            content: Text(
              "Password Not Strong! / Invalid Email / Email already existed",
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  forRegistration(BuildContext context) {
    SimpleDialog dialog = SimpleDialog(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            CircularProgressIndicator(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text("Registering User...")
          ],
        ),
      ],
    );
    showDialog(context: context, builder: (_) => dialog);
  }

  forRegistrationSuccess(BuildContext context) {
    SimpleDialog dialog = SimpleDialog(
      title: Row(
        children: [Icon(Icons.done_all), Text('Successfully Registered')],
      ),
      children: [
        Text(
          "Congratulation user added successfully",
          textAlign: TextAlign.center,
        ),
      ],
    );
    showDialog(context: context, builder: (_) => dialog);
  }
}
