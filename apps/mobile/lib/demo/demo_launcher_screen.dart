import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/app/router.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';

import 'demo_repositories.dart';
import 'demo_store.dart';

class DemoLauncherScreen extends ConsumerWidget {
  const DemoLauncherScreen({super.key, this.onRoleSelected});

  final VoidCallback? onRoleSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Ambient Burgundy Subtle Glow
          Positioned(
            top: -120,
            left: -80,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.burgundy.withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.lg,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Brand Header with Logo Pill
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(AppRadius.full),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.16),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: AppColors.burgundy,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'GG',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                const Text(
                                  'GGs Platform',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Concise, human headline
                      const Text(
                        'Creator Collaboration,\nSimplified.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Direct Matchmaking • Campaign Briefs • Milestone Deliverables',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.65),
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Visual Hero Card showcasing creator photography
                      const _HeroShowcaseCard(),

                      const SizedBox(height: AppSpacing.md),

                      // Slim, subtle Demo Mode pill
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: AppColors.burgundy,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'DEMO MODE',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '• Interactive Sandbox',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  color: Colors.white.withValues(alpha: 0.55),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.1),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                            ),
                            child: Text(
                              'SELECT PRESENTATION ROLE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.1),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // VIEW AS BRAND BUTTON
                      _PremiumRoleCard(
                        title: 'VIEW AS BRAND',
                        subtitle:
                            'Discover & shortlist creators, launch campaigns, review applicants',
                        roleBadge: 'CAMPAIGN MARKETER',
                        icon: Icons.business_center_outlined,
                        gradientColors: const [
                          Color(0xFF201616),
                          Color(0xFF181212),
                        ],
                        accentColor: AppColors.burgundy,
                        borderColor: AppColors.burgundy.withValues(alpha: 0.6),
                        isFeatured: true,
                        onPressed: () => _launchAs(
                          context,
                          ref,
                          ProfessionalRole.brandMarketer,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // VIEW AS CREATOR BUTTON
                      _PremiumRoleCard(
                        title: 'VIEW AS CREATOR',
                        subtitle:
                            'Professional portfolio, discover brand briefs, submit applications',
                        roleBadge: 'CREATOR ECONOMY',
                        icon: Icons.person_outline,
                        gradientColors: const [
                          Color(0xFF1E1E1E),
                          Color(0xFF161616),
                        ],
                        accentColor: Colors.white,
                        borderColor: Colors.white.withValues(alpha: 0.15),
                        isFeatured: false,
                        onPressed: () =>
                            _launchAs(context, ref, ProfessionalRole.creator),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // VIEW AS AGENCY BUTTON
                      _AgencyRoleCard(
                        onPressed: () =>
                            _launchAs(context, ref, ProfessionalRole.agency),
                      ),

                      const SizedBox(height: AppSpacing.xl),
                      Center(
                        child: Text(
                          'GGs Mobile v1.0 • Verified Presentation Sandbox',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchAs(BuildContext context, WidgetRef ref, ProfessionalRole role) {
    DemoStore.instance.currentRole = role;
    final authRepo = ref.read(authRepositoryProvider);
    if (authRepo is DemoAuthRepository) {
      authRepo.notifyRoleChanged();
    }
    ref.read(sessionProvider.notifier).refresh();
    if (onRoleSelected != null) {
      onRoleSelected!();
    } else {
      context.go(homePath(role));
    }
  }
}

/// Dynamic Hero visual banner highlighting creator discovery & brand matchmaking
class _HeroShowcaseCard extends StatelessWidget {
  const _HeroShowcaseCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.08),
            Colors.white.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Overlapping creator avatar stack
              SizedBox(
                width: 96,
                height: 40,
                child: Stack(
                  children: [
                    _avatarPill(AppImages.creatorAisha, 0),
                    _avatarPill(AppImages.creatorRohan, 24),
                    _avatarPill(AppImages.creatorNeha, 48),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.verified,
                          color: AppColors.burgundy,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Verified Creator Profiles',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Direct brand contracts & live briefs',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Row(
              children: [
                Expanded(child: _metricItem('Curated', 'Talent Roster')),
                _divider(),
                Expanded(child: _metricItem('Milestones', 'Tracked Deliverables')),
                _divider(),
                Expanded(child: _metricItem('Direct', 'Collab Workspace')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarPill(String url, double left) {
    return Positioned(
      left: left,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.black, width: 2),
        ),
        child: ClipOval(
          child: Image.network(
            url,
            width: 36,
            height: 36,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              width: 36,
              height: 36,
              color: const Color(0xFF2C2C2C),
              child: const Icon(Icons.person, color: Colors.white70, size: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 20,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }

  Widget _metricItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 11.5,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Refined, high-converting role card for Brand & Creator entry points
class _PremiumRoleCard extends StatelessWidget {
  const _PremiumRoleCard({
    required this.title,
    required this.subtitle,
    required this.roleBadge,
    required this.icon,
    required this.gradientColors,
    required this.accentColor,
    required this.borderColor,
    required this.isFeatured,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final String roleBadge;
  final IconData icon;
  final List<Color> gradientColors;
  final Color accentColor;
  final Color borderColor;
  final bool isFeatured;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: borderColor, width: isFeatured ? 1.5 : 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                // Role Icon Container with subtle glow
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Icon(icon, color: accentColor, size: 24),
                ),
                const SizedBox(width: AppSpacing.md),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          if (isFeatured) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.burgundy.withValues(
                                  alpha: 0.35,
                                ),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.burgundy,
                                ),
                              ),
                              child: const Text(
                                'PRIMARY',
                                style: TextStyle(
                                  color: Color(0xFFFF9999),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 11.5,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: accentColor,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Agency Role Entry Card with refined elevated styling
class _AgencyRoleCard extends StatelessWidget {
  const _AgencyRoleCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.apartment_outlined,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'View as Agency',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Manage creator rosters, campaign pitches & client deliverables',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white38,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

