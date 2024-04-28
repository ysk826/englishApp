import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;
  static const _databaseName = "my_database.db";

  Future<Database> get database async {
    // databaseがnullでない場合は、databaseを返す
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // データベースを初期化する
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // データベースを作成する
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE words(id INTEGER PRIMARY KEY, word TEXT)",
    );
  }

  // データベースに単語を追加する
  Future<void> insertWord(String word) async {
    final db = await database;
    await db.insert(
      "words",
      {"word": word},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // データベースから単語を取得する
  Future<List<Map<String, dynamic>>> getWords() async {
    final db = await database;
    var result = await db.query('words');
    return List<Map<String, dynamic>>.from(result);
  }
}
