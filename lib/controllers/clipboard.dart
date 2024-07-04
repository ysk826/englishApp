import 'package:flutter/services.dart';

// クリップボードを操作するクラス
class ClipboardController {
  // クリップボードからテキストを取得
  // テキストがない場合は空文字を返す
  Future<String> getClipboardData() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    return clipboardData?.text ?? '';
  }

  // クリップボードにテキストを設定　消すかもしれない
  Future<void> setClipboardData(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
