import 'package:flutter/material.dart';

class GlobalSnackBar {
  final String message;

  const GlobalSnackBar({required this.message});

  static showSuccess(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.green);
  }

  static showError(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.red);
  }

  static show(BuildContext context, String message, {Color? backgroundColor}) {
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Din',
            ),
          ),
          backgroundColor: backgroundColor,
        ),
      );
    }
  }
}
