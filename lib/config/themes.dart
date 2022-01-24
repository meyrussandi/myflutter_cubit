import 'package:flutter/material.dart';
import 'package:myflutter_cubit/config/config.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: MyColors.mainColor,
  primarySwatch: MyColors.mainColor,
  textTheme: TextTheme(
    bodyText1: MyTextTheme.body1,
    bodyText2: MyTextTheme.body2,
  ).apply(
    bodyColor: MyColors.bodyColor[900],
    displayColor: MyColors.bodyColor[900]
  ),
  fontFamily: 'robotoMono'
);