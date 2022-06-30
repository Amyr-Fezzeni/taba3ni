import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/view/auth/login.dart';
import 'package:taba3ni/view/home.dart';
import 'package:taba3ni/widgets/popup.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  bool isLoading = false;

  Future<GoogleSignInAccount?> googleLogin(BuildContext context) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      _user = googleUser;
      print("_user!.displayName");
      print(_user!.displayName);
      print(_user!.email);
      print(_user!.photoUrl);
      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      if (_user != null) {
        return _user;
      }
      return null;
      /*await FirebaseAuth.instance.signInWithCredential(credential);
      var auth = FirebaseAuth.instance.currentUser;
      if (auth != null) {
        var _token = await SharedPreferences.getInstance();
        _token.setString("token", auth.uid);
        _token.setString("email", auth.email ?? "");
        await addUser(auth);
        notifyListeners();
        return true;
      }
      return false;*/

    } on PlatformException catch (e) {
      if (e.code == "sign_in_canceled") {
      } else {
        popup(context, "Ok", title: "Error", description: e.toString());
        return null;
      }
    } catch (e) {
      popup(context, "Ok", title: "Error", description: e.toString());
      return null;
    }
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
    }
  }

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
}
