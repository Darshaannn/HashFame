import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';

class AgencyEditorialHero extends StatelessWidget {
  const AgencyEditorialHero({
    super.key,
    required this.agencyName,
    this.headline = 'CREATIVE\nTALENT FOR\nBRAND IMPACT',
    this.description = 'A creative talent agency connecting brands and creators through strategy, content, and culture.',
    this.ctaText = 'Discover Creators',
  });

  final String agencyName;
  final String headline;
  final String description;
  final String ctaText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        color: AppColors.black,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Right Editorial Photography with Burgundy background
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.52,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Deep Burgundy backplate
                Container(color: AppColors.burgundy),

                // Model photograph
                Image.asset(
                  'assets/demo/agency_hero_model.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, _, _) => Container(
                    color: AppColors.deepBurgundy,
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.white24, size: 54),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Diagonal geometric divider mask & shadows
          Positioned.fill(
            child: CustomPaint(
              painter: _DiagonalHeroPainter(),
            ),
          ),

          // 3. Editorial text & CTA (Left half)
          Positioned(
            left: 18,
            top: 18,
            bottom: 18,
            right: MediaQuery.of(context).size.width * 0.38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Agency Identity
                Text(
                  agencyName.isNotEmpty ? agencyName : 'Pulse Talent & Media',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 10),

                // Large Khand Bold Headline
                Text(
                  headline,
                  style: const TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 27,
                    height: 0.95,
                    color: AppColors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),

                // Supporting text
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    height: 1.25,
                    color: Colors.white.withValues(alpha: 0.82),
                  ),
                ),
                const SizedBox(height: 14),

                // Burgundy CTA: Discover Creators →
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.go('/discover'),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.burgundy,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.burgundy.withValues(alpha: 0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            ctaText,
                            style: const TextStyle(
                              fontFamily: AppTypography.hindFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.white,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '→',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagonalHeroPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Fill left black area with a diagonal split cutting into the right image
    final splitX = size.width * 0.58;
    final bottomSplitX = size.width * 0.46;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(splitX, 0)
      ..lineTo(bottomSplitX, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Subtle dark gradient along the edge of the diagonal
    final shadowPath = Path()
      ..moveTo(splitX, 0)
      ..lineTo(splitX + 16, 0)
      ..lineTo(bottomSplitX + 16, size.height)
      ..lineTo(bottomSplitX, size.height)
      ..close();

    final shadowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.black.withValues(alpha: 0.45),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(bottomSplitX, 0, splitX - bottomSplitX + 16, size.height));

    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

