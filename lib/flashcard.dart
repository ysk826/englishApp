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
  late String currentWord;

  @override
  void initState() {
    super.initState();
    setupWords();
  }

  void setupWords() async {
    allWords = (await _databaseHelper.getCardWords()).cast<String>();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            currentWord,
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            child: Text('Remembered'),
            onPressed: nextWord,
          ),
          ElevatedButton(
            child: Text('Not Remembered'),
            onPressed: nextWord,
          ),
        ],
      ),
    );
  }
}