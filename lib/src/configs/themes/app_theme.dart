import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFED1B24);
  static const Color primaryDark = Color(0xFFC01018);
  static const Color primaryLight = Color(0xFFFDEDEE);
  static const Color secondary = Color(0xFF78909C);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF263238);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color error = Color(0xFFBF360C);
  static const Color success = Color(0xFF2E7D32);
  static const Color cardShadow = Color(0x1A000000);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, primary: primary, secondary: secondary, surface: surface, error: error),
    scaffoldBackgroundColor: background,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
      iconTheme: const IconThemeData(color: textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error),
      ),
      labelStyle: GoogleFonts.poppins(color: textSecondary),
      hintStyle: GoogleFonts.poppins(color: textSecondary, fontSize: 14),
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: cardShadow,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: textSecondary,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary.withValues(alpha: 0.25),
      selectionHandleColor: primary,
    ),
  );
}
