import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../core/telemetry/analytics_service.dart';
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
  const CreatorPublicDetailScreen({
    super.key,
    required this.creatorId,
  });

  final String creatorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(creatorProfileProvider(creatorId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creator Profile'),
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
                onPressed: () => ref.invalidate(creatorProfileProvider(creatorId)),
              ),
            ],
          ),
        ),
        data: (profile) {
          // Log viewed
          ref.read(analyticsProvider).event(AnalyticsEvent.creatorProfileViewed);

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                CreatorHeaderCard(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorBioCard(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorCategoriesLanguagesCard(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorSocialAccountsCard(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorRateCardView(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorPortfolioGrid(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorCollaborationsList(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorAvailabilityCard(
                  profile: profile,
                  showEdit: false,
                ),
                const SizedBox(height: AppSpacing.md),
                CreatorVerificationCard(
                  profile: profile,
                ),
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
    );
  }
}
