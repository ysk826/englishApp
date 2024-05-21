import 'package:english_app/words_page.dart';
import 'package:flutter/material.dart';
import 'data.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _databaseHelper = DatabaseHelper();

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        // ここで上部にスペースを追加
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          color: Colors.grey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(controller: controller),
              const SizedBox(
                height: 20,
              ),
              RegisterButton(
                label: "登録",
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Words List'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WordsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
