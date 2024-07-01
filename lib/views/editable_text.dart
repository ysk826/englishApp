import 'package:flutter/material.dart';

// 編集可能なテキストフィールドを作成するウィジェット
class MyEditableText extends StatefulWidget {
  // コンストラクタ
  final String initialText;
  final Function(String) onSubmitted;
  final TextEditingController controller;

  MyEditableText(
      {required this.initialText,
      required this.onSubmitted,
      required this.controller});

  @override
  _MyEditableTextState createState() => _MyEditableTextState();
}

class _MyEditableTextState extends State<MyEditableText> {

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // テキストが複数行になるように設定
      maxLines: null,
      style: const TextStyle(fontSize: 18),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
