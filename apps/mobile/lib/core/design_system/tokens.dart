import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand Identity Tokens (New Premium Palette)
  static const deepNavy = Color(0xFF14253D);
  static const ggsGreen = Color(0xFF00A884);
  static const softOffWhite = Color(0xFFF5F7FA);
  static const warmAmber = Color(0xFFFFB86B);
  static const charcoal = Color(0xFF242B35);
  static const white = Color(0xFFFFFFFF);

  // Semantic Design Tokens
  static const primary = deepNavy; // Deep Navy for primary headers, hero sections, dominant brand anchors
  static const primaryLight = Color(0xFF1F3556);
  static const primaryDark = Color(0xFF0D1828);
  static const accent =
      ggsGreen; // GGs Green for active CTAs, success, highlights
  static const accentLight = Color(0xFFE6F7F3);
  static const highlight =
      warmAmber; // Warm Amber for badges, ratings, highlights

  // Surfaces & Backgrounds
  static const surface = softOffWhite;
  static const surfaceElevated = white;
  static const surfaceSubtle = Color(0xFFEAEFF5);
  static const surfaceMuted = Color(0xFFDFE6EE);
  static const surfaceDark = deepNavy;

  // Inks & Neutrals
  static const ink = charcoal;
  static const inkSecondary = Color(0xFF4A5565);
  static const muted = Color(0xFF5A6878);
  static const outline = Color(0xFF9AA7B7);
  static const outlineLight = Color(0xFFE2E7ED);

  // Functional Status
  static const error = Color(0xFFD32F2F);
  static const errorLight = Color(0xFFFDE8E8);
  static const warning = Color(0xFFD97706);
  static const warningLight = Color(0xFFFEF3C7);
  static const success = Color(0xFF059669);
  static const successLight = Color(0xFFD1FAE5);
  static const info = Color(0xFF0284C7);
  static const infoLight = Color(0xFFE0F2FE);

  // Demo Indicator Banner
  static const demoBadgeBg = Color(0xFFFEF08A);
  static const demoBadgeText = Color(0xFF854D0E);
}

/// Curated royalty-free, high-quality portrait and campaign photography for GGs
abstract final class AppImages {
  // Creator Portraits (Unsplash high-resolution license-free creator portraits)
  static const creatorAisha =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80';
  static const creatorRiya =
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80';
  static const creatorRohan =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80';
  static const creatorAditya =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80';
  static const creatorNeha =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80';
  static const creatorVikram =
      'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=400&q=80';
  static const creatorSneha =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80';
  static const creatorKabir =
      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80';
  static const creatorTanvi =
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=80';

  // Campaign Covers & Lifestyle Banners
  static const campaignGlow =
      'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=800&q=80';
  static const campaignTech =
      'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=800&q=80';
  static const campaignFitness =
      'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=800&q=80';
  static const campaignFood =
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80';
  static const campaignFashion =
      'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=800&q=80';

  // Brand / Agency Identity
  static const brandNova =
      'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&w=400&q=80';
  static const agencyPulse =
      'https://images.unsplash.com/photo-1557804506-669a67965ba0?auto=format&fit=crop&w=400&q=80';

  /// Resolves a deterministic creator photo by name or index
  static String? getCreatorPhoto(String idOrName) {
    final lower = idOrName.toLowerCase();
    if (lower.contains('aisha')) return creatorAisha;
    if (lower.contains('riya')) return creatorRiya;
    if (lower.contains('rohan')) return creatorRohan;
    if (lower.contains('aditya')) return creatorAditya;
    if (lower.contains('neha')) return creatorNeha;
    if (lower.contains('vikram')) return creatorVikram;
    if (lower.contains('sneha')) return creatorSneha;
    if (lower.contains('kabir')) return creatorKabir;
    if (lower.contains('tanvi')) return creatorTanvi;

    // Fallback deterministic selection for CSV-imported creators
    final hash = idOrName.codeUnits.fold(0, (a, b) => a + b);
    final pool = [
      creatorAisha,
      creatorRiya,
      creatorRohan,
      creatorAditya,
      creatorNeha,
      creatorVikram,
      creatorSneha,
      creatorKabir,
      creatorTanvi,
    ];
    return pool[hash % pool.length];
  }

  /// Resolves an authentic campaign cover image
  static String getCampaignCover(String titleOrCategory) {
    final lower = titleOrCategory.toLowerCase();
    if (lower.contains('beauty') ||
        lower.contains('serum') ||
        lower.contains('glow')) {
      return campaignGlow;
    }
    if (lower.contains('tech') ||
        lower.contains('gadget') ||
        lower.contains('phone')) {
      return campaignTech;
    }
    if (lower.contains('fit') ||
        lower.contains('active') ||
        lower.contains('wellness')) {
      return campaignFitness;
    }
    if (lower.contains('food') ||
        lower.contains('culinary') ||
        lower.contains('meal')) {
      return campaignFood;
    }
    return campaignFashion;
  }
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
    seedColor: AppColors.deepNavy,
    brightness: Brightness.light,
    primary: AppColors.deepNavy,
    onPrimary: Colors.white,
    secondary: AppColors.ggsGreen,
    onSecondary: Colors.white,
    primaryContainer: AppColors.surfaceSubtle,
    onPrimaryContainer: AppColors.deepNavy,
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
    iconTheme: IconThemeData(color: AppColors.deepNavy, size: 24),
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
      borderSide: const BorderSide(color: AppColors.deepNavy, width: 2),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.ggsGreen, // Prominent active CTA color
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
      foregroundColor: AppColors.deepNavy,
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
          color: AppColors.deepNavy,
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
