import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';
import '../../../discovery/presentation/discovery_controller.dart';

class BrowseYourWaySection extends ConsumerWidget {
  const BrowseYourWaySection({super.key});

  static const List<_CategoryItem> _curatedCategories = [
    _CategoryItem('Fashion', Icons.checkroom_outlined),
    _CategoryItem('Beauty', Icons.brush_outlined),
    _CategoryItem('Travel', Icons.flight_outlined),
    _CategoryItem('Food', Icons.restaurant_outlined),
    _CategoryItem('Fitness', Icons.fitness_center_outlined),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'BROWSE YOUR WAY',
                  style: TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    color: AppColors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () => context.push('/discover'),
                borderRadius: BorderRadius.circular(4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'All niches',
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

          // Horizontal scrollable pills row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < _curatedCategories.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  _buildCategoryPill(context, ref, _curatedCategories[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPill(
    BuildContext context,
    WidgetRef ref,
    _CategoryItem item,
  ) {
    return InkWell(
      onTap: () {
        ref.read(creatorSearchFiltersProvider.notifier).update(
              (filters) => filters.copyWith(
                categoryIds: [item.name.toLowerCase()],
              ),
            );
        ref.read(discoveryControllerProvider.notifier).search(initial: true);
        context.push('/discover');
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.burgundy,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 15,
              color: AppColors.white,
            ),
            const SizedBox(width: 6),
            Text(
              item.name,
              style: const TextStyle(
                fontFamily: AppTypography.hindFont,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem {
  const _CategoryItem(this.name, this.icon);
  final String name;
  final IconData icon;
}
