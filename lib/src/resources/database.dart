import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "NewDatabase.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {

      await db.execute("CREATE TABLE users ("
          "user_id INTEGER PRIMARY KEY,"
          "user_name TEXT,"
          "user_image_path TEXT,"
          "is_logged_in BIT"
          ")");

      await db.execute("CREATE TABLE tasks ("
          "task_id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "is_completed BIT,"
          "image_path TEXT,"
          "created_date TEXT,"
          "due_date TEXT,"
          "finished_date TEXT"
          ")");
    });
  }
}
