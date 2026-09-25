import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_discovery_item.dart';
import 'package:ggs_mobile/features/shortlist/presentation/shortlist_controller.dart';
import 'package:ggs_mobile/features/shortlist/presentation/widgets/add_to_shortlist_dialog.dart';

class CreatorDiscoveryCard extends ConsumerWidget {
  const CreatorDiscoveryCard({super.key, required this.creator, this.onTap});

  final CreatorDiscoveryItem creator;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedMemberships =
        ref.watch(savedCreatorMembershipsProvider).asData?.value ?? {};
    final isSaved = savedMemberships.containsKey(creator.creatorId);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar placeholder / thumbnail
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: Text(
                    creator.displayName.isNotEmpty
                        ? creator.displayName[0].toUpperCase()
                        : 'C',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              creator.displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (creator.isRepresented) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified_user,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ],
                      ),
                      if (creator.professionalName != null &&
                          creator.professionalName!.isNotEmpty)
                        Text(
                          '@${creator.professionalName}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (creator.city != null && creator.city!.isNotEmpty)
                        Text(
                          '${creator.city}, ${creator.state ?? creator.country}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
                // Shortlist Bookmark Button
                IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? AppColors.primary : null,
                  ),
                  tooltip: isSaved
                      ? 'Saved in shortlists'
                      : 'Save to shortlist',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AddToShortlistDialog(
                        creatorId: creator.creatorId,
                        creatorName: creator.displayName,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Categories
            if (creator.primaryCategoryNames.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: creator.primaryCategoryNames.take(3).map((cat) {
                  return Chip(
                    label: Text(cat, style: const TextStyle(fontSize: 11)),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                  );
                }).toList(),
              ),

            const SizedBox(height: AppSpacing.xs),
            const Divider(height: 12),

            // Bottom stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (creator.primaryPlatform != null)
                  Row(
                    children: [
                      Icon(
                        Icons.public,
                        size: 14,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        creator.primaryPlatform!.label,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (creator.totalFollowers != null)
                        Text(
                          ' • ${_formatFollowers(creator.totalFollowers!)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                    ],
                  )
                else
                  const Text('Multi-platform', style: TextStyle(fontSize: 12)),

                if (creator.startingRate != null)
                  Text(
                    'From ₹${creator.startingRate!.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  )
                else
                  const Text(
                    'Rate on request',
                    style: TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatFollowers(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}
