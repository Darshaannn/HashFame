import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';
import '../../../campaign/domain/campaign.dart';
import '../../../campaign/presentation/campaign_controller.dart';

class CampaignSpaceSection extends ConsumerWidget {
  const CampaignSpaceSection({super.key, required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignsAsync = ref.watch(organizationCampaignsProvider(accountId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'YOUR CAMPAIGN SPACE',
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
                onTap: () => context.push('/campaigns'),
                borderRadius: BorderRadius.circular(4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View all',
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
          const SizedBox(height: 10),

          // Container Box
          campaignsAsync.when(
            loading: () => Container(
              height: 110,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.burgundy,
                ),
              ),
            ),
            error: (e, _) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Could not load campaigns: $e',
                style: const TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontSize: 12,
                  color: AppColors.secondaryGray,
                ),
              ),
            ),
            data: (campaigns) {
              final activeCount = campaigns
                  .where((c) => c.status == CampaignStatus.live)
                  .length;
              final draftCount = campaigns
                  .where((c) => c.status == CampaignStatus.draft)
                  .length;

              final mostRelevant = campaigns.isNotEmpty
                  ? (campaigns.firstWhere(
                      (c) => c.status == CampaignStatus.live,
                      orElse: () => campaigns.first,
                    ))
                  : null;

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Count line: "1 active · 1 drafts"
                    Text(
                      '$activeCount active · $draftCount draft${draftCount == 1 ? '' : 's'}',
                      style: const TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryGray,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Campaign Card or Empty
                    if (mostRelevant != null)
                      _buildCampaignCard(context, mostRelevant)
                    else
                      _buildEmptyCampaignCard(context),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(BuildContext context, Campaign campaign) {
    final isLive = campaign.status == CampaignStatus.live;
    final statusLabel = isLive ? 'Active' : 'Draft';
    final statusBg = isLive
        ? const Color(0xFFE2F7E4)
        : const Color(0xFFEEEEEE);
    final statusColor = isLive
        ? const Color(0xFF2E7D32)
        : AppColors.secondaryGray;

    return InkWell(
      onTap: () => context.push('/campaigns/${campaign.id}'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGray, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            // Megaphone icon in soft circle
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF9EBEB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.campaign_outlined,
                color: AppColors.burgundy,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),

            // Campaign Title and Status Badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campaign.title,
                    style: const TextStyle(
                      fontFamily: AppTypography.hindFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right Chevron
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.secondaryGray,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCampaignCard(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/campaigns/new'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGray, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: const Row(
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.burgundy,
              size: 24,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Create your first campaign',
                style: TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.secondaryGray,
            ),
          ],
        ),
      ),
    );
  }
}
