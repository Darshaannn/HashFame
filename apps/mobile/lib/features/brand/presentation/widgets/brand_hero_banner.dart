import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';

class BrandHeroBanner extends StatelessWidget {
  const BrandHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 196,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.burgundy,
              AppColors.deepBurgundy,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.burgundy.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Left content: Headline and CTA button
            Positioned(
              left: 18,
              top: 18,
              bottom: 18,
              right: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'FIND YOUR\nNEXT FACE.',
                    style: TextStyle(
                      fontFamily: AppTypography.khandFont,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      height: 0.98,
                      letterSpacing: -0.2,
                      color: AppColors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/discover'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      minimumSize: const Size(0, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Start discovering',
                          style: TextStyle(
                            fontFamily: AppTypography.hindFont,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_outward,
                          size: 13,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right content: Editorial overlapping collage of 2 creator portraits
            Positioned(
              right: -10,
              top: 10,
              bottom: 10,
              width: 200,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Left Portrait in Collage (Slight counter-clockwise rotation)
                  Positioned(
                    left: 10,
                    top: 10,
                    width: 105,
                    height: 155,
                    child: Transform.rotate(
                      angle: -0.06,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 2.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 10,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/demo/banner_model_female.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Image.asset(
                            'assets/demo/hero_creator_female.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Right Portrait in Collage (Overlapping, slight clockwise rotation)
                  Positioned(
                    right: 12,
                    top: 8,
                    width: 105,
                    height: 155,
                    child: Transform.rotate(
                      angle: 0.05,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 2.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(-2, 5),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/demo/banner_model_male.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Image.asset(
                            'assets/demo/hero_creator_male.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
