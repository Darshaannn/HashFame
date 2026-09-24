import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF244C45);
  static const surface = Color(0xFFF8FAF9);
  static const ink = Color(0xFF182822);
  static const muted = Color(0xFF52645C);
  static const error = Color(0xFFB3261E);
  static const outline = Color(0xFF71847A);
}

abstract final class AppTypography {
  static const title = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  static const heading = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static const body = TextStyle(fontSize: 16, height: 1.5);
}

abstract final class AppSpacing {
  static const double xs = 4, sm = 8, md = 16, lg = 24, xl = 32;
}

abstract final class AppRadius {
  static const double control = 12, card = 20;
}

abstract final class AppElevation {
  static const double flat = 0, raised = 2;
}

abstract final class AppMotion {
  static const quick = Duration(milliseconds: 150);
  static const standard = Duration(milliseconds: 250);
}

ThemeData buildAppTheme() => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
    error: AppColors.error,
  ),
  scaffoldBackgroundColor: AppColors.surface,
  textTheme: const TextTheme(
    headlineLarge: AppTypography.title,
    titleLarge: AppTypography.heading,
    bodyLarge: AppTypography.body,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(48, 48),
      padding: const EdgeInsets.all(AppSpacing.md),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(minimumSize: const Size(48, 48)),
  ),
  materialTapTargetSize: MaterialTapTargetSize.padded,
);
