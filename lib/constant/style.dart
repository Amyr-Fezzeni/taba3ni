import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightBgColor = Color.fromARGB(255, 236, 236, 236);
const lightBlueColor = Color.fromARGB(255, 153, 235, 255);
const darkBgColor = Color.fromARGB(255, 35, 45, 55);
const lightOrange = Color.fromARGB(255, 245, 187, 133);
const darkBtnColor = Color.fromARGB(255, 41, 190, 254);

TextStyle text18black = GoogleFonts.nunito(color: Colors.black87, fontSize: 18);
TextStyle text18white = GoogleFonts.nunito(color: Colors.white, fontSize: 18);
TextStyle titleBlue = GoogleFonts.nunito(color: lightBlueColor, fontSize: 22);
TextStyle titleWhite = GoogleFonts.nunito(
    color: Colors.white, fontSize: 35, fontWeight: FontWeight.w800);
TextStyle titleblack = GoogleFonts.nunito(color: Colors.black, fontSize: 22);

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.black,
  backgroundColor: darkBgColor,
);
