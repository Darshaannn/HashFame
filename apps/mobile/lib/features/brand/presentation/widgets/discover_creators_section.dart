import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';
import '../../../discovery/domain/creator_discovery_item.dart';
import '../../../discovery/presentation/discovery_controller.dart';

class DiscoverCreatorsSection extends ConsumerWidget {
  const DiscoverCreatorsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoveryState = ref.watch(discoveryControllerProvider);
    final items = discoveryState.items;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading & "See everyone ↗"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'DISCOVER CREATORS',
                  style: const TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => context.push('/discover'),
                borderRadius: BorderRadius.circular(4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See everyone',
                      style: TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.burgundy,
                      ),
                    ),
                    SizedBox(width: 3),
                    Icon(
                      Icons.arrow_outward,
                      size: 13,
                      color: AppColors.burgundy,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Cards Row (2 side-by-side cards or horizontal list)
          if (discoveryState.isLoading && items.isEmpty)
            const SizedBox(
              height: 110,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.burgundy,
                ),
              ),
            )
          else if (items.isEmpty)
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderGray),
              ),
              alignment: Alignment.center,
              child: const Text(
                'No creators currently listed in discovery.',
                style: TextStyle(
                  fontFamily: AppTypography.hindFont,
                  color: AppColors.secondaryGray,
                ),
              ),
            )
          else
            _buildCreatorGrid(context, items.take(2).toList()),
        ],
      ),
    );
  }

  Widget _buildCreatorGrid(BuildContext context, List<CreatorDiscoveryItem> creators) {
    return Row(
      children: [
        for (var i = 0; i < creators.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(
            child: _CreatorPreviewCard(
              creator: creators[i],
              fallbackIndex: i + 1,
            ),
          ),
        ],
      ],
    );
  }
}

class _CreatorPreviewCard extends StatelessWidget {
  const _CreatorPreviewCard({
    required this.creator,
    required this.fallbackIndex,
  });

  final CreatorDiscoveryItem creator;
  final int fallbackIndex;

  @override
  Widget build(BuildContext context) {
    final photoUrl = creator.avatarPath;
    final primaryCategory = creator.primaryCategoryNames.isNotEmpty
        ? creator.primaryCategoryNames.take(2).join(' / ')
        : 'Creator / Model';

    return InkWell(
      onTap: () => context.push('/discover/creator/${creator.creatorId}'),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderGray, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // Left Image
            SizedBox(
              width: 76,
              height: double.infinity,
              child: photoUrl != null
                  ? Image.network(
                      photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildFallbackPhoto(),
                    )
                  : _buildFallbackPhoto(),
            ),

            // Right Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            creator.displayName,
                            style: const TextStyle(
                              fontFamily: AppTypography.hindFont,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                              height: 1.15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_outward,
                          size: 13,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    Text(
                      primaryCategory,
                      style: const TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontSize: 10.5,
                        color: AppColors.secondaryGray,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackPhoto() {
    // If it's the demo persona or directory creator, use representative editorial asset or initial
    final assetPath = fallbackIndex == 1
        ? 'assets/demo/hero_creator_female.png'
        : 'assets/demo/hero_creator_male.png';

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Container(
        color: AppColors.lightGray,
        alignment: Alignment.center,
        child: Text(
          creator.displayName.isNotEmpty
              ? creator.displayName.substring(0, 1).toUpperCase()
              : 'C',
          style: const TextStyle(
            fontFamily: AppTypography.khandFont,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.burgundy,
          ),
        ),
      ),
    );
  }
}
