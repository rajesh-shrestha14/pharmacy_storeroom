import 'package:flutter/rendering.dart';

class MedicineModel {
  String mId,
      mName,
      mBatch,
      mIssueBy,
      mSupplier,
      mSuppAddress,
      mSuppContact,
      department,
      uId;
  double mQuantity;
  double mPrice;
  DateTime mManDate, createdAt, updatedAt, mExpDate;

  MedicineModel(
      {this.mId,
      this.mName,
      this.mManDate,
      this.mExpDate,
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
      "manDate": mManDate,
      "expDate": mExpDate,
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
      "price": mPrice,
    };
  }

  MedicineModel.fromJason(Map<String, dynamic> medicine) {
    mId = medicine['id'];
    mName = medicine['name'];
    mManDate = medicine['manDate'].toDate();
    mExpDate = medicine['expDate'].toDate();
    mBatch = medicine['batch'];
    mQuantity = medicine['quantity'];
    mIssueBy = medicine['issueBy'];
    mSupplier = medicine['supplier'];
    mSuppAddress = medicine['suppAddress'];
    mSuppContact = medicine['suppContact'];
    department = medicine['department'];
    uId = medicine['userId'];
    createdAt = medicine['createdAt'].toDate();
    updatedAt = medicine['updatedAt'].toDate();
    mPrice = medicine['price'];
  }
}
