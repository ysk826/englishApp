import 'package:flutter/material.dart';
import 'card_word.dart';
import 'flashcard.dart';

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
        title: const Text('Review Words'),
      ),
      // スクロール可能なウィジェット
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 500,
              child: ListView.builder(
                // ListViewの範囲はスクロールができる
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.allWordsCopy.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.allWordsCopy[index].word),
                    subtitle: Text(widget.allWordsCopy[index].meaning),
                  );
                },
              ),
            ),
            ElevatedButton(
              child: const Text('try again'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Flashcard()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('end'),
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ],
        ),
      ),
    );
  }
}
