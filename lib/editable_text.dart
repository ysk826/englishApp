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
  // 編集モードかどうかを判定するフラグ
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialText;
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
          ? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextFormField(
                controller: widget.controller,
                // テキストフィールドのスタイルを設定
                style: const TextStyle(
                  fontSize: 18,
                  height: 5,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  // テキストフィールドの境界線を設定
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
          : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text(
                widget.initialText,
                style: const TextStyle(
                  fontSize: 18,
                  height: 5,
                ),
              ),
            ),
    );
  }
}
