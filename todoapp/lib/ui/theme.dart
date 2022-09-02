// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final Light = ThemeData(
      primaryColor: primaryClr,
      backgroundColor: Colors.white,
      brightness: Brightness.light);
  static final Dark = ThemeData(
      primaryColor: darkGreyClr,
      backgroundColor: darkGreyClr,
      brightness: Brightness.dark);
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold));
}

TextStyle get SubheadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold));
}

TextStyle get tittleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold));
}

TextStyle get SubtittleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400));
}

TextStyle get BodyStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.black : Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400));
}

TextStyle get Body2Style {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.grey[200] : Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400));
}
