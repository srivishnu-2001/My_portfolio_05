import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'constants.dart';
import 'home.dart';
//implemented on tap functionalities about contacts on 15-04-2026

void main() {
  VisibilityDetectorController.instance.updateInterval = Duration.zero;
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Srivishnu Thiriveedhi – Flutter Developer',
      themeMode: _themeMode,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      home: PortfolioHome(onToggleTheme: _toggleTheme, themeMode: _themeMode),
    );
  }

  ThemeData _lightTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBg,
      cardColor: AppColors.lightCard,
      primaryColor: AppColors.teal,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.teal,
        secondary: AppColors.violet,
        surface: AppColors.lightCard,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      dividerColor: AppColors.lightBorder,
    );
  }

  ThemeData _darkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBg,
      cardColor: AppColors.darkCard,
      primaryColor: AppColors.teal,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.teal,
        secondary: AppColors.violet,
        surface: AppColors.darkCard,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      dividerColor: AppColors.darkBorder,
    );
  }
}
