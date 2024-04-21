import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  RegisterButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
          child: Text(label),
          color: CupertinoColors.activeBlue,
          onPressed: onPressed);
    } else {
      return ElevatedButton(
        child: Text(label),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        onPressed: onPressed,
      );
    }
  }
}
