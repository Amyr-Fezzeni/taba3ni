import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taba3ni/constant/size_config.dart';

var wm = SizeConfig.widthMultiplier;
var tm = SizeConfig.textMultiplier;

const lightBgColor = Color.fromARGB(255, 236, 206, 151);
const lightBlueColor = Color.fromARGB(255, 153, 235, 255);
const darkBgColor = Color.fromARGB(255, 35, 45, 55);
const lightOrange = Color.fromARGB(255, 245, 187, 133);
const darkBtnColor = Color.fromARGB(255, 241, 99, 11);

TextStyle text18black = GoogleFonts.nunito(color: Colors.black87, fontSize: tm!*1.8);
TextStyle text18white = GoogleFonts.nunito(color: Colors.white, fontSize: tm!*1.8);
TextStyle titleBlue = GoogleFonts.nunito(color: lightBlueColor, fontSize:  tm!*3);
TextStyle titleWhite = GoogleFonts.nunito(color: Colors.white, fontSize: tm!*3,fontWeight: FontWeight.w800);
TextStyle titleblack = GoogleFonts.nunito(color: Colors.black, fontSize: tm!*3);

ThemeData darkTheme =  ThemeData(
      primaryColor: Colors.black,
      backgroundColor:   darkBgColor,
    );

