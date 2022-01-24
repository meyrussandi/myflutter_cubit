import 'package:flutter/material.dart';
import 'package:myflutter_cubit/config/config.dart';

class PagePrimary extends StatelessWidget {
  final Widget child;
  const PagePrimary({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: MyColors.gradient1
            ),
            child:SafeArea(child: child)
          ),
        ),
      ),
    );
  }
}
