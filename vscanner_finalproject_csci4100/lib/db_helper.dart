import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*

Andrew Mark Dale
CSCI4100U
Mobile Development

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
          "CREATE TABLE Products(id INTEGER PRIMARY KEY, name TEXT, barcode TEXT, "
          "vegan TEXT, vegetarian TEXT, imgb64 TEXT, notes TEXT)");
    }, version: 1);
    return database;
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    Database db = await database;
    return await db.query("Products");
  }

  Future<int> insertProduct(Map<String, dynamic> row) async {
    Database db = await database;
    return db.insert("Products", row);
  }

  Future<int> updateProduct(Map<String, dynamic> row) async {
    Database db = await database;
    return db.update("Products", row, where: "barcode=?", whereArgs: [row['barcode']]);
  }

  Future<int> deleteProduct(String barcode) async {
    Database db = await database;
    return await db.delete("Products", where: "barcode=?", whereArgs: [barcode]);
  }
}
