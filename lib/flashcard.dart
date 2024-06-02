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
  late List<String> allWords;

  // currentWordの初期化が必要
  late String currentWord = "";

  @override
  void initState() {
    super.initState();
    setupWords();
  }

  void setupWords() async {
    List<CardWord> cardWords = await _databaseHelper.getCardWords();
    // 単語を文字列に変換してリストに格納
    allWords = cardWords.map((cardWord) => cardWord.word).toList();
    allWords.shuffle();
    currentWord = allWords.removeLast();
    setState(() {});
  }

  void nextWord() {
    if (allWords.isNotEmpty) {
      currentWord = allWords.removeLast();
    } else {
      currentWord = "No more words";
    }
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
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              child: Text('◯'),
              onPressed: nextWord,
            ),
            ElevatedButton(
              child: Text('×'),
              onPressed: nextWord,
            ),
          ],
        ),
      ),
    );
  }
}
