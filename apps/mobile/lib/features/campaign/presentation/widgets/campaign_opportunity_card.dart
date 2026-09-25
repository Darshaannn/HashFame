import 'package:flutter/material.dart';

import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/campaign.dart';
import '../../domain/campaign_opportunity_item.dart';

class CampaignOpportunityCard extends StatelessWidget {
  const CampaignOpportunityCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final CampaignOpportunityItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Brand name & compensation badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  child: Text(
                    item.brandName.isNotEmpty
                        ? item.brandName[0].toUpperCase()
                        : 'B',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.brandName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.ink,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                AppBadge(label: item.compensationType.label),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Categories & Platforms
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                ...item.categoryNames.take(2).map((c) => AppBadge(label: c)),
                ...item.platforms.map((p) => AppBadge(label: p)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),

            // Footer: Budget & Application Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Compensation',
                      style: TextStyle(fontSize: 11, color: AppColors.muted),
                    ),
                    Text(
                      _buildCompensationText(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
                if (item.myApplicationStatus != null)
                  AppBadge(
                    label:
                        'Applied (${item.myApplicationStatus!.replaceAll('_', ' ')})',
                  )
                else if (item.applicationDeadline != null)
                  Text(
                    'Deadline: ${_formatDate(item.applicationDeadline!)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildCompensationText() {
    if (item.compensationType == CampaignCompensationType.paid) {
      if (item.budgetMin != null && item.budgetMax != null) {
        return '₹${item.budgetMin!.toStringAsFixed(0)} - ₹${item.budgetMax!.toStringAsFixed(0)}';
      } else if (item.budgetMin != null) {
        return 'From ₹${item.budgetMin!.toStringAsFixed(0)}';
      }
      return 'Paid';
    } else if (item.compensationType == CampaignCompensationType.barter) {
      return item.barterDescription ?? 'Product Barter';
    } else {
      return '₹${item.budgetMin?.toStringAsFixed(0) ?? ''} + Product';
    }
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
