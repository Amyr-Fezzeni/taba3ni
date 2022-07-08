import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/services/logic_service.dart';
import 'package:taba3ni/services/notification_service.dart';
import 'package:taba3ni/widgets/popup.dart';

class UserService {
  static CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('users');

  static Future<String> addUser(UserModel user) async {
    if (await checkExistingUser(user.email)) {
      return "Email already exists";
    }
    user.id = generateId();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await collection
          .doc(user.id)
          .set(user.toMap())
          .whenComplete(() => log("user added"));
    } on Exception {
      return "An error has occurred, please try again later";
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
        .get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());
      UserModel user = UserModel.fromMap(snapshot.docs.first.data());
      return user;
    } else {
      return null;
    }
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final snapshot = await collection.where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());
      UserModel user = UserModel.fromMap(snapshot.docs.first.data());
      return user;
    } else {
      return null;
    }
  }

  static Future<GoogleSignInAccount?> getGoogleUserInfo(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn();

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      googleSignIn.signOut();

      return googleUser;
    } on PlatformException catch (e) {
      popup(context, "Ok", title: "Erreur", description: e.toString());
      return null;
    } catch (e) {
      popup(context, "Ok", title: "Erreur", description: e.toString());
      return null;
    }
  }

  static Future<bool> changePassword(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"password": user.password});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> changePhoneNumber(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"phoneNumber": user.phoneNumber});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> saveFcm(UserModel user) async {
    try {
      String? token = await NotificationService.getToken();
      if (token == null) return false;
      await FirebaseFirestore.instance.collection("users").doc(user.id).update(
          {'fcm': token}).whenComplete(() => log("token saved : $token"));
      return true;
    } on Exception catch (e) {
      log("token error : $e");
      return false;
    }
  }

  static Future<bool> removeFcm(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({'fcm': null}).whenComplete(() => log("token removed"));
      return true;
    } on Exception catch (e) {
      log("token error : $e");
      return false;
    }
  }

  static Future<String?> getUserFcm(String email) async {
    final snapshot = await collection.where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());

      return snapshot.docs.first.data()['fcm'];
    } else {
      return null;
    }
  }
}
