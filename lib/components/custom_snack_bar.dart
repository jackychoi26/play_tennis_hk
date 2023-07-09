import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';

class CustomSnackBar {
  const CustomSnackBar({required this.type, required this.message});

  final SnackBarType type;
  final String? message;

  Color _backgroundColor() {
    switch (type) {
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.yellow;
    }
  }

  Color _textColor() {
    switch (type) {
      case SnackBarType.error:
      case SnackBarType.warning:
        return Colors.white;
    }
  }

  void display(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          message,
          style: TextStyle(
            color: _textColor(),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: _backgroundColor(),
      ),
    );
  }
}

enum SnackBarType { warning, error }
