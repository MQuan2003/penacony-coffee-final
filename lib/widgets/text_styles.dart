import 'package:flutter/material.dart';

class TextStyles {
  // Kiểu chữ lớn
  static TextStyle headline({Color color = Colors.black, double fontSize = 24}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  // Kiểu chữ phụ
  static TextStyle subtitle({Color color = Colors.grey, double fontSize = 16}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
    );
  }

  // Kiểu chữ nhỏ
  static TextStyle caption({Color color = Colors.black54, double fontSize = 14}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
    );
  }
}
