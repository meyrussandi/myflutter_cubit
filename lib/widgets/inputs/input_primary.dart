import 'package:flutter/material.dart';
import 'package:myflutter_cubit/config/config.dart';

class InputPrimary extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  const InputPrimary({Key? key, required this.controller, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        label: Text(
          label??'',
          style: MyTextTheme.small1
              .copyWith(color: MyColors.mainColor),
        ),
        hintText: "Masukan ${label??''}",
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
