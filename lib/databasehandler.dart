//buat library functions utk membantu kita menggunakan Sqlite dalam app kita
import 'package:bomba_sqlite/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehandler {
  //kena create beberapa functions asas
  //1. function utk Initialise database
  Future<Database> initialiseDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'mydatabase.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTEGER,country TEXT, email TEXT)",
        );
      },
      version: 1,
    );
  }

  //2. Function utk populate data awalan (banyak data) sekiranya perlu
  Future<int> insertUsers(List<User> users) async {
    int result = 0;
    final Database db = await initialiseDB();
    //loop the list of users to create multiple users
    for (var user in users) {
      result = await db.insert('users', user.toMap());
    }
    return result; //return int berapa data dah insert
  }

  //3. Function utk create 1 data
  Future<int> insertUser(User user) async {
    int result = 0;
    final Database db = await initialiseDB();
    result = await db.insert('users', user.toMap());
    return result; //return int berapa data dah insert. Ini 1 aja
  }

  //4. Function to retrieve data (capai data)
  Future<List<User>> retrieveUsers() async {
    final Database db = await initialiseDB();
    List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  //5. Function utk update data
  Future<void> updateUser(User user) async {
    final Database db = await initialiseDB();
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  //6. function utk delete data
  Future<void> deleteUser(int id) async {
    final Database db = await initialiseDB();
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
