import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class RegisterButton extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  // コンストラクタ
  RegisterButton({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    final _databaseHelper = DatabaseHelper();

    if (Platform.isIOS) {
      // 登録ボタン
      // 文字の空文字チェック、単語の重複チェック
      // 登録済みであればポップアップを表示、登録されていなければモーダルを表示
      return CupertinoButton(
        child: Text(label),
        color: CupertinoColors.activeBlue,
        // ボタンが押された時の処理
        onPressed: () async {
          // テキストフィールドから入力された文字列を取得
          String word = controller.text.trim();
          // 入力された文字列が空でない場合、モーダルを表示
          if (word.isNotEmpty) {
            // 単語がすでに登録されてれば、ポップアップを表示
            // 単語が登録されていなければ、意味を登録するモーダルを表示
            if (await _databaseHelper.wordExists(word)) {
              // 単語がすでに存在する場合はポップアップを表示
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Icon(Icons.error),
                    content: const Text('The word is already registered.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        // ポップアップを閉じる
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              // 単語が存在しない場合はモーダルを表示
              showModalBottomSheet(
                // 画面全体を覆おうように設定
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  // 意味を入力するテキストフィールド
                  final meaningController = TextEditingController();
                  // モーダルの中身
                  return Container(
                    // 画面全体(94%)を覆う高さに設定
                    height: MediaQuery.of(context).size.height * 0.94,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Enter the meaning'),
                        // 意味を入力するテキストフィールド
                        TextField(
                          controller: meaningController,
                          // テキストが複数行になるように設定
                          maxLines: null,
                        ),
                        // 20pxのスペースを追加
                        const SizedBox(height: 20.0),
                        // 保存ボタン
                        ElevatedButton(
                          child: const Text('Save'),
                          // 保存ボタンが押された時の処理
                          onPressed: () {
                            // 意味を取得
                            String meaning = meaningController.text.trim();
                            // 意味が空でない場合、データベースに登録
                            if (meaning.isNotEmpty) {
                              _databaseHelper.insertWord(word, meaning);
                              // text field clear
                              controller.clear();
                              // モーダルを閉じる
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      );
    } else {
      return ElevatedButton(
        child: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              final meaningController = TextEditingController();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Enter the meaning'),
                    TextField(controller: meaningController),
                    ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        String word = controller.text;
                        String meaning = meaningController.text;
                        _databaseHelper.insertWord(word, meaning);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }
}
