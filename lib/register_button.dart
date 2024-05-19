import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class RegisterButton extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  RegisterButton({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    final _databaseHelper = DatabaseHelper();

    if (Platform.isIOS) {
      return CupertinoButton(
          child: Text(label),
          color: CupertinoColors.activeBlue,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                final meaningController = TextEditingController();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Enter the meaning'),
                      TextField(controller: meaningController),
                      ElevatedButton(
                        child: Text('Save'),
                        onPressed: () {
                          print('Save button pressed'); // Debug statement
                          String word = controller.text;
                          String meaning = meaningController.text;
                          _databaseHelper.insertWord(word, meaning);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          });
    } else {
      return ElevatedButton(
        child: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              final meaningController = TextEditingController();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Enter the meaning'),
                    TextField(controller: meaningController),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        String word = controller.text;
                        String meaning = meaningController.text;
                        _databaseHelper.insertWord(word, meaning);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }
}

