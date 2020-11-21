import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_storeroom/Model/user.dart';

class DatabaseService {
  //this instance will be used to fetch data from the firebase
  FirebaseFirestore ref = FirebaseFirestore.instance;

  //adding user to firebase database
  Future<void> userToDatabase(AppUser user) async {
    try {
      await ref.collection('users').doc(user.uId).set(user.toJason());
      return;
    } on Exception catch (e) {
      print("failed to add data to firestore with e: $e");
    }
  }

  //getting userType from firebase
  Future<String> userAttributeFromDatabase(
      String userId, String attribute) async {
    DocumentSnapshot snapshot = await ref.collection('users').doc(userId).get();
    if (snapshot.exists)
      try {
        return snapshot.get(attribute);
      } catch (e) {
        print(e);
        return null;
      }
  }

  Future<void> getAllUser() {}

  Future<void> medicineToDatabase() {
    //TODO
  }
  Future<void> medicineFromDatabase() {
    //TODO
  }
  Future<void> noticeToDatabase() {
    //TODO
  }
  Future<void> noticeFromDatabase() {
    //TODO
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
