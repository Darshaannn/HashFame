import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';

class CreatorBioCard extends StatelessWidget {
  const CreatorBioCard({super.key, required this.profile, this.onEditPressed});

  final CreatorProfile profile;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    final bio = profile.bio;
    final hasBio = bio != null && bio.trim().isNotEmpty;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bio & About', style: AppTypography.heading),
              if (onEditPressed != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: onEditPressed,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            hasBio ? bio : 'No bio added yet. Tell brands about your niche and creative style.',
            style: TextStyle(
              color: hasBio ? AppColors.ink : AppColors.muted,
              fontStyle: hasBio ? FontStyle.normal : FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
