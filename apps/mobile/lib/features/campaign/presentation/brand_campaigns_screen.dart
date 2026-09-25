import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/campaign.dart';
import 'campaign_controller.dart';

class BrandCampaignsScreen extends ConsumerWidget {
  const BrandCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountId = ref.watch(sessionProvider).snapshot?.account.id;
    if (accountId == null) {
      return const Scaffold(
        body: Center(child: Text('Account context required')),
      );
    }

    final campaignsAsync = ref.watch(organizationCampaignsProvider(accountId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brand Campaigns'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New Campaign',
            onPressed: () => context.push('/campaigns/new'),
          ),
        ],
      ),
      body: campaignsAsync.when(
        loading: () => const Center(child: AppLoader()),
        error: (e, _) => Center(
          child: AppErrorState(
            message: e.toString(),
            onRetry: () =>
                ref.invalidate(organizationCampaignsProvider(accountId)),
          ),
        ),
        data: (campaigns) {
          if (campaigns.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppEmptyState(
                      title: 'No Campaigns Yet',
                      message: 'Create your first creator campaign to receive applications.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppButton(
                      label: 'New Campaign',
                      onPressed: () => context.push('/campaigns/new'),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(organizationCampaignsProvider(accountId)),
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: campaigns.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final campaign = campaigns[index];
                return AppCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      campaign.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${campaign.creatorSlots} Slots • ${campaign.applicantCount} Applicants (${campaign.selectedCount} Selected)',
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Compensation: ${campaign.compensationType.label}',
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    trailing: AppBadge(label: campaign.status.label),
                    onTap: () {
                      if (campaign.status == CampaignStatus.draft) {
                        context.push('/campaigns/${campaign.id}/edit');
                      } else {
                        context.push('/campaigns/${campaign.id}/applicants');
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/campaigns/new'),
        label: const Text('New Campaign'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
