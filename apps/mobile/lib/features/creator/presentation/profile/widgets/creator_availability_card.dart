import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';

class CreatorAvailabilityCard extends StatelessWidget {
  const CreatorAvailabilityCard({
    super.key,
    required this.profile,
    required this.onAvailabilityChanged,
  });

  final CreatorProfile profile;
  final ValueChanged<CreatorAvailability> onAvailabilityChanged;

  @override
  Widget build(BuildContext context) {
    final currentStatus = profile.availability.status;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Collaboration Availability', style: AppTypography.heading),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Signal your readiness for brand campaigns and creator collaborations.',
            style: TextStyle(fontSize: 13, color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AvailabilityStatus.values.map((status) {
              final isSelected = currentStatus == status;
              return AppChip(
                label: status.label,
                selected: isSelected,
                onSelected: (_) {
                  onAvailabilityChanged(
                    profile.availability.copyWith(status: status),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
