import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFFF2B3A);
  static const Color primaryLight = Color(0xFFFF7C88);
  static const Color background = Color(0xFFFFFFFF);
  static const Color bgGrey = Color(0xFFF7F7F7);
  static const Color darkCard = Color(0xFF3C2C2D);
  static const Color textDark = Color(0xFF302B2B);
  static const Color textGrey = Color(0xFF8F8A8A);
  static const Color textLight = Color(0xFFC9C4C4);
  static const Color rating = Color(0xFFFF9A1F);
  static const Color cardBorder = Color(0xFFF0ECEC);
  static const Color chatBubbleAgent = Color(0xFFF3F1F4);
  static const Color success = Color(0xFF28C76F);

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFFFF7E8A), Color(0xFFFF2B3A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTextStyles {
  static TextStyle logo = GoogleFonts.greatVibes(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle heading3 = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
    height: 1.6,
  );

  static TextStyle bodyDark = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static TextStyle label = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textGrey,
  );

  static TextStyle price = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );
}

class AppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textDark),
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      );
}
