import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class User {
  String userId;
  String phoneNumber;
  String userName;
  String password;

  User({
    this.userId,
    this.phoneNumber,
    this.userName,
    this.password,
  });

  User.fromMap(DocumentSnapshot snapshot, String id)
      : userId = id ?? '',
        phoneNumber = snapshot[COL_PHONE_NUMBER] ?? '',
        userName = snapshot[COL_USER_NAME] ?? '',
        password = snapshot[COL_PASSWORD] ?? '';

  toJson() {
    return {
      COL_PHONE_NUMBER: phoneNumber,
      COL_USER_NAME: userName,
      COL_PASSWORD: password
    };
  }
}
