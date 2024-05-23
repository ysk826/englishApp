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
      return CupertinoButton(
        child: Text(label),
        color: CupertinoColors.activeBlue,
        // ボタンが押された時の処理
        onPressed: () {
          // テキストフィールドから入力された文字列を取得
          String word = controller.text.trim();
          // 入力された文字列が空でない場合
          if (word.isNotEmpty) {
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
                      TextField(controller: meaningController),
                      // 保存ボタン
                      ElevatedButton(
                        child: const Text('Save'),
                        // 保存ボタンが押された時の処理
                        onPressed: () {
                          // 意味を取得
                          String meaning = meaningController.text.trim();
                          // 意味が空でない場合
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
