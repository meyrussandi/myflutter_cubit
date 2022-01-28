import 'package:flutter/material.dart';
import 'package:myflutter_cubit/config/config.dart';

class PagePrimary extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final AppBar? appBar;
  const PagePrimary({Key? key, required this.child, this.padding, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: appBar != null?
      Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
              padding: padding??EdgeInsets.symmetric(horizontal: Insets.lg),
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: MyColors.gradient1
              ),
              child:SafeArea(child: child)
          ),
        ),
      )

          :Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: padding??EdgeInsets.all(0),
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
