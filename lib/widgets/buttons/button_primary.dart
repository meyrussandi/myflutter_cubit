import 'package:flutter/material.dart';
import 'package:myflutter_cubit/config/config.dart';

class ButtonPrimary extends StatelessWidget {
  final void Function() onPress;
  final String label;
  final double? width;
  const ButtonPrimary({Key? key, required this.onPress, required this.label, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=>onPress(),
      child: Text(
        label,
        style: MyTextTheme.body1,
      ),
      style: ElevatedButton.styleFrom(
        primary: MyColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: Corners.lgBorder,
        ),
        minimumSize:  Size(width??MediaQuery.of(context).size.width, 45),
      ),
    );
  }
}
