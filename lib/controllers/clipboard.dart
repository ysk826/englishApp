import 'package:flutter/services.dart';

class ClipboardController {
  // クリップボードからテキストを取得
  Future<String> getClipboardData() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    return clipboardData?.text ?? '';
  }

  // クリップボードにテキストを設定
  Future<void> setClipboardData(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}