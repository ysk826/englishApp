import 'package:english_app/card_word.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'review_words_page.dart';

// フラッシュカードのページ
class Flashcard extends StatefulWidget {
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  final _databaseHelper = DatabaseHelper();

  // フラッシュカードとそのコピー
  late List<CardWord> allWords;
  late List<CardWord> allWordsCopy;

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

  // 最初に実行されるメソッド
  void setupWords() async {
    // データベースから全ての単語を取得、コピーを作成、シャッフル
    allWords = await _databaseHelper.getCardWords();
    allWordsCopy = List.from(allWords);
    allWords.shuffle();
    // allWordsの最後の要素を取得して削除
    CardWord lastCardWord = allWords.removeLast();
    // 単語と意味を取得
    currentWord = lastCardWord.word;
    currentMeaning = lastCardWord.meaning;
    setState(() {});
  }

  // 次の単語を表示するメソッド
  void nextWord() {
    // リストに単語が残っている場合
    if (allWords.isNotEmpty) {
      CardWord lastCardWord = allWords.removeLast();
      currentWord = lastCardWord.word;
      currentMeaning = lastCardWord.meaning;
      // リストに単語が残っていない場合
    } else {
      // フラッシュカードを引数に持って、復習ページに遷移
      Navigator.push(
        // 現在のビルドコンテキスト
        context,
        // 遷移先のページ
        MaterialPageRoute(
            builder: (context) => ReviewWordsPage(allWordsCopy: allWordsCopy)),
      );
    }
    // 次の単語を表示する時は意味を隠す
    showMeaning = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Learning'),
      ),
      body: Container(
        // 幅を画面いっぱいに広げる
        width: double.infinity,
        color: Colors.grey[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // フラッシュカードの枠
            Container(
              // 幅を画面の80%に設定、高さを画面の50%に設定
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(8.0), // テキストと枠との間にスペースを追加
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // 枠線の色を設定
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  // 単語を表示
                  Text(
                    currentWord,
                    style: const TextStyle(fontSize: 24),
                  ),
                  // 意味を表示するかどうかを制御
                  if (showMeaning)
                    // 意味を表示
                    Text(
                      currentMeaning,
                      style: const TextStyle(fontSize: 20),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // ◯ボタンと×ボタンを横並びに配置
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 中央に配置
              children: <Widget>[
                // ◯ボタン
                Visibility(
                  // showMeaningがfalseのときだけ◯ボタンを表示
                  visible: !showMeaning,
                  child: ElevatedButton(
                    child: const Text('◯'),
                    onPressed: () {
                      setState(() {
                        showMeaning = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                // ×ボタン
                Visibility(
                  // showMeaningがfalseのときだけ×ボタンを表示
                  visible: !showMeaning,
                  child: ElevatedButton(
                    child: const Text('×'),
                    onPressed: () {
                      setState(() {
                        showMeaning = true;
                      });
                    },
                  ),
                ),
              ],
            ),
            // Nextボタン
            Visibility(
              // showMeaningがtrueのときだけボタンを表示
              visible: showMeaning,
              child: ElevatedButton(
                child: const Text('Next'),
                onPressed: nextWord,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
