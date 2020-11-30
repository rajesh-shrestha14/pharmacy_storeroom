import 'dart:convert';

import 'package:pharmacy_storeroom/Services/get_from_shared_preference.dart';

class NoticeModel {
  String noticeId, description, subject;
  DateTime createdAt, updatedAt;
  NoticeModel(
      {this.noticeId,
      this.description,
      this.subject,
      this.createdAt,
      this.updatedAt});

  NoticeModel.fromJson(Map<String, dynamic> notice) {
    noticeId = notice['noticeId'];
    description = notice['description'];
    subject = notice['subject'];
    createdAt = notice['createdAt'].toDate();
    updatedAt = notice['updatedAt'].toDate();
  }
  Map<String, dynamic> toJason() {
    return {
      "noticeId": noticeId,
      "description": description,
      "subject": subject,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
