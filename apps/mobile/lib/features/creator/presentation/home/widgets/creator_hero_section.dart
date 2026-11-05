import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/design_system/tokens.dart';
import '../../../domain/creator_profile.dart';

class CreatorHeroSection extends StatelessWidget {
  const CreatorHeroSection({
    super.key,
    required this.profile,
  });

  final CreatorProfile profile;

  @override
  Widget build(BuildContext context) {
    // Creator name (split into first/last for bold stacked typography)
    final displayName = profile.displayName.trim();
    final nameParts = displayName.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first.toUpperCase() : 'PRIYA';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ').toUpperCase() : 'MEHRA';

    // Tagline / bio
    final tagline = profile.bio?.isNotEmpty == true
        ? profile.bio!
        : 'Content Creator &\nLifestyle Storyteller';

    // Niches and categories
    final categoryTags = profile.primaryCategories.isNotEmpty
        ? profile.primaryCategories.map((c) => c.name).join('  •  ')
        : 'Brand Collaborations  •  UGC  •  Lifestyle\nTravel  •  Beauty  •  Everyday Inspiration';

    final photoUrl = profile.avatarPath ?? AppImages.getCreatorPhoto(displayName);

    return Container(
      height: 330,
      width: double.infinity,
      color: AppColors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Portrait Image (Cinematic, natural editorial lighting)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.72,
            child: photoUrl != null
                ? Image.network(
                    photoUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (_, _, _) => _buildFallbackPortrait(),
                  )
                : _buildFallbackPortrait(),
          ),

          // Deep Left-to-Right and Top-to-Bottom Shadow Gradients
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 0.45, 0.75, 1.0],
                  colors: [
                    AppColors.black,
                    AppColors.black.withValues(alpha: 0.95),
                    AppColors.black.withValues(alpha: 0.45),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.35, 1.0],
                  colors: [
                    AppColors.black,
                    AppColors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content Layer: Stacked Bold Khand Name, Burgundy Line, Bio, Categories, CTA
          Positioned(
            left: 20,
            right: 20,
            top: 24,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stacked First & Last Name with Burgundy vertical accent bar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 3.5,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.burgundy,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            firstName,
                            style: const TextStyle(
                              fontFamily: 'Khand',
                              fontWeight: FontWeight.w700,
                              fontSize: 34,
                              color: AppColors.white,
                              height: 0.92,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (lastName.isNotEmpty)
                            Text(
                              lastName,
                              style: const TextStyle(
                                fontFamily: 'Khand',
                                fontWeight: FontWeight.w700,
                                fontSize: 34,
                                color: AppColors.white,
                                height: 0.92,
                                letterSpacing: 0.5,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Creator Subtitle / Bio
                Text(
                  tagline,
                  style: const TextStyle(
                    fontFamily: 'Hind',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 10),

                // Metadata / Categories
                Text(
                  categoryTags,
                  style: TextStyle(
                    fontFamily: 'Hind',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 20),

                // Burgundy Primary Button: Find My Next Collaboration →
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.go('/opportunities'),
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.burgundy,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.burgundy.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.handshake_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Find My Next Collaboration',
                            style: TextStyle(
                              fontFamily: 'Hind',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '→',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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

  Widget _buildFallbackPortrait() {
    return Image.asset(
      'assets/demo/creator_aisha_hero.jpg',
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      errorBuilder: (_, _, _) => Container(
        color: const Color(0xFF2B1B1B),
        child: const Center(
          child: Icon(Icons.person, color: Colors.white30, size: 64),
        ),
      ),
    );
  }
}
