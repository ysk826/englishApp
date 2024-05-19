import 'package:flutter/material.dart';

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
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    widget.controller.text =
        widget.initialText; // 変更: _controllerをwidget.controllerに変更
  }

  @override
  Widget build(BuildContext context) {
    // タッチイベントを検知するためのウィジェット
    return GestureDetector(
      onTap: () {
        // タップされたら編集モードにする
        setState(() {
          _isEditing = true;
        });
      },
      child: _isEditing
          ? TextFormField(
              controller:
                  widget.controller, // 変更: _controllerをwidget.controllerに変更
              // テキストフィールドのスタイルを設定
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            )
          : Text(widget.initialText, style: const TextStyle(fontSize: 18)),
    );
  }
}
