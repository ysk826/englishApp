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
    await db.execute('''
      CREATE TABLE words (
        id INTEGER PRIMARY KEY, 
        word TEXT, 
        meaning TEXT
      )
    ''');
  }

  // データベースに単語と意味を追加する
  Future<void> insertWord(String word, String meaning) async {
    print('insertWord called with word: $word and meaning: $meaning'); // Debug statement
    final db = await database;
    await db.insert(
      "words",
      {"word": word, "meaning": meaning},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // データベースから単語を取得する
  Future<List<Map<String, dynamic>>> getWords() async {
    final db = await database;
    var result = await db.query('words');
    return List<Map<String, dynamic>>.from(result);
  }

  // データベースから単語を削除する
  Future<void> deleteWord(int id) async {
    final db = await database;
    await db.delete(
      'words',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateWord(int id, String newText) async {
    // Open the database
    final db = await openDatabase('my_database.db');

    // Update the word's meaning
    await db.update(
      'words',
      {'meaning': newText},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
