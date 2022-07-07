import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/services/shared_data.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/views/auth/login.dart';
import 'package:taba3ni/views/login/login.dart';
import 'package:taba3ni/widgets/popup.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser = UserModel(
      id: '212316546545123',
      fullName: 'Amyr fezzeni',
      email: 'anotique@gmail.com',
      phoneNumber: '54230376',
      password: 'azerty',
      location: const LatLng(47.56239938806303, 2.3078594729304314));

  bool isLoggedIn = false;
  bool isLoading = false;

  setUser(UserModel user) {
    currentUser = user;
    DataPrefrences.setLogin(user.phoneNumber.toString());
    DataPrefrences.setPassword(user.password);
    notifyListeners();
  }

  Future<String> signUpUser(UserModel user) async {
    isLoading = true;
    notifyListeners();
    var result = await UserService.addUser(user);
    if (result == "true") {
      UserModel? u = await UserService.getUserByEmail(user.email);
      if (u != null) {
        setUser(u);
      }
    }
    isLoading = false;
    notifyListeners();

    return result;
  }

  Future<String> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    UserModel? user = await UserService.getUserByEmail(email);
    if (user != null) {
      if (user.password == password) {
        setUser(user);
        isLoggedIn = true;
        isLoading = false;
        notifyListeners();
        return "true";
      } else {
        isLoading = false;
        notifyListeners();
        return "Phone number or password incorrect";
      }
    } else {
      isLoading = false;
      notifyListeners();
      return "Phone number doesn't exist";
    }
  }

  logOut(BuildContext context) {
    isLoggedIn = false;
    currentUser = null;
    DataPrefrences.setPassword("");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  final oldPassword = TextEditingController(text: "");
  final newPassword = TextEditingController(text: "");
  final newPasswordConfirmed = TextEditingController(text: "");

  initChangePassword() {
    oldPassword.text = "";
    newPassword.text = "";
    newPasswordConfirmed.text = "";
  }

  bool isObscureOld = true;
  changeOldVisibility() {
    isObscureOld = !isObscureOld;
    notifyListeners();
  }

  bool isObscure = true;
  changePassVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  bool isObscureConfirmed = true;
  changeConfPassVisibility() {
    isObscureConfirmed = !isObscureConfirmed;
    notifyListeners();
  }

  Future<void> validator(BuildContext context) async {
    if (newPasswordConfirmed.text.isEmpty || newPassword.text.isEmpty) {
      await popup(context, "Ok",
          title: "Notification", description: "All fields are required.");
    } else if (newPasswordConfirmed.text != newPassword.text) {
      await popup(context, "Ok",
          title: "Notification", description: "New passwords doesn't match.");
    } else if (oldPassword.text != currentUser?.password) {
      await popup(context, "Ok",
          title: "Notification", description: "Old password incorrect.");
    } else {
      currentUser?.password = newPassword.text;
      bool result = await UserService.changePassword(currentUser!);

      if (result) {
        await popup(context, "Ok",
            title: "Notification",
            description: "Password changed seccesfully.");
      } else {
        await popup(context, "Ok",
            title: "Notification",
            description: "Connection error, please try again later.");
      }

      Navigator.pop(context);
    }
  }

  Future<void> validatorPhone(BuildContext context, String phone) async {
    if (phone.isEmpty) {
      await popup(context, "Ok",
          title: "Notification", description: "Phone number empty!");
      return;
    }
    if (phone.length != 8) {
      await popup(context, "Ok",
          title: "Notification", description: "Phone number invalid!");
      return;
    }
    if (phone == currentUser?.phoneNumber.toString()) {
      await popup(context, "Ok",
          title: "Notification",
          description: "You can't update the same phone number!");
      return;
    }
    if (await UserService.checkExistingUser(phone)) {
      await popup(context, "Ok",
          title: "Notification", description: "Phone number already existe!");
      return;
    }
    currentUser?.phoneNumber = phone;
    bool result = await UserService.changePhoneNumber(currentUser!);

    if (result) {
      await popup(context, "Ok",
          title: "Notification",
          description: "Phone number changed seccesfully.");
      UserModel? user = await UserService.getUserByEmail(currentUser!.email);
      if (user != null) setUser(user);
      notifyListeners();
    } else {
      await popup(context, "Ok",
          title: "Notification",
          description: "Connection error, please try again later.");
    }

    Navigator.pop(context);
  }
}
