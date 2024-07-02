import 'package:flutter/material.dart';

// 単語を入力するテキストフィールドクラス
class WordTextField extends StatelessWidget {
  final TextEditingController controller;

  WordTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    // 画面幅の5%をpaddingValueに代入
    double paddingValue = MediaQuery.of(context).size.width * 0.05;
    // paddingでtextFieldの周りにスペースを追加して
    return Padding(
      // 左右にpaddingValueのスペースを追加
      padding: EdgeInsets.symmetric(horizontal: paddingValue),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "word",
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          // 角丸のborderを設定
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
