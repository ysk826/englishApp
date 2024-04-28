import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;

  MyTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Enter text",
        border: OutlineInputBorder(),
      ),
    );
  }
}