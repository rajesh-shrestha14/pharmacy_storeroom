import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Model/notice.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';

class NoticeBox extends StatelessWidget {
  NoticeModel notice;
  NoticeBox({@required this.notice});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.03),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              children: [
                Text(
                  'Subject',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Expanded(
                  child: Text(
                    notice.subject,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Expanded(
                  child: Text(
                    notice.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Update'),
            ),
            RaisedButton(
              onPressed: () {
                DatabaseService().deleteData(
                    collectionName: 'notice', documentId: notice.noticeId);
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
