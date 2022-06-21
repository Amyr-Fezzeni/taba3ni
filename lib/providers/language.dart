import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taba3ni/constant/lang.dart';
import 'package:taba3ni/constant/lang_enum.dart';

class LanguageProvider with ChangeNotifier {
  Language currentLangCode = Language.en;
  Map<String, String> currentLanguage = en;

  Future<void> changeLanguage(String l) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("Language", l);
    await getLanguage();
    notifyListeners();
  }

  Future<void> getLanguage() async {
    var currentLang = await SharedPreferences.getInstance();
    if (currentLang.getString("Language") == "Français") {
      currentLanguage = fr;
    } else if (currentLang.getString("Language") == "English") {
      currentLanguage = en;
    } else if (currentLang.getString("Language") == "Arabic") {
      currentLanguage = ar;
    } else {
      currentLanguage = tn;
    }
  }

  String translate(String word) {
  
    if (currentLanguage.containsKey(word)) {
      return currentLanguage[word]!;
    } else {
    
      return word;
    }
  }
}
