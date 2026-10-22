import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const navy = Color(0xFF1D3557);
  static const gold = Color(0xFFD4AF37);
  static const green = Color(0xFF10B981);
  static const cream = Color(0xFFFAFAFA);
  static const white = Color(0xFFFFFFFF);
  static const charcoal = Color(0xFF1A1A1A);
  static const slate = Color(0xFF64748B);
}

class AppFonts {
  static TextStyle heading({
    double size = 28,
    Color color = AppColors.charcoal,
    FontWeight weight = FontWeight.w700,
    double? height,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  static TextStyle body({
    double size = 15,
    Color color = AppColors.charcoal,
    FontWeight weight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  static TextStyle caption({
    Color color = AppColors.slate,
    FontWeight weight = FontWeight.w500,
  }) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: weight,
        color: color,
      );
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.navy,
          primary: AppColors.navy,
          secondary: AppColors.gold,
          surface: AppColors.white,
        ),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      );
}