import 'package:gamez_taskop/src/model/user.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

// This Api provides the ability to interact with the user table, ie, 'users'
class UserApiProvider {

  Future<int> createUser(User user) async {
    final db = await DBProvider.db.database;
    int id = await db.insert("users", User.mapFromUser(user));
    return id;
  }

  Future<bool> checkIfUserPresent(User user) async {
    final db = await DBProvider.db.database;
    List<Map<String, dynamic>> map = await db.query(
      'users',
      where: 'user_name = ?',
      whereArgs: [user.userName]
    );

    if (map.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUser(String userName) async {
    final db = await DBProvider.db.database;
    List<Map<String, dynamic>> map = await db.query(
      'users',
      where: 'user_name = ?',
      whereArgs: [userName],
    );
    return User.userFromMap(map[0]);
  }

  Future<bool> isFirstTime() async {
    final db = await DBProvider.db.database;
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM users'));
    if (count > 0) {
      return true;
    } else {
      return false;
    }
  }

}

final userApiProvider = UserApiProvider();