import 'package:flutter/material.dart';

/// Application costume theme.
class AppTheme {
  /// Default border radius value for cards and fields.
  static const double borderRadiusValue = 8;

  /// Default border radius for widgets.
  static final BorderRadius borderRadius =
      BorderRadius.circular(borderRadiusValue);

  /// Standard grey color for borders and hints.
  static const Color greyColor = Colors.grey;

  /// Slightly darker grey for icons in fields.
  static final Color greyDarkColor = Colors.grey[600]!;

  /// Standard white color.
  static const Color whiteColor = Colors.white;

  /// Semi-transparent black for scanner barrier or backgrounds.
  static const Color scanBarrierColor = Colors.black12;

  /// Light grey for grab handles and dividers.
  static final Color greyLightColor = Colors.grey[300]!;

  /// Standard decoration for input-like containers.
  static final BoxDecoration fieldDecoration = BoxDecoration(
    border: Border.all(color: greyColor),
    borderRadius: borderRadius,
  );

  /// Decoration for the grab handle in bottom sheets.
  static final BoxDecoration grabHandleDecoration = BoxDecoration(
    color: greyLightColor,
    borderRadius: BorderRadius.circular(2),
  );

  /// Standard decoration for cards with subtle shadow.
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

  /// Returns the light theme data for the application.
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      hintColor: greyColor,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: greyColor),
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
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12, color: greyColor),
      ),
    );
  }
}
