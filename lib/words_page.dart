import 'package:flutter/material.dart';
import 'data.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({Key? key}) : super(key: key);

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  final _databaseHelper = DatabaseHelper();

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
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(snapshot.data![index]['word'].toString()),
                      Text(snapshot.data![index]['meaning'].toString()),
                    ],
                  ),
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