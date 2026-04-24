import 'package:flutter/material.dart';

class AppTheme {
  static const double borderRadiusValue = 8;
  static final BorderRadius borderRadius = BorderRadius.circular(borderRadiusValue);

  static final BoxDecoration fieldDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: borderRadius,
  );

  static final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
