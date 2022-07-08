import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/services/shared_data.dart';


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
     DataPrefrences.setDarkMode(darkMode);
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
