import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';


class CreatorCategoriesLanguagesCard extends StatelessWidget {
  const CreatorCategoriesLanguagesCard({
    super.key,
    required this.profile,
    this.onEditPressed,
  });

  final CreatorProfile profile;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    final allCats = [...profile.primaryCategories, ...profile.additionalCategories];
    final langs = profile.languages;
    final loc = profile.location;
    final locStr = [loc.city, loc.state, loc.country].where((s) => s != null && s.isNotEmpty).join(', ');

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Niche & Demographics', style: AppTypography.heading),
              if (onEditPressed != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: onEditPressed,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          
          // Location
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18, color: AppColors.muted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  locStr.isEmpty ? 'Location not specified' : locStr,
                  style: TextStyle(
                    color: locStr.isEmpty ? AppColors.muted : AppColors.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Categories
          const Text('Content Categories', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 6),
          if (allCats.isEmpty)
            const Text('No categories selected', style: TextStyle(color: AppColors.muted, fontStyle: FontStyle.italic))
          else
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: allCats.map((cat) => AppBadge(label: cat.name)).toList(),
            ),
          const SizedBox(height: AppSpacing.md),

          // Languages
          const Text('Languages', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 6),
          if (langs.isEmpty)
            const Text('No languages specified', style: TextStyle(color: AppColors.muted, fontStyle: FontStyle.italic))
          else
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: langs.map((l) => AppBadge(label: '${l.name} (${l.nativeName})')).toList(),
            ),
        ],
      ),
    );
  }
}
