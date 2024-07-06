import 'package:shared_preferences/shared_preferences.dart';

// 設定を管理するクラス
class Settings {
  // 設定されたフラッシュカードの枚数を保存するキー
  static const String _selectedCountKey = "selectedCount";

  // クリップボードの貼り付け機能のon/offを保存するキー
  static const String _clipboardPasteKey = "clipboardPaste";

  // 設定されたフラッシュカードの数を取得
  // デフォルト値は10
  static Future<int> getSelectedCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_selectedCountKey) ?? 10;
  }

  // 設定されたフラッシュカードの数を保存
  static Future<void> setSelectedCount(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_selectedCountKey, value);
  }

  // クリップボードの貼り付け機能のon/offを取得
  // デフォルト値はtrue
  static Future<bool> getClipboardPaste() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_clipboardPasteKey) ?? true;
  }

 // クリップボードの貼り付け機能のon/offを保存
  static Future<void> setClipboardPaste(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_clipboardPasteKey, value);
  }
}
