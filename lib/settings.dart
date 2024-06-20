import 'package:shared_preferences/shared_preferences.dart';

// 設定を管理するクラス
class Settings {
  // 選択されたフラッシュカードの数を保存するキー
  static const String _selectedCountKey = 'selectedCount';

  // 選択されたフラッシュカードの数を取得
  static Future<int> getSelectedCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_selectedCountKey) ?? 10; // Default value is 10
  }

  // 選択されたフラッシュカードの数を保存
  static Future<void> setSelectedCount(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_selectedCountKey, value);
  }
}