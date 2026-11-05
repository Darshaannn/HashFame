import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';

class AgencyPortfolioPreview extends StatelessWidget {
  const AgencyPortfolioPreview({super.key});

  static const List<_DemoPortfolioItem> _items = [
    _DemoPortfolioItem(
      title: 'Beauty Launch',
      category: 'Content • Creator Campaign',
      imageAsset: 'assets/demo/agency_port_beauty.jpg',
    ),
    _DemoPortfolioItem(
      title: 'Travel Campaign',
      category: 'Content • Destination Series',
      imageAsset: 'assets/demo/agency_port_travel.jpg',
    ),
    _DemoPortfolioItem(
      title: 'Lifestyle Series',
      category: 'Content • Brand Collaboration',
      imageAsset: 'assets/demo/agency_port_lifestyle.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'PORTFOLIO PREVIEW',
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
                onTap: () => context.go('/campaigns'),
                borderRadius: BorderRadius.circular(4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Portfolio',
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

        // 3 Horizontal Portfolio Cards
        SizedBox(
          height: 105,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = _items[index];
              return _buildCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, _DemoPortfolioItem item) {
    return GestureDetector(
      onTap: () => context.go('/campaigns'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 124,
          height: 105,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderGray, width: 0.8),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo
              Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: const Color(0xFF2C2222),
                  child: const Center(
                    child: Icon(Icons.image_outlined, color: Colors.white24, size: 28),
                  ),
                ),
              ),

              // Bottom dark gradient overlay for text readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.3, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
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
}

class _DemoPortfolioItem {
  const _DemoPortfolioItem({
    required this.title,
    required this.category,
    required this.imageAsset,
  });

  final String title;
  final String category;
  final String imageAsset;
}
