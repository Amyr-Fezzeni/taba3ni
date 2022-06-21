import 'package:flutter/material.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/services/local_storage_manager.dart';


class ThemeNotifier with ChangeNotifier {
  Color bgColor = lightBgColor;
  TextStyle text18 = text18black;
  TextStyle title = titleblack;
  bool darkMode = false;
  Color btnColor = lightBlueColor;

  void changeDarkMode(value) async {
    switch (value) {
      case true:
        bgColor = darkBgColor;
        text18 = text18white;
        title = titleWhite;
        btnColor = darkBtnColor;
        break;
      case false:
        bgColor = lightBgColor;
        text18 = text18black;
        title = titleblack;
        btnColor = lightBlueColor;
        break;
      default:
        break;
    }
    darkMode = value;
    notifyListeners();
     StorageManager.saveData("darkMode", darkMode);
  }
  initTheme(value){
      switch (value) {
      case true:
        bgColor = darkBgColor;
        text18 = text18white;
        title = titleWhite;
        btnColor = darkBtnColor;
        break;
      case false:
        bgColor = lightBgColor;
        text18 = text18black;
        title = titleblack;
        btnColor = lightBlueColor;
        break;
      default:
        break;
    }
    darkMode = value;
  }
}
