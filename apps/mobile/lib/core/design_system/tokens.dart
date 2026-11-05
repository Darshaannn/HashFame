import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand Colors (Strict Brand Palette)
  static const burgundy = Color(0xFF8B0000); // Primary Burgundy
  static const deepBurgundy = Color(0xFF680000); // Deep Burgundy for gradients
  static const black = Color(0xFF111111); // Pure Dark Black
  static const white = Color(0xFFFFFFFF); // Clean Surfaces
  static const lightGray = Color(0xFFF5F3F3); // Soft Light Gray Canvas
  static const secondaryGray = Color(0xFF666666); // Muted Secondary Text
  static const borderGray = Color(0xFFE6E1DE); // Subtle Borders

  // Semantic Design Tokens
  static const primary = burgundy; // Burgundy for primary actions and highlights
  static const primaryLight = Color(0xFFA52A2A);
  static const primaryDark = deepBurgundy;
  static const accent = burgundy; // Burgundy for active CTAs & focus
  static const accentLight = Color(0xFFF9EBEB);
  static const highlight = Color(0xFF2A2A2A);

  // Surfaces & Backgrounds
  static const surface = white;
  static const surfaceElevated = white;
  static const surfaceSubtle = lightGray;
  static const surfaceMuted = Color(0xFFE2E2E2);
  static const surfaceDark = black;

  // Inks & Neutrals
  static const ink = black;
  static const inkSecondary = Color(0xFF333333);
  static const muted = secondaryGray;
  static const outline = Color(0xFFCCCCCC);
  static const outlineLight = Color(0xFFE5E5E5);

  // Functional Status
  static const error = Color(0xFFD32F2F);
  static const errorLight = Color(0xFFFDE8E8);
  static const warning = Color(0xFFD97706);
  static const warningLight = Color(0xFFFEF3C7);
  static const success = Color(0xFF059669);
  static const successLight = Color(0xFFD1FAE5);
  static const info = Color(0xFF0284C7);
  static const infoLight = Color(0xFFE0F2FE);

  // Demo Indicator (Neutral Minimalist Styling)
  static const demoBadgeBg = Color(0xFF222222);
  static const demoBadgeText = Color(0xFFEEEEEE);
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

  /// Resolves a creator photo only for seeded demo creators or explicit photo URLs.
  /// Directory creators return null by default so a polished initials placeholder is shown,
  /// strictly adhering to the rule: "Do not assign unrelated stock photos to real creator names."
  static String? getCreatorPhoto(String idOrName) {
    final lower = idOrName.toLowerCase();
    // Only map the synthetic demo personas who have authorized Unsplash portrait avatars
    if (lower == 'aisha mehta' || lower == 'demo_creator_user_id') return creatorAisha;
    if (lower == 'riya kapoor' || lower == 'creator_riya_kapoor') return creatorRiya;
    if (lower == 'rohan sharma' || lower == 'creator_rohan_fitness') return creatorRohan;
    if (lower == 'aditya kulkarni' || lower == 'creator_aditya_food') return creatorAditya;
    if (lower == 'neha sharma' || lower == 'creator_neha_travel') return creatorNeha;
    if (lower == 'vikram joshi' || lower == 'creator_vikram_finance') return creatorVikram;
    if (lower == 'sneha reddy' || lower == 'creator_sneha_fashion') return creatorSneha;
    if (lower == 'kabir singhania' || lower == 'creator_kabir_gaming') return creatorKabir;
    if (lower == 'tanvi deshmukh' || lower == 'creator_tanvi_beauty') return creatorTanvi;

    // Real imported spreadsheet creators must show polished initials avatar until real photos arrive
    return null;
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
  // Font Families
  static const String khandFont = 'Khand';
  static const String hindFont = 'Hind';

  // Khand Headlines & Large Display
  static const heroHeadline = TextStyle(
    fontFamily: khandFont,
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.05,
    color: AppColors.white,
  );
  static const sectionHeading = TextStyle(
    fontFamily: khandFont,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    height: 1.15,
    color: AppColors.ink,
  );
  static const studioTitle = TextStyle(
    fontFamily: khandFont,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.1,
    color: AppColors.ink,
  );

  // Hind Body, Controls, & Typography
  static const title = TextStyle(
    fontFamily: khandFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.ink,
  );
  static const heading = TextStyle(
    fontFamily: hindFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
    color: AppColors.ink,
  );
  static const subheading = TextStyle(
    fontFamily: hindFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.3,
    color: AppColors.ink,
  );
  static const body = TextStyle(
    fontFamily: hindFont,
    fontSize: 15,
    height: 1.5,
    color: AppColors.ink,
  );
  static const bodyMedium = TextStyle(
    fontFamily: hindFont,
    fontSize: 14,
    height: 1.4,
    color: AppColors.ink,
  );
  static const caption = TextStyle(
    fontFamily: hindFont,
    fontSize: 12,
    height: 1.4,
    color: AppColors.muted,
  );
  static const label = TextStyle(
    fontFamily: hindFont,
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
    seedColor: AppColors.burgundy,
    brightness: Brightness.light,
    primary: AppColors.burgundy,
    onPrimary: Colors.white,
    secondary: AppColors.black,
    onSecondary: Colors.white,
    primaryContainer: AppColors.surfaceSubtle,
    onPrimaryContainer: AppColors.burgundy,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
    surfaceContainerHighest: AppColors.surfaceMuted,
    error: AppColors.error,
    outline: AppColors.outlineLight,
  ),
  scaffoldBackgroundColor: AppColors.surface,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.black,
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: false,
    titleTextStyle: AppTypography.heading,
    iconTheme: IconThemeData(color: AppColors.black, size: 24),
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
      borderSide: const BorderSide(color: AppColors.burgundy, width: 2),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.burgundy, // Burgundy active CTA color
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
      foregroundColor: AppColors.black,
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
          color: AppColors.burgundy,
        );
      }
      return const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryGray,
      );
    }),
  ),
  materialTapTargetSize: MaterialTapTargetSize.padded,
);
