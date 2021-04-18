import 'package:path/path.dart' as pathImport;
import 'package:projetocompleto2/models/user.dart';
import 'package:sqflite/sqflite.dart' as sql;

abstract class DbUtil {
  static sql.Database _db;

  static final nameDb = 'data.db';
  static final tableUser = 'user';
  static bool isLoggedUser = false;

  static Future<void> initDb() async {
    final path = await sql.getDatabasesPath();

    _db = await sql.openDatabase(
      pathImport.join(path, nameDb),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE $tableUser (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name VARCHAR(60), password VARCHAR(60), isDarkTheme INTEGER)');
      },
      version: 1,
    );
  }

  static Future<void> saveData(Map<String, dynamic> data) async {
    await _db.insert(
      tableUser,
      data,
    );
  }

  static Future<void> updateData(Map<String, dynamic> data) async {
    var res = await _db.update(
      tableUser,
      data,
      where: 'id = ${data["id"]}'
    );

    print(res);
  }

  static Future<User> getData() async {
    final users = await _db.query(
      tableUser,
    );

    if (users == null || users.isEmpty) {
      return null;
    }

    var data = {
      ...users.first,
      'isDarkTheme': users.first["isDarkTheme"] == 1 ? true : false,
    };

    print(data);

    final user = User.fromMap(data);

    isLoggedUser = true;
    return user;
  }

  static Future<void> clearData() async {
    await _db.delete(tableUser);
  }
}