import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Colors.deepPurple;
  static const primaryColorDark = Colors.deepPurpleAccent;
  static const accentColor = Colors.white;
  static final appBarColor = Colors.deepPurple.shade600;
}

class AppTextStyle {
  static const headline1 = TextStyle(
    color: Colors.red,
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );
  static const headline2 = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w300,
  );
  static const buttonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

class AppInputDecoration {
  static InputDecoration getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
