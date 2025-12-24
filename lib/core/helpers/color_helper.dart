import 'package:flutter/material.dart';

abstract class AppColorHelper {
  // static const Color primary = Color(0xFFB44343);
  static Color primary({bool isMale = true, bool isStart = false}) {
    if (isStart) {
      return const Color(0xFFF58B1B);
    }
    return isMale ? primaryMale : primaryFemale;
  }

  static const Color primaryMale = Color(0xFF2196F3); // Blue for male
  static const Color primaryFemale = Color(0xFFE91E63); // Pink for female
  // static const Color lightPrimary = Color(0xFFF7AE00);
  // static const Color white = Colors.white;
  static const Color white = Color(0xffffffff);
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Color(0xFFE01515);
  static const Color green = Color(0xFF1E910C);
  static const Color blue = Color(0xFF276CF3);
  static const Color contentBackground = Color(0xffF3BC83);
}
