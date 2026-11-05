import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';
import '../../../campaign/domain/campaign.dart';

class CampaignSpotlightAndActivitySection extends StatelessWidget {
  const CampaignSpotlightAndActivitySection({
    super.key,
    this.activeCampaign,
    required this.activeCampaignsCount,
    required this.managedTalentCount,
    required this.newApplicantsCount,
    required this.collaborationsCount,
  });

  final Campaign? activeCampaign;
  final int activeCampaignsCount;
  final int managedTalentCount;
  final int newApplicantsCount;
  final int collaborationsCount;

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
                Expanded(flex: 6, child: _buildSpotlight(context)),
                const SizedBox(width: 14),
                Expanded(flex: 5, child: _buildActivity(context)),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSpotlight(context),
              const SizedBox(height: 14),
              _buildActivity(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSpotlight(BuildContext context) {
    final title = activeCampaign?.title.isNotEmpty == true
        ? activeCampaign!.title
        : 'Beauty Launch';
    final description = activeCampaign?.description.isNotEmpty == true
        ? activeCampaign!.description
        : 'Creator-led content for a new beauty line.';

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
                  'ACTIVE CAMPAIGN SPOTLIGHT',
                  style: TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.black,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 20,
                height: 1.5,
                color: AppColors.burgundy,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Campaign Spotlight Card
          InkWell(
            onTap: () {
              if (activeCampaign != null) {
                context.push('/campaigns/${activeCampaign!.id}');
              } else {
                context.go('/campaigns');
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 72,
                    height: 72,
                    child: Image.asset(
                      'assets/demo/agency_active_camp.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.lightGray,
                        child: const Icon(
                          Icons.campaign_rounded,
                          color: AppColors.burgundy,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTypography.hindFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTypography.hindFont,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          height: 1.25,
                          color: AppColors.secondaryGray,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDE8E8),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'In Progress',
                              style: TextStyle(
                                fontFamily: AppTypography.hindFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: AppColors.burgundy,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '→',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.burgundy,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivity(BuildContext context) {
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
              const Text(
                'AGENCY ACTIVITY',
                style: TextStyle(
                  fontFamily: AppTypography.khandFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.black,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 20,
                height: 1.5,
                color: AppColors.burgundy,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Stat 1: Active Campaigns
          _buildActivityRow(
            icon: Icons.groups_outlined,
            label: 'Active Campaigns',
            value: '$activeCampaignsCount',
            onTap: () => context.go('/campaigns'),
          ),
          const Divider(height: 12, thickness: 0.6, color: AppColors.lightGray),

          // Stat 2: Managed Talent
          _buildActivityRow(
            icon: Icons.person_outline_rounded,
            label: 'Managed Talent',
            value: '$managedTalentCount',
            onTap: () => context.go('/talent'),
          ),
          const Divider(height: 12, thickness: 0.6, color: AppColors.lightGray),

          // Stat 3: New Applicants
          _buildActivityRow(
            icon: Icons.assignment_outlined,
            label: 'New Applicants',
            value: '$newApplicantsCount',
            onTap: () => context.go('/campaigns'),
          ),
          const Divider(height: 12, thickness: 0.6, color: AppColors.lightGray),

          // Stat 4: Collaborations
          _buildActivityRow(
            icon: Icons.handshake_outlined,
            label: 'Collaborations',
            value: '$collaborationsCount',
            onTap: () => context.push('/collaborations'),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.black),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.black,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: AppTypography.khandFont,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.burgundy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

