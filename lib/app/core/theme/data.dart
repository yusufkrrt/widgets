import 'package:ogrenme/app/core/core.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstants.primary,
        ),
        scaffoldBackgroundColor: ColorConstants.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      );
}
