import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:taba3ni/models/user.dart';

class UserService {
  static CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('users');

  static Future<String> addUser(UserModel user) async {
    if (await checkExistingUser(user.email)) {
      return "Phone number already existe";
    }
    user.id = generateId();
    try {
      await collection
          .doc(user.id)
          .set(user.toMap())
          .whenComplete(() => log("user added"));
    } on Exception {
      return "An error has occured, please try again";
    }
    return "true";
  }

  static Future<bool> checkExistingUser(String email) async {
    final snapshot =
        await collection.where('email', isEqualTo: email).limit(1).get();
    if (snapshot.docs.isNotEmpty) return true;
    return false;
  }

  static Future<UserModel?> getUser(String email, String password) async {
    final snapshot = await collection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());
      return UserModel.fromMap(snapshot.docs.first.data());
    } else {
      return null;
    }
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final snapshot =
        await collection.where('email', isEqualTo: email).limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());
      return UserModel.fromMap(snapshot.docs.first.data());
    } else {
      return null;
    }
  }

  static Future<bool> changePassword(UserModel user) async {
    try {
      await collection.doc(user.id).update({"password": user.password});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> changePhoneNumber(UserModel user) async {
    try {
      await collection.doc(user.id).update({"phoneNumber": user.phoneNumber});
      return true;
    } on Exception {
      return false;
    }
  }

  static String generateId() {
    ObjectId id1 = ObjectId();
    return id1.toHexString();
  }
}
