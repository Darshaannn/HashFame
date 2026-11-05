import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/design_system/tokens.dart';
import '../../../../collaboration/domain/active_collaboration.dart';

class OpportunitiesAndProjectSection extends StatelessWidget {
  const OpportunitiesAndProjectSection({
    super.key,
    this.activeCollaboration,
  });

  final ActiveCollaboration? activeCollaboration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildOpportunitiesCard(context)),
                const SizedBox(width: 14),
                Expanded(child: _buildActiveProjectCard(context)),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildOpportunitiesCard(context),
              const SizedBox(height: 14),
              _buildActiveProjectCard(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOpportunitiesCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGray, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Expanded(
                child: Text(
                  'OPPORTUNITIES FOR YOU',
                  style: TextStyle(
                    fontFamily: 'Khand',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.black,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => context.go('/opportunities'),
                borderRadius: BorderRadius.circular(4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: 'Hind',
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
          const SizedBox(height: 10),

          // Item 1
          _buildOpportunityRow(
            context,
            imageAsset: 'assets/demo/opp_cosmetics.jpg',
            fallbackIcon: Icons.card_giftcard,
            title: 'Lifestyle Brand Campaign',
            subtitle: 'UGC • 1 Video • ₹40,000',
            onTap: () => context.go('/opportunities'),
          ),
          const Divider(height: 16, thickness: 0.7, color: AppColors.lightGray),

          // Item 2
          _buildOpportunityRow(
            context,
            imageAsset: 'assets/demo/opp_beach.jpg',
            fallbackIcon: Icons.flight_takeoff,
            title: 'Travel Content Series',
            subtitle: '3 Reels • ₹1,20,000',
            onTap: () => context.go('/opportunities'),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityRow(
    BuildContext context, {
    required String imageAsset,
    required IconData fallbackIcon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: AppColors.lightGray,
                    child: Icon(fallbackIcon, size: 20, color: AppColors.burgundy),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Hind',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Hind',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.secondaryGray,
                    ),
                  ),
                ],
              ),
            ),

            // Bookmark icon
            IconButton(
              icon: const Icon(
                Icons.bookmark_border_rounded,
                size: 20,
                color: AppColors.secondaryGray,
              ),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Saved "$title" to your saved briefs!'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveProjectCard(BuildContext context) {
    final hasCollab = activeCollaboration != null;
    final collabTitle = (hasCollab && activeCollaboration!.campaignTitle?.isNotEmpty == true)
        ? activeCollaboration!.campaignTitle!
        : 'GlowHer Skincare';
    final deliverableSummary = hasCollab && activeCollaboration!.deliverableRequirements.isNotEmpty
        ? 'Deliverables: ${activeCollaboration!.deliverableRequirements.join(', ')}'
        : 'Deliverables: 2 Reels + 3 Photos';
    
    final dueDate = (hasCollab && activeCollaboration!.dueDate != null)
        ? 'Due: ${activeCollaboration!.dueDate!.day}/${activeCollaboration!.dueDate!.month}/${activeCollaboration!.dueDate!.year}'
        : 'Due: Jan 28, 2025';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGray, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Expanded(
                child: Text(
                  'ACTIVE PROJECT',
                  style: TextStyle(
                    fontFamily: 'Khand',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.black,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => context.go('/collaborations'),
                borderRadius: BorderRadius.circular(4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: 'Hind',
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
          const SizedBox(height: 10),

          // Active Project details card
          InkWell(
            onTap: () {
              if (hasCollab) {
                context.push('/collaborations/${activeCollaboration!.id}');
              } else {
                context.go('/collaborations');
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightGray.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderGray.withValues(alpha: 0.6), width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Image.asset(
                            'assets/demo/active_proj_candle.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: AppColors.lightGray,
                              child: const Icon(
                                Icons.workspace_premium_outlined,
                                size: 22,
                                color: AppColors.burgundy,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Brand & Status Pill
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              collabTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Hind',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFDE8E8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'In Progress',
                                style: TextStyle(
                                  fontFamily: 'Hind',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: AppColors.burgundy,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.secondaryGray,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Deliverables & Due date
                  Text(
                    deliverableSummary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Hind',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dueDate,
                    style: const TextStyle(
                      fontFamily: 'Hind',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
