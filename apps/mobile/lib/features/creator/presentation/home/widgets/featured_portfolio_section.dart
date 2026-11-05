import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/design_system/tokens.dart';
import '../../../domain/portfolio.dart';

class FeaturedPortfolioSection extends StatelessWidget {
  const FeaturedPortfolioSection({
    super.key,
    this.portfolioItems = const [],
  });

  final List<PortfolioItem> portfolioItems;

  static const List<_DemoPortfolioItem> _defaultDemoItems = [
    _DemoPortfolioItem(
      assetPath: 'assets/demo/portfolio_perfume.jpg',
      isVideo: true,
      title: 'Luxury Perfume Reel',
    ),
    _DemoPortfolioItem(
      assetPath: 'assets/demo/portfolio_travel.jpg',
      isVideo: false,
      title: 'Mediterranean Travel Story',
    ),
    _DemoPortfolioItem(
      assetPath: 'assets/demo/portfolio_coffee.jpg',
      isVideo: false,
      title: 'Morning Brew Journal',
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
                  'FEATURED PORTFOLIO',
                  style: TextStyle(
                    fontFamily: 'Khand',
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                    color: AppColors.black,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => context.push('/profile/edit/portfolio'),
                borderRadius: BorderRadius.circular(4),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Portfolio',
                        style: TextStyle(
                          fontFamily: 'Hind',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.burgundy,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '→',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Portfolio horizontal carousel/grid
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: portfolioItems.isNotEmpty
                ? portfolioItems.length
                : _defaultDemoItems.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (portfolioItems.isNotEmpty) {
                final item = portfolioItems[index];
                return _buildItemCard(
                  context,
                  url: item.mediaPath ?? item.contentUrl,
                  isVideo: item.contentType == PortfolioContentType.video,
                  title: item.title,
                );
              } else {
                final item = _defaultDemoItems[index];
                return _buildItemCard(
                  context,
                  assetPath: item.assetPath,
                  isVideo: item.isVideo,
                  title: item.title,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(
    BuildContext context, {
    String? assetPath,
    String? url,
    required bool isVideo,
    required String title,
  }) {
    return GestureDetector(
      onTap: () => context.push('/profile/edit/portfolio'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 114,
          height: 110,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderGray, width: 0.8),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (assetPath != null)
                Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _buildPlaceholder(),
                )
              else if (url != null && url.startsWith('http'))
                Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _buildPlaceholder(),
                )
              else
                _buildPlaceholder(),

              // Gradient protection for icon
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.4),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom right media indicator (play / photo)
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isVideo ? Icons.play_arrow_rounded : Icons.photo_library_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
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
      color: const Color(0xFF2B1B1B),
      child: const Center(
        child: Icon(Icons.image_outlined, color: Colors.white30, size: 28),
      ),
    );
  }
}

class _DemoPortfolioItem {
  const _DemoPortfolioItem({
    required this.assetPath,
    required this.isVideo,
    required this.title,
  });

  final String assetPath;
  final bool isVideo;
  final String title;
}
