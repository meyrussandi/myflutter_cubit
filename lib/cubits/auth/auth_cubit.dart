import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myflutter_cubit/data/database/my_database.dart';
import 'package:myflutter_cubit/models/user_model.dart';
import 'package:myflutter_cubit/utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final MyDatabase _db;
  AuthCubit(this._db) : super(AuthInitial());


  Future register(UserModel userModel , String password)async{
    emit(AuthLoading());
    try{
      await _db.register(userModel, password);
      emit(AuthSuccess('Daftar Berhasil'));
    }catch(e){
      emit(AuthFailed(e.toString()));
    }
  }

  Future login(String email, String password)async{
    emit(AuthLoading());

    try{
      final data = await MyDatabase.instance.login(email, password);
      if(data is Map && data.containsKey('token')){
        final user = UserModel.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        emit(Authenticated(
          userModel: user,
          token: data['token']
        ));
      }else{
        emit(NoAuthenticated());
      }
    }catch(e){
      emit(AuthFailed(e.toString()));
    }
  }

  void showPassword(bool hide){
    if(hide){
      emit(AuthHidePassword());
    }else{
      emit(AuthShowPassword());
    }

  }
}
