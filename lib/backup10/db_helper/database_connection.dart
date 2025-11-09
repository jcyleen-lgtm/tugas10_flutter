import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationCacheDirectory();
    var path = join(directory.path, 'database_crud');
    var database =
    await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE user (id INTERGER PRIMARY KEY AUTOINCREMENT, "
        "nameTEXT NOT NULL, telepon TEXT, deskripsi TEXT);";
    await database.execute(sql);
  }
}