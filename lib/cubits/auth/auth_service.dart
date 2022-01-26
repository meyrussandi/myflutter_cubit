
import 'package:myflutter_cubit/data/network/api.dart';

class AuthService{

  Future login (String email, String password)async{
    return await Api.login(email, password);
  }

}