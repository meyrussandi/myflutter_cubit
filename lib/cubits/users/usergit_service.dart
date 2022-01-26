import 'package:myflutter_cubit/data/network/api.dart';
import 'package:myflutter_cubit/models/usergit_model.dart';

class UsersGitService{
  Future<List<UserGitModel>?> getUsers(int since)async{
    try{
      final res = await Api.getUsers(since);
      if(res is List){
        return res.map<UserGitModel>((e) => UserGitModel.fromJson(e)).toList();
      }
    }catch(e){
      return null;
    }

    return null;
  }
}