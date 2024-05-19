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

  // 削除のロジックを含むメソッド
  Future<void> deleteWord(int id) async {
    await _databaseHelper.deleteWord(id);
    // UIを更新する
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Words'),
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
                              // 画面全体を覆う高さに設定
                              height: MediaQuery.of(context).size.height,
                              // 背景色を白に設定 後で消す
                              color: Colors.white,
                              child: Padding(
                                // 左右に8pxのpadding
                                padding: const EdgeInsets.all(8.0),
                                // Alignウィジェットは、その子ウィジェットの位置を制御
                                child: Align(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 単語と意味を表示
                                      Container(
                                        // 背景色をグレーに設定 後で消す
                                        color: Colors.grey[300],
                                        width: double.infinity,
                                        child: Column(
                                          // 左端に配置
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // 単語を表示
                                              snapshot.data![index]["word"].toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(height: 10),
                                            // 意味を表示
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Meaning',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                MyEditableText(
                                                  initialText: '${snapshot.data![index]['meaning'].toString()}'
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 削除ボタン
                                      ElevatedButton(
                                        child: Text('Delete'),
                                        onPressed: () async {
                                          // deleteWordメソッドを呼び出す
                                          await deleteWord(
                                              snapshot.data![index]['id']);
                                          // モーダルを閉じる
                                          Navigator.pop(context);
                                        },
                                      ),
                                      // 閉じるボタン
                                      ElevatedButton(
                                        child: Text('Close'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
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
                    Divider(),
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
