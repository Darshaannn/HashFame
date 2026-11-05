import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';
import '../../../discovery/domain/creator_discovery_item.dart';

class FeaturedTalentCarousel extends StatelessWidget {
  const FeaturedTalentCarousel({
    super.key,
    required this.talentList,
  });

  final List<CreatorDiscoveryItem> talentList;

  static const List<_DemoTalentItem> _defaultTalentItems = [
    _DemoTalentItem(
      name: 'Alex K.',
      categories: 'Lifestyle • Travel',
      imageAsset: 'assets/demo/talent_alex.jpg',
    ),
    _DemoTalentItem(
      name: 'Mia R.',
      categories: 'Beauty • Fashion',
      imageAsset: 'assets/demo/talent_mia.jpg',
    ),
    _DemoTalentItem(
      name: 'Ethan L.',
      categories: 'Lifestyle • Food',
      imageAsset: 'assets/demo/talent_ethan.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'FEATURED TALENT',
                  style: TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.black,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => context.go('/talent'),
                borderRadius: BorderRadius.circular(4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Roster',
                      style: TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.burgundy,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      '→',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.burgundy,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Talent Cards Carousel
        SizedBox(
          height: 140,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: talentList.isNotEmpty
                ? talentList.length
                : _defaultTalentItems.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (talentList.isNotEmpty) {
                final creator = talentList[index];
                return _buildTalentCard(
                  context,
                  name: creator.displayName,
                  categories: creator.primaryCategoryNames.isNotEmpty
                      ? creator.primaryCategoryNames.take(2).join(' • ')
                      : 'Talent • Creator',
                  imageUrl: creator.avatarPath ?? AppImages.getCreatorPhoto(creator.displayName),
                  onTap: () => context.push('/creators/${creator.creatorId}'),
                );
              } else {
                final item = _defaultTalentItems[index];
                return _buildTalentCard(
                  context,
                  name: item.name,
                  categories: item.categories,
                  imageAsset: item.imageAsset,
                  onTap: () => context.go('/talent'),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTalentCard(
    BuildContext context, {
    required String name,
    required String categories,
    String? imageUrl,
    String? imageAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 124,
          height: 140,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderGray, width: 0.8),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo
              if (imageAsset != null)
                Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _buildPlaceholder(),
                )
              else if (imageUrl != null && imageUrl.isNotEmpty)
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _buildPlaceholder(),
                )
              else
                _buildPlaceholder(),

              // Bottom dark gradient overlay for text readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.35, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom text: Name & Categories
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        color: AppColors.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      categories,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontWeight: FontWeight.w400,
                        fontSize: 9.5,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF2C2222),
      child: const Center(
        child: Icon(Icons.person, color: Colors.white24, size: 36),
      ),
    );
  }
}

class _DemoTalentItem {
  const _DemoTalentItem({
    required this.name,
    required this.categories,
    required this.imageAsset,
  });

  final String name;
  final String categories;
  final String imageAsset;
}
