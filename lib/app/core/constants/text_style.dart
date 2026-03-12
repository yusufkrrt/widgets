import 'package:flutter/material.dart';

abstract class TextStyleConstants {
  TextStyleConstants._();

  static const TextStyle defaultStyle = TextStyle(
    color: Color(0xFF1A1A2E),
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1A1A2E),
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1A1A2E),
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF6B7280),
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF6B7280),
  );
}
