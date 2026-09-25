import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand Primary & Accents
  static const primary = Color(0xFF244C45);
  static const primaryLight = Color(0xFF346B61);
  static const primaryDark = Color(0xFF16322D);
  static const accent = Color(0xFF00A884);
  static const accentLight = Color(0xFFE8F5F2);

  // Surfaces & Backgrounds
  static const surface = Color(0xFFF8FAF9);
  static const surfaceElevated = Colors.white;
  static const surfaceSubtle = Color(0xFFF0F4F2);
  static const surfaceMuted = Color(0xFFE5ECE9);

  // Inks & Neutrals
  static const ink = Color(0xFF182822);
  static const inkSecondary = Color(0xFF354840);
  static const muted = Color(0xFF52645C);
  static const outline = Color(0xFF71847A);
  static const outlineLight = Color(0xFFD6DFDB);

  // Functional Status
  static const error = Color(0xFFB3261E);
  static const errorLight = Color(0xFFFDE8E8);
  static const warning = Color(0xFFB45309);
  static const warningLight = Color(0xFFFEF3C7);
  static const success = Color(0xFF15803D);
  static const successLight = Color(0xFFDCFCE7);
  static const info = Color(0xFF1D4ED8);
  static const infoLight = Color(0xFFDBEAFE);

  // Demo Indicator Banner
  static const demoBadgeBg = Color(0xFFFEF08A);
  static const demoBadgeText = Color(0xFF854D0E);
}

abstract final class AppTypography {
  static const title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.ink,
  );
  static const heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
    color: AppColors.ink,
  );
  static const subheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.3,
    color: AppColors.ink,
  );
  static const body = TextStyle(
    fontSize: 15,
    height: 1.5,
    color: AppColors.ink,
  );
  static const bodyMedium = TextStyle(
    fontSize: 14,
    height: 1.4,
    color: AppColors.ink,
  );
  static const caption = TextStyle(
    fontSize: 12,
    height: 1.4,
    color: AppColors.muted,
  );
  static const label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );
}

abstract final class AppSpacing {
  static const double xs = 4, sm = 8, md = 16, lg = 24, xl = 32, xxl = 48;
}

abstract final class AppRadius {
  static const double sm = 8, control = 12, card = 16, lg = 24, full = 999;
}

abstract final class AppElevation {
  static const double flat = 0, raised = 1, floating = 4;
}

abstract final class AppMotion {
  static const quick = Duration(milliseconds: 150);
  static const standard = Duration(milliseconds: 250);
  static const emphasize = Duration(milliseconds: 350);
}

ThemeData buildAppTheme() => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.accentLight,
    onPrimaryContainer: AppColors.primaryDark,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
    surfaceContainerHighest: AppColors.surfaceMuted,
    error: AppColors.error,
    outline: AppColors.outlineLight,
  ),
  scaffoldBackgroundColor: AppColors.surface,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.ink,
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: false,
    titleTextStyle: AppTypography.heading,
  ),
  cardTheme: CardThemeData(
    color: AppColors.surfaceElevated,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.card),
      side: const BorderSide(color: AppColors.outlineLight, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),
  textTheme: const TextTheme(
    headlineLarge: AppTypography.title,
    titleLarge: AppTypography.heading,
    titleMedium: AppTypography.subheading,
    bodyLarge: AppTypography.body,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.caption,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
      borderSide: const BorderSide(color: AppColors.outlineLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
      borderSide: const BorderSide(color: AppColors.outlineLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      minimumSize: const Size(48, 48),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.control),
      ),
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(48, 48),
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.outlineLight, width: 1.5),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.control),
      ),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white,
    indicatorColor: AppColors.accentLight,
    surfaceTintColor: Colors.transparent,
    elevation: 3,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        );
      }
      return const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.muted,
      );
    }),
  ),
  materialTapTargetSize: MaterialTapTargetSize.padded,
);
