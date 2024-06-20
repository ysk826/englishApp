import 'package:flutter/material.dart';

import 'settings.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<int> flashcardCounts = [10, 20, 30, 40, 50];
  int selectedCount = 10;

  @override
  void initState() {
    super.initState();
    _loadSelectedCount();
  }

  Future<void> _loadSelectedCount() async {
    selectedCount = await Settings.getSelectedCount();
    setState(() {});
  }

  Future<void> _incrementCount() async {
    if (selectedCount < 50) {
      selectedCount += 1;
      await Settings.setSelectedCount(selectedCount);
      setState(() {});
    }
  }

  Future<void> _decrementCount() async {
    if (selectedCount > 1) {
      selectedCount -= 1;
      await Settings.setSelectedCount(selectedCount);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      // 画面全体をContainerで囲む
      body: Container(
          // 幅を画面の80%に設定、マージンを左右に10%ずつ設定
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          color: Colors.grey[400], // 背景色をグレーに設定 後で消す
          // Columnで縦に並べる
          child: Column(
            // 中央に配置
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // テキストを左寄せに配置
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Number of flashcards'),
                ),
              ),
              // Containerで枠を作成
              Container(
                // 幅を画面の80%に設定、高さを画面の50%に設定
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                // テキストと枠の間に8pxのpaddingを設定
                padding: const EdgeInsets.all(8.0),
                // 枠の装飾
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Text('$selectedCount'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementCount
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _incrementCount
                    ),
                  ],
                )
              ),
            ],
          )),
    );
  }
}
