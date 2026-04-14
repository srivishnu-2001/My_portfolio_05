import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BRAND COLORS
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const Color teal        = Color(0xFF00BCD4);
  static const Color tealDark    = Color(0xFF00838F);
  static const Color cyan        = Color(0xFF00E5FF);
  static const Color violet      = Color(0xFF7C4DFF);
  static const Color violetLight = Color(0xFFB39DDB);

  // Dark surfaces
  static const Color darkBg      = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard    = Color(0xFF1E1E1E);
  static const Color darkCard2   = Color(0xFF252525);
  static const Color darkBorder  = Color(0xFF2D2D2D);

  // Light surfaces
  static const Color lightBg     = Color(0xFFF0F4F8);
  static const Color lightCard   = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Text – dark mode
  static const Color textOnDark       = Color(0xFFE0E0E0);
  static const Color textMutedOnDark  = Color(0xFF9E9E9E);

  // Text – light mode
  static const Color textOnLight      = Color(0xFF1A202C);
  static const Color textMutedOnLight = Color(0xFF4A5568);

  // Gradients
  static const LinearGradient primary = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFF00838F)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient heroDark = LinearGradient(
    colors: [Color(0xFF0A1628), Color(0xFF121212), Color(0xFF0D1B2A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroLight = LinearGradient(
    colors: [Color(0xFFE0F7FA), Color(0xFFF0F4F8), Color(0xFFEDE7F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// TEXT STYLES  (all use GoogleFonts so they work on web too)
// ─────────────────────────────────────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  static TextStyle heroName(bool dark) => GoogleFonts.poppins(
        fontSize: 50,
        fontWeight: FontWeight.w800,
        color: dark ? Colors.white : AppColors.textOnLight,
        letterSpacing: -1.5,
        height: 1.1,
      );

  static TextStyle heroTitle(bool dark) => GoogleFonts.poppins(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: AppColors.teal,
        letterSpacing: 1.5,
      );

  static TextStyle heroBio(bool dark) => GoogleFonts.roboto(
        fontSize: 15,
        height: 1.75,
        color: dark ? AppColors.textMutedOnDark : AppColors.textMutedOnLight,
      );

  static TextStyle sectionTitle(bool dark) => GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: dark ? Colors.white : AppColors.textOnLight,
        letterSpacing: -0.5,
      );

  static TextStyle cardTitle(bool dark) => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: dark ? Colors.white : AppColors.textOnLight,
      );

  static TextStyle body(bool dark) => GoogleFonts.roboto(
        fontSize: 14,
        height: 1.7,
        color: dark ? AppColors.textOnDark : AppColors.textMutedOnLight,
      );

  static TextStyle label(bool dark) => GoogleFonts.roboto(
        fontSize: 12,
        color: dark ? AppColors.textMutedOnDark : AppColors.textMutedOnLight,
      );

  static TextStyle navLink(bool dark) => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: dark ? AppColors.textOnDark : AppColors.textOnLight,
        letterSpacing: 0.5,
      );
}
