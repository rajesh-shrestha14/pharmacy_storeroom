import 'package:flutter/rendering.dart';

class Medicine {
  String mId,
      mName,
      mMandate,
      mExpdate,
      mBatch,
      mQuantity,
      mIssueBy,
      mSupplier,
      mSuppAddress,
      mSuppContact,
      department,
      uId,
      createdAt,
      updatedAt;
  int mPrice;

  Medicine(
      {this.mId,
      this.mName,
      this.mMandate,
      this.mExpdate,
      this.mBatch,
      this.mQuantity,
      this.mIssueBy,
      this.mSupplier,
      this.mSuppAddress,
      this.mSuppContact,
      this.department,
      this.uId,
      this.createdAt,
      this.updatedAt,
      this.mPrice});

  Map<String, dynamic> toJason() {
    return {
      "id": mId,
      "name": mName,
      "manDate": mMandate,
      "expDate": mExpdate,
      "batch": mBatch,
      "quantity": mQuantity,
      "issueBy": mIssueBy,
      "supplier": mSupplier,
      "suppAddress": mSuppAddress,
      "suppContact": mSuppContact,
      "department": department,
      "userId": uId,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  Medicine.fromJason(Map<String, dynamic> medicine) {
    mId = medicine['id'];
    mName = medicine['name'];
    mMandate = medicine['manDate'];
    mExpdate = medicine['expDate'];
    mBatch = medicine['batch'];
    mQuantity = medicine['quantity'];
    mIssueBy = medicine['issueBy'];
    mSupplier = medicine['supplier'];
    mSuppAddress = medicine['suppAddress'];
    mSuppContact = medicine['suppContact'];
    department = medicine['department'];
    uId = medicine['userId'];
    createdAt = medicine['createdAt'];
    updatedAt = medicine['updatedAt'];
  }
}
