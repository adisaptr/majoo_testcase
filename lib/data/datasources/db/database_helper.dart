import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/users_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblUsers = 'users';

  Future<Database> _initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final databasePath = documentDirectory.path + '/auth.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblUsers (
        id INTEGER PRIMARY KEY,
        username TEXT,
        email TEXT,
        password TEXT
      );
    ''');
  }

  Future<int> insertUsers(UsersModel users) async {
    final db = await database;
    return await db!.insert(_tblUsers, users.toJson());
  }

  Future<String?> getLogin(String user, String password) async {
    final db = await database;
    var res = await db!.rawQuery(
        "SELECT * FROM $_tblUsers WHERE email = '$user' and password = '$password'");

    if (res.isNotEmpty) {
      return res.first.toString();
    }

    return null;
  }
}
