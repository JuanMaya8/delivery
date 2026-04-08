import 'package:flutter/material.dart';

class FoodAppTheme {
  static const primaryColor = Color(0xFFFF4B3A);
  static const backgroundColor = Color(0xFFF2F2F2);
  static const greyText = Color(0xFF9A9A9D);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'SFPro', // O la fuente que uses en Figma
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 17, color: Colors.black),
      ),
    );
  }
}