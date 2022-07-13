<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======
import 'dart:developer';

>>>>>>> master
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/models/user.dart';
<<<<<<< HEAD
import 'package:taba3ni/view/auth/login.dart';
import 'package:taba3ni/view/home.dart';
=======
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/services/shared_data.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/views/login/getstarted.dart';
import 'package:taba3ni/views/login/signup.dart';
import 'package:taba3ni/views/page_structure.dart';
>>>>>>> master
import 'package:taba3ni/widgets/popup.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleUser;
  GoogleSignInAccount get user => googleUser!;
  bool isLoading = false;
  UserModel? currentUser;

<<<<<<< HEAD
  Future<GoogleSignInAccount?> googleLogin(BuildContext context) async {
    try {
      final user = await googleSignIn.signIn();
      if (user == null) return null;
      googleUser = user;
      if (googleUser != null) {
        return googleUser;
      }
      return null;

    } on PlatformException catch (e) {
      if (e.code == "sign_in_canceled") {
      } else {
        popup(context, "Ok", title: "Error", description: e.toString());
        return null;
      }
    } catch (e) {
      popup(context, "Ok", title: "Error", description: e.toString());
      return null;
=======
  Future<bool> checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 50));
    log("Shared prefrences : ${DataPrefrences.getLogin()}, ${DataPrefrences.getPassword()}");
    if (DataPrefrences.getLogin().isNotEmpty &&
        DataPrefrences.getPassword().isNotEmpty) {
      login(context, DataPrefrences.getLogin(), DataPrefrences.getPassword());
      return true;
    }
    return false;
  }

  Future<void> removeData(BuildContext context) async {
    await UserService.removeFcm(currentUser!);
    context.read<UserProvider>().remodeData();
    currentUser = null;
    DataPrefrences.setLogin("");
    DataPrefrences.setPassword("");
  }

  Future<void> logOut(BuildContext context) async {
    await removeData(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const IndexScreen()));
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();
    final result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    log(result.toString());
    var user = await UserService.getUser(email, password);

    if (user != null) {
      user.location = await UserService.getUserCurrentLocation();
      await UserService.updateLocation(user, user.location!);
      currentUser = user;
      DataPrefrences.setLogin(email);
      DataPrefrences.setPassword(password);
      await UserService.saveFcm(user);
      log("connected");
      context.read<UserProvider>().setUser(user);
      isLoading = false;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const PageStructure()));
    } else {
      isLoading = false;
      notifyListeners();
      await popup(context, "Ok",
          title: "Notification",
          description: "Email ou mot de passe incorrect");
>>>>>>> master
    }
    return null;
  }

  loginWithEmail(BuildContext context, String email, password) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        isLoading = false;
        notifyListeners();
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
       
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e);
      popup(context, "Ok", title: "Error", description: e.toString());
    }
  }

<<<<<<< HEAD
  signUpWithMail(BuildContext context, UserModel user) async {
    isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      print("user.toJson(");
      print(user.toJson());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      if (credential.user != null) {
        await addMyUser(credential.user!, user);
        prefs.setString("password", user.password);
        prefs.setString("email", user.email);
        isLoading = false;
        notifyListeners();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        isLoading = false;
        notifyListeners();
        popup(context, "Ok",
            title: "Error",
            description: "An error has occurred , Please try again");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        isLoading = false;
        notifyListeners();
        popup(context, "Ok",
            title: "Error", description: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        isLoading = false;
        notifyListeners();
        popup(context, "Ok",
            title: "Error", description: 'The password provided is too weak.');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e);
      popup(context, "Ok", title: "Error", description: e.toString());
=======
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
        password: password,
        baned: [],
        followed: [],
        requested: [],
        sentRequest: [],
        sharedLocation: []);

    var result = await UserService.addUser(tempUser);

    if (result == "true") {
      var user = await UserService.getUser(tempUser.email, tempUser.password);
      if (user != null) {
        user.location = await UserService.getUserCurrentLocation();
        await UserService.updateLocation(user, user.location!);
        currentUser = user;
        UserService.saveFcm(user);
        DataPrefrences.setLogin(email);
        DataPrefrences.setPassword(password);
        context.read<UserProvider>().setUser(user);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const PageStructure()));
      }
    }
  }

  Future<GoogleSignInAccount?> googleLogIn(
      BuildContext context, bool isSignUp) async {
    isLoading = true;
    notifyListeners();
    var googleUser = await UserService.getGoogleUserInfo(context);
    if (googleUser != null) {
      log(googleUser.photoUrl.toString());
      if (await UserService.checkExistingUser(googleUser.email)) {
        currentUser = await UserService.getUserByEmail(googleUser.email);
        currentUser!.location = await UserService.getUserCurrentLocation();
        await UserService.updateLocation(currentUser!, currentUser!.location!);
        context.read<UserProvider>().setUser(currentUser!);
        DataPrefrences.setLogin(currentUser!.email);
        DataPrefrences.setPassword(currentUser!.password);
        await UserService.saveFcm(currentUser!);
        isLoading = false;
        notifyListeners();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const PageStructure()));
      } else {
        isLoading = false;
        notifyListeners();
        if (isSignUp) return googleUser;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => SignUpScreen(
                      name: googleUser.displayName ?? "",
                      email: googleUser.email,
                      photo: googleUser.photoUrl ?? "",
                    )));
      }
>>>>>>> master
    }
    isLoading = false;
    notifyListeners();
    return null;
  }
<<<<<<< HEAD

  addMyUser(User? guser, UserModel? user) async {
    if (user != null && guser != null) {
      final docUser = FirebaseFirestore.instance.collection("users");
      final newUser = UserModel(
          id: guser.uid,
          email: user.email,
          fullName: user.fullName,
          image: guser.photoURL,
          phoneNumber: user.phoneNumber,
          password: user.password);
      await docUser.doc(guser.uid).set(newUser.toMap());
    }
  }

  Future<bool> googleLogout() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> checkPassword(String password) async {
    try {
      var _token = await SharedPreferences.getInstance();
      String? sh = _token.getString("password");
      if (sh == password) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
=======
>>>>>>> master
}
