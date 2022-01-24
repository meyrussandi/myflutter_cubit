import 'package:flutter/material.dart';

class MyColors {
  //BRANDCOLOR

  static const MaterialColor mainColor = MaterialColor(
    _mainColorValue,
    <int, Color>{
      50: Color(0xFFf3faf7),
      100: Color(0xFFdef7ec),
      200: Color(0xFFbcf0da),
      300: Color(0xFF84e1bc),
      400: Color(0xFF31c48d),
      500: Color(_mainColorValue),
      600: Color(0xFF057a55),
      700: Color(0xFF046c4e),
      800: Color(0xFF03543f),
      900: Color(0xFF014737),
    },
  );
  static const int _mainColorValue = 0xFF0e9f6e;

  static const MaterialColor secondColor = MaterialColor(
    _secondColorValue,
    <int, Color>{
      50: Color(0xFFcaf0f8),
      100: Color(0xFFade8f4),
      200: Color(0xFF90e0ef),
      300: Color(0xFF48cae4),
      400: Color(0xFF00b4d8),
      500: Color(_secondColorValue),
      600: Color(0xFF0077b6),
      700: Color(0xFF023e8a),
      800: Color(0xFF03045e),
    },
  );
  static const int _secondColorValue = 0xFF0096c7;

  //NEUTRAL
  static const MaterialColor bodyColor = MaterialColor(
    _bodyColorValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFAFAFA),
      200: Color(0xFFE1E1E1),
      300: Color(0xFFC7C7C7),
      400: Color(0xFFAEAEAE),
      500: Color(0xFF949494),
      600: Color(0xFF787878),
      700: Color(0xFF5c5c5c),
      800: Color(0xFF404040),
      900: Color(0xFF242424),
    },
  );
  static const int _bodyColorValue = 0xFF242424;

  //ACCENT
  static const Color errorColor = Color(0xFFD95952); //Danger - Use for errors
  static const Color successColor = Color(0xFF16D090); //Succes - Use for Succes
  static const Color whiteColor = Color(0xFFFFFFFF);

  static const Color weakColor = Color(0xFFBDBDBD); //Weak - Use for secondary text
  static const Color weak2Color = Color(0xFFF6F4F4); //Weak - Use for secondary text

  //GRADIENT
  static const LinearGradient gradient1 = LinearGradient(colors: [
    Color(0XFF52b69a),
    Color(0XFF76c893),
  ], begin: Alignment.topCenter, end: Alignment.centerRight);
}