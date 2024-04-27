import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: "Enter text",
        border: OutlineInputBorder(),
      ),
    );
  }
}