import 'package:english_app/words_page.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'flashcard.dart';
import 'text_field.dart';
import 'register_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Add a word'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // タイトルを表示
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
      body: Padding(
        // 上部にスペースを追加
        padding: const EdgeInsets.only(top: 20.0),
        // 背景色をグレーに設定
        child: Container(
          color: Colors.grey,
          // 中央に配置
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // テキストフィールドを呼び出す
              WordTextField(controller: controller),
              const SizedBox(
                height: 20,
              ),
              // 登録ボタンを呼び出す
              RegisterButton(
                label: "登録",
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              // 単語リストへの遷移ボタンを呼び出す
              ElevatedButton(
                child: const Text('Words List'),
                onPressed: () {
                  Navigator.push(
                    context,
                    // 単語リスト画面へ遷移
                    MaterialPageRoute(builder: (context) => const WordsPage()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Flashcard'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Flashcard()),
                  );
                },)
            ],
          ),
        ),
      ),
    );
  }
}
