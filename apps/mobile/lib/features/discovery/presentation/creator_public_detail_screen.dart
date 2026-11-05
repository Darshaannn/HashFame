import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/navigation_history.dart';
import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../../creator/domain/creator_profile.dart';
import '../../creator/presentation/profile/creator_profile_controller.dart';
import '../../creator/presentation/profile/widgets/creator_availability_card.dart';
import '../../creator/presentation/profile/widgets/creator_bio_card.dart';
import '../../creator/presentation/profile/widgets/creator_categories_languages_card.dart';
import '../../creator/presentation/profile/widgets/creator_collaborations_list.dart';
import '../../creator/presentation/profile/widgets/creator_header_card.dart';
import '../../creator/presentation/profile/widgets/creator_portfolio_grid.dart';
import '../../creator/presentation/profile/widgets/creator_rate_card_view.dart';
import '../../creator/presentation/profile/widgets/creator_social_accounts_card.dart';
import '../../creator/presentation/profile/widgets/creator_verification_card.dart';
import '../../shortlist/presentation/widgets/add_to_shortlist_dialog.dart';

class CreatorPublicDetailScreen extends ConsumerWidget {
  const CreatorPublicDetailScreen({super.key, required this.creatorId});

  final String creatorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(creatorProfileProvider(creatorId));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await NavigationHistoryManager.handleBack(
          context,
          fallbackPath: '/discover',
        );
      },
      child: Scaffold(
        appBar: GGPageAppBar(
          title: 'Creator Profile',
          fallbackPath: '/discover',
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              tooltip: 'Save to Shortlist',
              onPressed: () {
                final profile = profileAsync.asData?.value;
                if (profile != null) {
                  showDialog(
                    context: context,
                    builder: (_) => AddToShortlistDialog(
                      creatorId: profile.userId,
                      creatorName: profile.displayName,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading profile: $e'),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: 'Retry',
                  onPressed: () =>
                      ref.invalidate(creatorProfileProvider(creatorId)),
                ),
              ],
            ),
          ),
          data: (profile) {
            // Log viewed
            ref
                .read(analyticsProvider)
                .event(AnalyticsEvent.creatorProfileViewed);

            final isDirectoryListing = profile.userId.startsWith('dir_');
            final igAccount = profile.socialAccounts
                .where((s) => s.handle.isNotEmpty || s.profileUrl != null)
                .firstOrNull;

            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  // Directory Listing Notice Banner if applicable
                  if (isDirectoryListing)
                    Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSubtle,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.outlineLight),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.menu_book_outlined,
                            size: 18,
                            color: AppColors.secondaryGray,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          const Expanded(
                            child: Text(
                              'Imported Creator Directory Listing • Unclaimed Profile',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Header Card (Name, handle, avatar or initials, verification)
                  CreatorHeaderCard(profile: profile),
                  const SizedBox(height: AppSpacing.md),

                  // Directory Specific Card or Standard Bio
                  if (isDirectoryListing) ...[
                    _buildDirectoryDetailsCard(context, profile, igAccount),
                    const SizedBox(height: AppSpacing.md),
                  ] else ...[
                    if (profile.bio != null && profile.bio!.trim().isNotEmpty) ...[
                      CreatorBioCard(profile: profile),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    CreatorCategoriesLanguagesCard(profile: profile),
                    const SizedBox(height: AppSpacing.md),
                    CreatorSocialAccountsCard(profile: profile),
                    const SizedBox(height: AppSpacing.md),
                    if (profile.rateCard.isNotEmpty) ...[
                      CreatorRateCardView(profile: profile),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    if (profile.portfolio.isNotEmpty) ...[
                      CreatorPortfolioGrid(profile: profile),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    if (profile.pastCollaborations.isNotEmpty) ...[
                      CreatorCollaborationsList(profile: profile),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    CreatorAvailabilityCard(
                      profile: profile,
                      onAvailabilityChanged: (_) {},
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CreatorVerificationCard(profile: profile),
                  ],

                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    label: 'Add to Shortlist',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AddToShortlistDialog(
                          creatorId: profile.userId,
                          creatorName: profile.displayName,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDirectoryDetailsCard(
    BuildContext context,
    CreatorProfile profile,
    dynamic igAccount,
  ) {
    final followerCount = igAccount?.userProvidedFollowerCount as int?;
    final igHandle = igAccount?.handle as String?;
    final igUrl = igAccount?.profileUrl as String? ??
        (igHandle != null && igHandle.isNotEmpty
            ? 'https://www.instagram.com/$igHandle/'
            : null);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profile Details', style: AppTypography.heading),
          const SizedBox(height: AppSpacing.md),

          // Categories
          if (profile.primaryCategories.isNotEmpty) ...[
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryGray,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: profile.primaryCategories.map((cat) {
                return Chip(
                  label: Text(
                    cat.name,
                    style: const TextStyle(fontSize: 12, color: AppColors.black),
                  ),
                  backgroundColor: AppColors.lightGray,
                  side: const BorderSide(color: AppColors.outlineLight),
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Follower Count with Spreadsheet Source Notice
          if (followerCount != null) ...[
            const Text(
              'Audience / Followers',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryGray,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  _formatFollowers(followerCount),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.burgundy,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Spreadsheet-supplied • Unverified',
                    style: TextStyle(fontSize: 11, color: AppColors.secondaryGray),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // City
          if (profile.location.city != null &&
              profile.location.city!.trim().isNotEmpty) ...[
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryGray,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16, color: AppColors.secondaryGray),
                const SizedBox(width: 4),
                Text(
                  '${profile.location.city}${profile.location.state != null ? ", ${profile.location.state}" : ""}, India',
                  style: const TextStyle(fontSize: 14, color: AppColors.black),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Instagram Link
          if (igHandle != null && igHandle.isNotEmpty) ...[
            const Text(
              'Instagram Presence',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryGray,
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () async {
                if (igUrl != null) {
                  final uri = Uri.parse(igUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(color: AppColors.outlineLight),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt_outlined, color: AppColors.burgundy),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '@$igHandle',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const Icon(Icons.open_in_new, size: 16, color: AppColors.secondaryGray),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatFollowers(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}
