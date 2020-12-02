import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmacy_storeroom/Model/medicine.dart';
import 'package:pharmacy_storeroom/Model/notice.dart';
import 'package:pharmacy_storeroom/Model/user.dart';
import 'package:pharmacy_storeroom/Services/show_dialogue.dart';

class DatabaseService {
  //this instance will be used to fetch data from the firebase
  FirebaseFirestore ref = FirebaseFirestore.instance;
  //adding user to firebase database
  Future<void> userToDatabase(AppUser user) async {
    try {
      await ref.collection('users').doc(user.uId).set(user.toJason());
      return;
    } on Exception catch (e) {
      print(
          "=========================failed to add data to firestore with e: $e=================");
    }
  }

  //getting userType from firebase
  Future<String> userAttributeFromDatabase(
      String userId, String attribute) async {
    DocumentSnapshot snapshot = await ref.collection('users').doc(userId).get();
    if (snapshot.exists)
      try {
        //print(snapshot.toString());
        return snapshot.get(attribute);
      } catch (e) {
        print(e);
        return null;
      }
  }

  Future<void> getAllUser() {}

  Future<void> medicineToDatabase(MedicineModel medicine) async {
    try {
      //adding medicine
      var data = await ref
          .collection('medicine')
          .add(medicine.toJason())
          .then((value) => value.id);

      //updating medicine id
      await ref
          .collection('medicine')
          .doc(data)
          .update({'id': data}).then((value) => print(data));
      return;
    } on Exception catch (e) {
      print(
          "=========================failed to add data to firestore with e: $e=================");
    }
  }

  Future<List<MedicineModel>> medicineFromDatabase() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("medicine").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs.map((value) {
        print(value.data());
        return MedicineModel.fromJason(value.data());
      }).toList();
      return a;
    }
  }

  Future<void> noticeToDatabase(
      NoticeModel notice, BuildContext context) async {
    try {
      var data = await ref
          .collection('notice')
          .add(notice.toJason())
          .then((value) => value.id);
      await ref
          .collection('notice')
          .doc(data)
          .update({'noticeId': data}).then((value) => print(data));
      return;
    } on Exception catch (e) {
      print(
          "=========================failed to add data to firestore with e: $e=================");
    }
  }

  Future<void> updateUser(AppUser user) async {
    try {
      await ref.collection('users').doc(user.uId).update(user.toJason());
      return;
    } on Exception catch (e) {
      print(
          "=========================failed to add data to firestore with e: $e=================");
    }
  }

  Future<void> noticeFromDatabase() {
    //TODO
  }
  Future<void> deleteData(
      {@required String collectionName, @required String documentId}) async {
    await ref
        .collection(collectionName)
        .doc(documentId)
        .delete()
        .then((value) => print('document deleted'));
  }
  // getdata(collectionName) {
  //   ref.collection(collectionName).get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print(doc.data);
  //       print(doc.id);
  //     });
  //   });
  // }
}
