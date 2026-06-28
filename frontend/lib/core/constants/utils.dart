import 'package:flutter/material.dart';

// Color strengthenColor(Color color, double factor) {
//   int r = (Color.red * factor).clamp(0, 255).toInt();
//   int g = (Color.green * factor).clamp(0, 255).toInt();
//   int b = (Color.blue * factor).clamp(0, 255).toInt();

//   return Color.fromARGB(color.alpha, r, g, b);
// }

List<DateTime> generateWeekDates(int weekOffSet) {
  final today = DateTime.now();
  DateTime startOffWeek = today.subtract(Duration(days: today.weekday - 1));
  startOffWeek = startOffWeek.add(Duration(days: weekOffSet * 7));

  return List.generate(7, (index) => startOffWeek.add(Duration(days: index)));
}

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToRgb(String hex){
  return Color(int.parse(hex,radix:16)+0xFF000000);
}