import 'dart:convert';

class Notice {
  String uId, description, subject, createdAt, updateedAt;

  Notice(this.uId, this.description, this.subject, this.createdAt,
      this.updateedAt);

  Notice.fromJson(Map<String, dynamic> notice) {
    uId = notice['uId'];
    description = notice['description'];
    subject = notice['subject'];
    createdAt = notice['createdAt'];
    updateedAt = notice['updatedAt'];
  }
  Map<String, dynamic> toJason() {
    return {
      "uId": uId,
      "description": description,
      "subject": subject,
      "createdAt": createdAt,
      "updatedAt": updateedAt,
    };
  }
}
