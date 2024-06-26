import 'package:flutter/material.dart';
import 'card_word.dart';
import 'flashcard.dart';
import 'main.dart';

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
        // 戻るボタンを非表示
        automaticallyImplyLeading: false,
        title: const Text('Review Words'),
      ),
      // スクロール可能なウィジェット
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //color: Colors.grey[200], // 背景色をグレーに設定 後で消す
              height: 500,
              child: ListView.builder(
                // ListViewの範囲はスクロールができる
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.allWordsCopy.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(widget.allWordsCopy[index].word),
                        subtitle: Text(widget.allWordsCopy[index].meaning),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: const Divider(color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
            ),
            // try againボタン
            ElevatedButton(
              child: const Text('try again'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Flashcard(),
                    // 遷移時のアニメーションの時間
                    transitionDuration: const Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            //
            const SizedBox(height: 10),
            // endボタン
            // フェードアウトのアニメーションを適用
            ElevatedButton(
              child: const Text('end'),
              onPressed: () {
                // pushAndRemoveUntilで全てのページを削除してMyHomePageに遷移
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MyHomePage(),
                    transitionDuration: const Duration(milliseconds: 200),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
