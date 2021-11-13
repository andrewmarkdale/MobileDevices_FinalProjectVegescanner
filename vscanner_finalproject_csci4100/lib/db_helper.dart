import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*

Andrew Mark Dale
CSCI4100U
Mobile Development
Lab 5/6
SQFLITE Grades


Basic DBHelper based on the example given in class

*/
class DBHelper {
  DBHelper._privateConstructor();
  static DBHelper dbHelper = DBHelper._privateConstructor();

  late Database _database;

  Future<Database> get database async {
    _database = await _createDatabase();
    return _database;
  }

  Future<Database> _createDatabase() async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), 'mydb.db'),
            onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE Products(id INTEGER PRIMARY KEY, sid TEXT, grade TEXT)");
    }, version: 1);
    return database;
  }

  Future<List<Map<String, dynamic>>> getAllGrades() async {
    Database db = await database;
    return await db.query("Products");
  }

  Future<int> insertGrade(Map<String, dynamic> row) async {
    Database db = await database;
    return db.insert("Products", row);
  }

  Future<int> updateGrade(Map<String, dynamic> row) async {
    Database db = await database;
    return db.update("Products", row, where: "sid=?", whereArgs: [row['sid']]);
  }

  Future<int> deleteGrade(String sid) async {
    Database db = await database;
    return await db.delete("Products", where: "sid=?", whereArgs: [sid]);
  }
}
