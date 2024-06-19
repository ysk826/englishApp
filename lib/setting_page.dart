import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<int> flashcardCounts = [10, 20, 30, 40, 50];
  int selectedCount = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: DropdownButton<int>(
          value: selectedCount,
          items: flashcardCounts.map((int count) {
            return DropdownMenuItem<int>(
              value: count,
              child: Text('$count'),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              selectedCount = newValue!;
            });
          },
        ),
      ),
    );
  }
}