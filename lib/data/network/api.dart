import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

part 'api_handler.dart';
part 'api_exception.dart';
part 'api_constants.dart';

class Api{
  static final ApiHandler _handler = ApiHandler();

  static Future login(String email, String password)async{
    /* return await _handler.post(loginUrl, {
      'username': username,
      'password': password,
    }); */

    // dummy delay
    await Future.delayed(const Duration(seconds: 2));

    // dummy login data
    return {
      'id': 1,
      'token': email,
      'name': email,
      'email': '$email@gmail.com',
      'gender': 'male',
      'status': 'active',
    };
  }

  static Future register(String name, String email, String password)async{
    // Map body = {
    //   'name': email.split('@')[0],
    //   'email': '$email@gmail.com',
    //   'gender': 'male',
    //   'status': 'active',
    // };
    // return await _handler.post('/register', body);

    // dummy delay
    await Future.delayed(const Duration(seconds: 2));

    // dummy login data
    return {
      'id': 1,
      'token': email,
      'name': email,
      'email': '$email@gmail.com',
      'gender': 'male',
      'status': 'active',
    };
  }

}