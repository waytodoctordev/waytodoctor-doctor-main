import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class AppThemeData {
  ThemeData get materialTheme {
    return ThemeData(
      fontFamily: GoogleFonts.tajawal().fontFamily,
      scaffoldBackgroundColor: MyColors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: MyColors.primary,
        primary: MyColors.primary,
        secondary: MyColors.secondary,
      ),
      textTheme: const TextTheme(
        // bodyMedium: TextStyle(color: MyColors.blue14B),
        // titleLarge: TextStyle(color: MyColors.blue14B),
        headlineSmall: TextStyle(color: MyColors.blue14B, fontSize: 14),
        headlineMedium: TextStyle(color: MyColors.blue14B, fontSize: 16),
        headlineLarge: TextStyle(color: MyColors.blue14B, fontSize: 20),
      ),
      appBarTheme: AppBarTheme(
        color: MyColors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 80,
        titleTextStyle: GoogleFonts.tajawal(
          fontSize: 18,
          color: MyColors.blue14B,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.ideographic,
        ),
      ),
    );
  }
}
