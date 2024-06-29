import 'dart:io';
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'card_word.dart';
import 'settings.dart';

// データベースを管理するクラス
class DatabaseHelper {
  static Database? _database;
  static const _databaseName = "my_database.db";

  // databaseのgetterメソッド
  // singletonパターンを使用して、データベースを初期化する
  Future<Database> get database async {
    // databaseがnullでない場合は、databaseを返す
    if (_database != null) {
      return _database!;
    }
    // databaseがnullの場合は、初期化する
    _database = await _initDatabase();
    return _database!;
  }

  // データベースを作成する
  Future<Database> _initDatabase() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // データベースを作成する
  // table名はwords、カラムはid, word, meaning
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
    final db = await database;
    await db.insert(
      "words",
      {"word": word, "meaning": meaning},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // データベースから単語を取得する
  // 単語と意味をMapでコピーして返す
  Future<List<Map<String, dynamic>>> getWords() async {
    final db = await database;
    List<Map<String, Object?>> result = await db.query('words');
    return List<Map<String, dynamic>>.from(result);
  }

  // データベースから単語を削除する
  // idを使用して削除
  Future<void> deleteWord(int id) async {
    final db = await database;
    await db.delete(
      'words',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // データベースの単語を更新する
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

  // データベースからフラッシュカードの単語を取得し、シャッフルする
  Future<List<CardWord>> getCardWords() async {
    final db = await database;
    // データベースから全ての単語をコピー
    final List<Map<String, dynamic>> maps = List<Map<String, dynamic>>.from(await db.query('words'));

    // リストをシャッフル
    maps.shuffle();

    // SettingsからselectedCountを取得
    int selectedCount = await Settings.getSelectedCount();

    // selectedCountがmaps.lengthを超えないようにする
    selectedCount = min(maps.length, selectedCount);

    return List.generate( selectedCount, (i) {
      return CardWord(
        id: maps[i]['id'],
        word: maps[i]['word'],
        meaning: maps[i]['meaning'],
      );
    });

  }

  // データベースから単語が存在するか確認する
  Future<bool> wordExists(String word) async {
    var dbClient = await database;
    var result = await dbClient.rawQuery('SELECT word FROM words WHERE word = ?', [word]);
    return result.isNotEmpty;
  }
}
