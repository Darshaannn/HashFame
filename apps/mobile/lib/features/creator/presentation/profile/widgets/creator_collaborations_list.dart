import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';

class CreatorCollaborationsList extends StatelessWidget {
  const CreatorCollaborationsList({
    super.key,
    required this.profile,
    this.onAddPressed,
    this.onDeleteItemPressed,
  });

  final CreatorProfile profile;
  final VoidCallback? onAddPressed;
  final ValueChanged<String>? onDeleteItemPressed;

  @override
  Widget build(BuildContext context) {
    final collabs = profile.pastCollaborations;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Past Collaborations', style: AppTypography.heading),
              if (onAddPressed != null)
                TextButton.icon(
                  onPressed: onAddPressed,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Collab'),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (collabs.isEmpty)
            const Text(
              'No past brand collaborations added. Add verified or previous work with brands.',
              style: TextStyle(color: AppColors.muted, fontStyle: FontStyle.italic),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: collabs.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final c = collabs[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    child: Icon(Icons.handshake_outlined, size: 20),
                  ),
                  title: Text(c.brandName, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    [
                      if (c.campaignName != null && c.campaignName!.isNotEmpty) c.campaignName!,
                      c.deliverableType.label,
                      if (c.collaborationYear != null) c.collaborationYear.toString(),
                      c.proofType.label,
                    ].join(' • '),
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: onDeleteItemPressed != null
                      ? IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20),
                          onPressed: () => onDeleteItemPressed!(c.id),
                        )
                      : null,
                );
              },
            ),
        ],
      ),
    );
  }
}
