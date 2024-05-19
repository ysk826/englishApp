import 'package:flutter/material.dart';

class MyEditableText extends StatefulWidget {
  final String initialText;

  MyEditableText({required this.initialText});

  @override
  _MyEditableTextState createState() => _MyEditableTextState();
}

class _MyEditableTextState extends State<MyEditableText> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
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
              controller: _controller,
              // テキストフィールドのスタイルを設定
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  _isEditing = false;
                });
              },
            )
          : Text(widget.initialText, style: const TextStyle(fontSize: 18)),
    );
  }
}
