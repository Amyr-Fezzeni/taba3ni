import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/services/shared_data.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/views/login/getstarted.dart';
import 'package:taba3ni/views/login/signup.dart';
import 'package:taba3ni/views/page_structure.dart';
import 'package:taba3ni/widgets/popup.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleUser;
  GoogleSignInAccount get user => googleUser!;
  bool isLoading = false;

  Future<bool?> checkLogin(BuildContext context) async {
    log("Shared prefrences : ${DataPrefrences.getLogin()}, ${DataPrefrences.getPassword()}");
    if (DataPrefrences.getLogin().isNotEmpty &&
        DataPrefrences.getPassword().isNotEmpty) {
      login(context, DataPrefrences.getLogin(), DataPrefrences.getPassword());
    }
    return false;
  }

  Future<void> removeData() async {
    await UserService.removeFcm(currentUser!);
    currentUser = null;
    DataPrefrences.setLogin("");
    DataPrefrences.setPassword("");
  }

  Future<void> logOut(BuildContext context) async {
    await removeData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const IndexScreen()));
  }

  UserModel? currentUser;

  Future<void> login(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();
    // final result = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);

    var user = await UserService.getUser(email, password);
    isLoading = false;
    notifyListeners();
    if (user != null) {
      currentUser = user;
      DataPrefrences.setLogin(email);
      DataPrefrences.setPassword(password);
      await UserService.saveFcm(user);
      log("connected");
      context.read<UserProvider>().setUser(user);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const PageStructure()));
    } else {
      await popup(context, "Ok",
          title: "Notification",
          description: "Email ou mot de passe incorrect");
    }
  }

  Future<void> signup(BuildContext context, String name, String email,
      String phoneNumber, String password,
      {String photo = ""}) async {
    isLoading = true;
    notifyListeners();

    isLoading = false;
    UserModel tempUser = UserModel(
        fullName: name.trim(),
        email: email.toString().trim(),
        phoneNumber: phoneNumber,
        image: photo,
        password: password);

    var result = await UserService.addUser(tempUser);

    if (result == "true") {
      var user = await UserService.getUser(tempUser.email, tempUser.password);
      if (user != null) {
        currentUser = user;
        await UserService.saveFcm(user);
        DataPrefrences.setLogin(email);
        DataPrefrences.setPassword(password);
        context.read<UserProvider>().setUser(user);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const PageStructure()));
      }
    }
  }

  Future<void> googleLogIn(BuildContext context) async {
    var googleUser = await UserService.getGoogleUserInfo(context);
    if (googleUser != null) {
      log(googleUser.photoUrl.toString());
      if (await UserService.checkExistingUser(googleUser.email)) {
        currentUser = await UserService.getUserByEmail(googleUser.email);
        DataPrefrences.setLogin(currentUser!.email);
        DataPrefrences.setPassword(currentUser!.password);
        await UserService.saveFcm(currentUser!);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const PageStructure()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => SignUpScreen(
                      name: googleUser.displayName ?? "",
                      email: googleUser.email,
                      photo: googleUser.photoUrl ?? "",
                    )));
      }
    }
  }

  Future<void> updateUser() async {
    currentUser =
        await UserService.getUser(currentUser!.email, currentUser!.password);
    notifyListeners();
  }
}
