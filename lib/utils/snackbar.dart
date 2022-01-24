import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter_cubit/config/config.dart';

extension BuildContextSnackbar on BuildContext{
  void snackbar(String title,String message){
    Get.snackbar(title, message, backgroundColor: MyColors.mainColor, colorText: MyColors.bodyColor.shade50);
  }

  void errorSnackbar(String message){
    Get.snackbar('error', message, backgroundColor: MyColors.errorColor, colorText: MyColors.bodyColor.shade50);
  }
}