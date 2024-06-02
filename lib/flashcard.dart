import 'package:english_app/card_word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class Flashcard extends StatefulWidget {
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  final _databaseHelper = DatabaseHelper();
  late List<CardWord> allWords;

  // currentWord、currentMeaningの初期化が必要
  late String currentWord = "";
  late String currentMeaning = "";

  // 意味の表示を切り替えるためのフラグ
  bool showMeaning = false;

  @override
  void initState() {
    super.initState();
    setupWords();
  }

  void setupWords() async {
    // データベースから全ての単語を取得
    allWords = await _databaseHelper.getCardWords();
    allWords.shuffle();
    // 単語を文字列に変換してリストに格納
    var lastCardWord = allWords.removeLast();
    // 単語と意味を取得
    currentWord = lastCardWord.word;
    currentMeaning = lastCardWord.meaning;
    setState(() {});
  }

  void nextWord() {
    if (allWords.isNotEmpty) {
      var lastCardWord = allWords.removeLast();
      currentWord = lastCardWord.word;
      currentMeaning = lastCardWord.meaning;
    } else {
      currentWord = "No more words";
      currentMeaning = "";
    }
    // 次の単語を表示する時は意味を隠す
    showMeaning = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Learning'),
      ),
      body: Container(
        // 幅を画面いっぱいに広げる
        width: double.infinity,
        color: Colors.grey[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentWord,
              style: const TextStyle(fontSize: 24),
            ),
            // 意味を表示するかどうかを制御
            if (showMeaning)
              Text(
                currentMeaning,
                style: const TextStyle(fontSize: 20),
              ),

            if (!showMeaning) // 意味が表示されていないときだけ◯ボタンと×ボタンを表示
              ...[
              ElevatedButton(
                child: const Text('◯'),
                onPressed: () {
                  setState(() {
                    showMeaning = true; // 意味を表示
                  });
                },
              ),
              ElevatedButton(
                child: const Text('×'),
                onPressed: () {
                  setState(() {
                    showMeaning = true; // 意味を表示
                  });
                },
              ),
            ],
            if (showMeaning) // 次の単語へのボタンを表示するかどうかを制御
              ElevatedButton(
                child: const Text('Next'),
                onPressed: nextWord,
              ),
          ],
        ),
      ),
    );
  }
}
