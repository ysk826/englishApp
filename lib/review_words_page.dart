import 'package:flutter/material.dart';
import 'card_word.dart';

// 単語の復習ページ
class ReviewWordsPage extends StatefulWidget {
  final List<CardWord> allWordsCopy;

  ReviewWordsPage({required this.allWordsCopy});

  @override
  _ReviewWordsPageState createState() => _ReviewWordsPageState();
}

class _ReviewWordsPageState extends State<ReviewWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Words'),
      ),
      body: ListView.builder(
        itemCount: widget.allWordsCopy.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.allWordsCopy[index].word),
            subtitle: Text(widget.allWordsCopy[index].meaning),
          );
        },
      ),
    );
  }
}
