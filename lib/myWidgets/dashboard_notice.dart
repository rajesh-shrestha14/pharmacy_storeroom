import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardNoticeBox extends StatelessWidget {
  String subject, description;
  DashboardNoticeBox({this.subject, this.description});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01),
      child: Container(
        // height: size.height * 0.2,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: Text(subject)),
            Expanded(
              child: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}
