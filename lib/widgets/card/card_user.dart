import 'package:flutter/material.dart';
import 'package:myflutter_cubit/config/config.dart';
import 'package:myflutter_cubit/models/usergit_model.dart';

class CardUser extends StatelessWidget {
  final UserGitModel userGitModel;
  const CardUser({Key? key, required this.userGitModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.bodyColor.shade200
      ),
      child: ListTile(
        leading: CircleAvatar(
          foregroundImage: NetworkImage(userGitModel.avatarUrl!),
        ),
        title: Text(userGitModel.login!),
      ),
    );
  }
}
