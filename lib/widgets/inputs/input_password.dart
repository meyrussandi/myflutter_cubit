import 'package:flutter/material.dart';
import 'package:myflutter_cubit/config/config.dart';

class InputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  const InputPassword({Key? key, required this.controller, this.label}) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:hidePassword,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        suffixIcon: IconButton(onPressed: (){
          setState(() {
            hidePassword = !hidePassword;
          });
        }, icon:hidePassword?Icon(Icons.visibility):const Icon(Icons.visibility_off)),

        label: Text(
          widget.label??"kata sandi",
          style: MyTextTheme.small1
              .copyWith(color: MyColors.mainColor),
        ),
        hintText: "Masukan ${widget.label??"kata sandi"}",
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
