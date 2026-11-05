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
                // Creator photograph or initials placeholder
                AppAvatar(
                  label: creator.displayName,
                  imageUrl: creator.avatarPath ?? AppImages.getCreatorPhoto(creator.displayName),
                  radius: 28,
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
                                color: AppColors.black,
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
                              color: AppColors.burgundy,
                            ),
                          ],
                        ],
                      ),
                      if (creator.professionalName != null &&
                          creator.professionalName!.isNotEmpty)
                        Text(
                          '@${creator.professionalName}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryGray,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (creator.city != null && creator.city!.isNotEmpty)
                        Text(
                          '${creator.city}, ${creator.state ?? creator.country}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryGray,
                          ),
                        ),
                    ],
                  ),
                ),
                // Shortlist Bookmark Button
                IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? AppColors.burgundy : AppColors.secondaryGray,
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
                    label: Text(
                      cat,
                      style: const TextStyle(fontSize: 11, color: AppColors.black),
                    ),
                    backgroundColor: AppColors.lightGray,
                    side: const BorderSide(color: AppColors.outlineLight),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                  );
                }).toList(),
              ),

            const SizedBox(height: AppSpacing.xs),
            const Divider(height: 12, color: AppColors.outlineLight),

            // Bottom stats row & View Profile
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (creator.primaryPlatform != null)
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          size: 14,
                          color: AppColors.secondaryGray,
                        ),
                        const SizedBox(width: 4),
                        if (creator.totalFollowers != null)
                          Text(
                            '${_formatFollowers(creator.totalFollowers!)} followers',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          )
                        else
                          const Text(
                            'Followers unlisted',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.secondaryGray,
                            ),
                          ),
                      ],
                    ),
                  )
                else
                  const Text('Instagram', style: TextStyle(fontSize: 12, color: AppColors.secondaryGray)),

                TextButton(
                  onPressed: onTap,
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    foregroundColor: AppColors.burgundy,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.arrow_forward_ios, size: 10),
                    ],
                  ),
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
