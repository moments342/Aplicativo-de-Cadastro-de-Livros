import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    const corPrimaria = Color(0xFF5E60CE);
    const corSecundaria = Color(0xFF80FFDB);

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: corPrimaria,
        primary: corPrimaria,
        secondary: corSecundaria,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: corPrimaria,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: corPrimaria,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.w500),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      useMaterial3: true,
    );
  }
}
