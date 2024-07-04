import 'package:english_app/views/words_page.dart';
import 'package:flutter/material.dart';
import '../controllers/clipboard.dart';
import 'flashcard_page.dart';
import 'setting_page.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// WidgetsBindingObserverを継承してアプリのライフサイクルを監視
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final controller = TextEditingController();
  final clipboardController = ClipboardController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    // アプリを初めて起動した時にクリップボードのデータを取得
    initClipboardData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // アプリが再開された時にクリップボードのデータを取得
    if (state == AppLifecycleState.resumed) {
      initClipboardData();
    }
  }

  // クリップボードのデータを取得
  Future<void> initClipboardData() async {
    String clipboardData = await clipboardController.getClipboardData();
    controller.text = clipboardData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // タイトルを表示
        title: const Text(
          "Add a word",
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        actions: <Widget>[
          // 設定ボタン
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 設定画面へ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        // 上部にスペースを追加
        padding: const EdgeInsets.only(top: 20.0),
        // 背景色をグレー200に設定
        child: Container(
          color: Colors.grey[200],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
