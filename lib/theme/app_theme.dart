import 'package:flutter/material.dart';

/// Palet warna "arena" — gelap dan kontras tinggi, terinspirasi papan skor
/// pertandingan sungguhan (bukan palet Material default).
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF090C14);
  static const Color backgroundAlt = Color(0xFF10162A);
  static const Color surface = Color(0xFF141B2E);
  static const Color surfaceLine = Color(0xFF232B45);

  // Warna pemain 1: merah energik.
  static const Color playerOne = Color(0xFFFF3B5C);
  static const Color playerOneDim = Color(0xFF3A1420);

  // Warna pemain 2: cyan elektrik — kontras hangat vs dingin.
  static const Color playerTwo = Color(0xFF00D2FF);
  static const Color playerTwoDim = Color(0xFF0A2C38);

  static const Color gold = Color(0xFFFFC53D);
  static const Color textPrimary = Color(0xFFF5F7FA);
  static const Color textMuted = Color(0xFF8A93A6);
  static const Color win = Color(0xFF3DFFA0);
}

class AppTheme {
  AppTheme._();

  static ThemeData get darkArena {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.gold,
        secondary: AppColors.playerTwo,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: base.textTheme
          .apply(
            fontFamily: 'BebasNeue',
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          )
          .copyWith(
            displayLarge: const TextStyle(
              fontFamily: 'Orbitron',
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.gold,
        selectionColor: AppColors.gold,
        selectionHandleColor: AppColors.gold,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.surfaceLine),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.surfaceLine),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.gold, width: 2),
        ),
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
          fontFamily: 'BebasNeue',
          fontSize: 18,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

/// Style angka skor besar (Orbitron) dipakai di beberapa tempat.
TextStyle scoreDigitStyle({required double size, required Color color}) {
  return TextStyle(
    fontFamily: 'Orbitron',
    fontWeight: FontWeight.w900,
    fontSize: size,
    color: color,
    height: 1.0,
  );
}

/// Style label kapital bergaya "papan nama" (Bebas Neue).
TextStyle arenaLabelStyle({
  required double size,
  required Color color,
  double letterSpacing = 3,
}) {
  return TextStyle(
    fontFamily: 'BebasNeue',
    fontSize: size,
    color: color,
    letterSpacing: letterSpacing,
  );
}
