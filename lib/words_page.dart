import 'package:flutter/material.dart';
import 'data.dart';
import 'editable_text.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({Key? key}) : super(key: key);

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  final _databaseHelper = DatabaseHelper();
  final _controller = TextEditingController();

  // 削除のロジックを含むメソッド
  Future<void> deleteWord(int id) async {
    await _databaseHelper.deleteWord(id);
    // UIを更新する
    setState(() {});
  }

  @override
  void dispose() {
    // コントローラーを破棄
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Words'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _databaseHelper.getWords(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    // 単語と意味を表示するリストタイル
                    ListTile(
                      // 縦配置
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![index]['word'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(snapshot.data![index]['meaning'].toString()),
                        ],
                      ),
                      // onTapプロパティ
                      onTap: () {
                        // モーダルを表示する関数
                        showModalBottomSheet(
                          context: context,
                          // 画面全体を覆おうように設定
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              // 画面全体(94%)を覆う高さに設定
                              height: MediaQuery.of(context).size.height * 0.94,
                              // 背景色を白に設定 後で消す
                              color: Colors.white,
                              child: Padding(
                                // 左右に8pxのpadding
                                padding: const EdgeInsets.all(8.0),
                                // Alignウィジェットは、その子ウィジェットの位置を制御
                                child: Align(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // 単語と意味を表示
                                      Container(
                                        // 背景色をグレーに設定 後で消す
                                        color: Colors.grey[300],
                                        width: double.infinity,
                                        child: Column(
                                          // 左端に配置
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // 単語を表示
                                            Text(
                                              snapshot.data![index]["word"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            // 高さ10pxのスペース
                                            const SizedBox(height: 10),
                                            // 意味を表示
                                            Column(
                                              // 左端に配置
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // "Meaning"というテキストを表示
                                                const Text(
                                                  'Meaning',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                // 意味の部分をタッチすれば編集できるようにする
                                                MyEditableText(
                                                  initialText: snapshot
                                                      .data![index]['meaning']
                                                      .toString(),
                                                  onSubmitted: (newText) {
                                                    // updateWordメソッドを呼び出す
                                                    _databaseHelper.updateWord(
                                                      snapshot.data![index]
                                                          ['id'],
                                                      newText,
                                                    );
                                                    // UIを更新する
                                                    setState(() {});
                                                  },
                                                  controller: _controller,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 高さ10pxのスペース
                                      const SizedBox(height: 40),
                                      // 色を付けるためのContainer 後で消す
                                      Container(
                                        color: Colors.grey[400],
                                        child: Align(
                                          alignment: Alignment.center,
                                          // ボタンを横に並べる
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // 削除ボタン
                                              ElevatedButton(
                                                child: const Text('Delete'),
                                                onPressed: () async {
                                                  // deleteWordメソッドを呼び出す
                                                  await deleteWord(snapshot
                                                      .data![index]['id']);
                                                  // モーダルを閉じる
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              // 閉じるボタン
                                              ElevatedButton(
                                                child: const Text('Close'),
                                                onPressed: () {
                                                  // updateWordメソッドを呼び出す
                                                  _databaseHelper.updateWord(
                                                    snapshot.data![index]['id'],
                                                    _controller.text,
                                                  );
                                                  // UIを更新する
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
