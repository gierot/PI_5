import 'package:flutter/material.dart';

class MessageSnackBar {
  final String message;
  final int type;

  MessageSnackBar(this.message, this.type);

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: type == 1 ? Colors.red : const Color(0xFF31B425),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          width: 300, 
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
