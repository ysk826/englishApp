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
            showModalBottomSheet(
              // 画面全体を覆おうように設定
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                final meaningController = TextEditingController();
                return Container(
                  height: MediaQuery.of(context).size.height * 0.94,
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
                          // text field clear
                          controller.clear();
                          // モーダルを閉じる
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          });
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

