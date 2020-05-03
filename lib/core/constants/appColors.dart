import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor ui_kit_color = Colors.grey;
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey700 = Color(0xFF616161);

  static Color fromHex(var colors) {
    var hexString = '#${colors.value.toRadixString(16)}';
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}