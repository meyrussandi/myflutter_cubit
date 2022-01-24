import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myflutter_cubit/config/config.dart';

class MyTextTheme {
  /// Declare a base style for each Family
  static TextStyle robotoMono = GoogleFonts.robotoMono();

  static TextStyle get heading1 => robotoMono.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: FontSizes.s32,
      letterSpacing: 0.5,
      height: 1.50);
  static TextStyle get heading2 => heading1.copyWith(
    fontSize: FontSizes.s24,
  );
  static TextStyle get heading3 => heading1.copyWith(
    fontSize: FontSizes.s20,
  );
  static TextStyle get heading4 => heading1.copyWith(fontSize: FontSizes.s16);
  static TextStyle get heading5 => heading1.copyWith(fontSize: FontSizes.s14);
  static TextStyle get heading6 => heading1.copyWith(fontSize: FontSizes.s10);


  static TextStyle get body1 => robotoMono.copyWith(
      fontWeight: FontWeight.normal, fontSize: FontSizes.s14);
  static TextStyle get body2 => body1.copyWith(fontSize: FontSizes.s14);
  static TextStyle get small1 => robotoMono.copyWith(
    fontSize: FontSizes.s12,
    fontWeight: FontWeight.normal,
  );
  static TextStyle get small2 => robotoMono.copyWith(
      fontSize: FontSizes.s10, fontWeight: FontWeight.normal);
}