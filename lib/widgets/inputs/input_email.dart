import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter_cubit/config/config.dart';

class InputEmail extends StatelessWidget {
  final TextEditingController controller;
  const InputEmail({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v){
        if(!GetUtils.isEmail(v!)){
          return 'Masukan email dengan benar';
        }
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        label: Text(
          'email',
          style: MyTextTheme.small1
              .copyWith(color: MyColors.mainColor),
        ),
        hintText: "Masukan Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Corners.xl),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Corners.xl),
        ),
      ),
    );
  }
}
