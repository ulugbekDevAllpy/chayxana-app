import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const cream = Color(0xFFF5EDDD);
  static const creamSoft = Color(0xFFFAF6EE);
  static const card = Color(0xFFFFFDFB);
  static const primary = Color(0xFF1E5F3E);
  static const primaryDark = Color(0xFF164A30);
  static const accent = Color(0xFFE0942E);
  static const accentSoft = Color(0xFFF6DCB4);
  static const textPrimary = Color(0xFF171717);
  static const textSecondary = Color(0xFF6F6F6F);
  static const divider = Color(0xFFEDE7DA);

  static const borderStrong = Color(0x33171717);
  static const borderSoft = Color(0x1A171717);
}

class AppTextStyles {
  static TextStyle displayLarge() => GoogleFonts.ptSerif(
        fontSize: 34,
        height: 34 / 34,
        letterSpacing: -0.34,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final textTheme = GoogleFonts.manropeTextTheme(base.textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.creamSoft,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.card,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.creamSoft,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
    );
  }
}
