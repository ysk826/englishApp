import 'package:flutter/material.dart';

class WordTextField extends StatelessWidget {
  final TextEditingController controller;

  WordTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 左右に20ピクセルのスペースを追加
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration:  InputDecoration(
          hintText: "word",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // 角を丸くする
          ),
        ),
      ),
    );
  }
}
