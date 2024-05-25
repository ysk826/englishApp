import 'package:flutter/material.dart';

class WordTextField extends StatelessWidget {
  final TextEditingController controller;

  WordTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: "Enter text",
        border: OutlineInputBorder(),
      ),
    );
  }
}