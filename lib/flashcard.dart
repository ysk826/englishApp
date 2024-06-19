import 'package:english_app/card_word.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'review_words_page.dart';

// フラッシュカードのページ
class Flashcard extends StatefulWidget {
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard>
    with SingleTickerProviderStateMixin {
  final _databaseHelper = DatabaseHelper();

  // フラッシュカードとそのコピー
  late List<CardWord> allWords;
  late List<CardWord> allWordsCopy;

  // currentWord、currentMeaningの初期化が必要
  late String currentWord = "";
  late String currentMeaning = "";

  // 意味の表示を切り替えるためのフラグ
  bool showMeaning = false;

  // AnimationControllerとAnimationを追加
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // AnimationControllerを初期化
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // Tweenを使用してアニメーションの範囲を定義
    // アニメーションの値の始めは0.0、最後は1.0、動的に変化
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    setupWords();
  }

  @override
  void dispose() {
    // AnimationControllerを破棄
    _controller.dispose();
    super.dispose();
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
    // アニメーションをリセットして開始
    _controller.reset();
    _controller.forward();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Learning'),
      ),
      // フラッシュカードの表示
      body: Container(
        // 幅を画面いっぱいに広げる
        width: double.infinity,
        color: Colors.grey[400], // 背景色をグレーに設定 後で消す
        child: Column(
          // 中央に配置
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Transformを使用してアニメーションをContainerに適用
            Transform(
              alignment: Alignment.center,
              // 3Dアニメーションを適用
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                // Y軸を中心に回転
                ..rotateY(3.14 * (showMeaning ? _animation.value : 0.0)),
              // フラッシュカードの枠をContainerで作成
              child: Container(
                // 幅を画面の80%に設定、高さを画面の50%に設定
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                // テキストと枠の間に8pxのpaddingを設定
                padding: const EdgeInsets.all(8.0),
                // 枠の装飾
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // Widgetを同じ場所に置くためにStackで重ねる
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // 表面のテキスト(単語のみ)
                    Visibility(
                      // visibleプロパティで表示を制御
                      // showMeaningがfalse、またはアニメーションの値が0.5未満のときに表示
                      visible: !showMeaning || _animation.value < 0.5,
                      // Transformを使用してアニメーションをTextに適用
                      child: Column(
                        // 中央に配置
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // 単語を表示
                          Text(
                            currentWord,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    // 裏面のテキスト
                    // 単語と意味を表示
                    Visibility(
                      visible: showMeaning && _animation.value >= 0.5,
                      // Textの反転を防ぐためにTransformを使用
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateY(showMeaning ? 3.14 : 0.0),
                        child: Column(
                          // 意味を表示するかどうかを制御
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              currentWord,
                              style: const TextStyle(fontSize: 24),
                            ),
                            Text(
                              currentMeaning,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                        _controller.forward(from: 0.0);
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
                        _controller.forward(from: 0.0);
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
