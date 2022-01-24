import 'dart:convert';

import 'package:myflutter_cubit/config/aes_encryption.dart';
import 'package:myflutter_cubit/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  MyDatabase._init();
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      password TEXT NOT NULL,
      email TEXT NOT NULL,
      gender TEXT NOT NULL
      )
      ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('cubit.db');
    return _database!;
  }

  Future closeDb() async {
    final db = await instance.database;

    db.close();
  }

  Future login(String email, String password) async {
    final db = await instance.database;

    List maps = await db.query('users',
        columns: ['id', 'name', 'email', 'gender'],
        where: 'email = ? AND password = ?',
        whereArgs: [email, password]);

    if (maps.isNotEmpty) {
      var data = Map.of(maps.first);

      var token = stringEncryptAES(data: jsonEncode(data));
      data['token'] = token;

      return data;
    } else {
      throw 'User Not Found';
    }
  }

  Future register(UserModel userModel, String password) async {
    final db = await instance.database;
    var data = userModel.toJson();
    data['password'] = password;
    List maps = await db.query('users',
        columns: ['id', 'name', 'email', 'gender'],
        where: 'email = ? ',
        whereArgs: [userModel.email]);

    if (maps.isNotEmpty) {
      throw 'Email sudah terdaftar';
    } else {
      final id = await db.insert('users', data,
          conflictAlgorithm: ConflictAlgorithm.replace);

      if (id == 0) {
        throw 'Failed to insert user';
      }
      return userModel.copyWith(id: id).toJson();
    }
  }
}
