import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  // Tailwind-inspired colors
  static const Color primaryColor = Color(0xFFE4D5D5);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color accentBrown = Color(0xFF8B5E3C);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      surface: backgroundLight,
      onSurface: gray900,
      surfaceContainerHighest: gray100,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundLight,
      elevation: 0,
      iconTheme: IconThemeData(color: gray800),
      titleTextStyle: TextStyle(
        color: gray900,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: gray100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: gray900,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      surface: backgroundDark,
      onSurface: gray100,
      surfaceContainerHighest: gray800,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundDark,
      elevation: 0,
      iconTheme: IconThemeData(color: gray200),
      titleTextStyle: TextStyle(
        color: gray100,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: gray800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  // Shadcn UI 主题配置
  static ShadThemeData lightShadTheme = ShadThemeData(
    brightness: Brightness.light,
    colorScheme: ShadColorScheme.fromName(
      'zinc',
      brightness: Brightness.light,
    ).copyWith(
      background: backgroundLight,
      card: cardLight,
      primary: primaryColor,
      border: gray200,
      ring: gray300,
      custom: {
        'accentBrown': accentBrown,
      },
    ),
    radius: 12.0,
  );

  static ShadThemeData darkShadTheme = ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: ShadColorScheme.fromName(
      'zinc',
      brightness: Brightness.dark,
    ).copyWith(
      background: backgroundDark,
      card: cardDark,
      primary: primaryColor,
      border: gray800,
      ring: gray700,
      custom: {
        'accentBrown': accentBrown,
      },
    ),
    radius: 12.0,
  );
}
