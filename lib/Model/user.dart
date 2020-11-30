import 'package:pharmacy_storeroom/Screens/user_profile.dart';

class AppUser {
  String uId,
      email,
      firstName,
      lastName,
      address,
      position,
      phoneNumber,
      imageURL,
      username,
      userType;
  DateTime createdAt, updatedAt;

  AppUser({
    this.uId,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.position,
    this.phoneNumber,
    this.imageURL,
    this.username,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJason() => {
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'username': username,
        'imageURL': imageURL,
        'phoneNumber': phoneNumber,
        'position': position,
        'userType': userType,
        'uId': uId,
        'email': email,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
  AppUser.fromJason(Map<String, dynamic> user) {
    uId = user['uId'];
    email = user['email'];
    firstName = user['firstName'];
    lastName = user['lastName'];
    address = user['address'];
    position = user['position'];
    phoneNumber = user['phoneNumber'];
    imageURL = user['imageURL'];
    username = user['userType'];
    userType = user['uId'];
    createdAt = user['createdAt'];
    updatedAt = user['updateAt'];
  }
}
