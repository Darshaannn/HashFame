import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../domain/campaign_application.dart';
import 'campaign_controller.dart';

class CampaignApplicantDashboardScreen extends ConsumerStatefulWidget {
  const CampaignApplicantDashboardScreen({super.key, required this.campaignId});

  final String campaignId;

  @override
  ConsumerState<CampaignApplicantDashboardScreen> createState() =>
      _CampaignApplicantDashboardScreenState();
}

class _CampaignApplicantDashboardScreenState
    extends ConsumerState<CampaignApplicantDashboardScreen> {
  CampaignApplicationStatus? _filterStatus;

  @override
  Widget build(BuildContext context) {
    final campaignAsync = ref.watch(campaignDetailProvider(widget.campaignId));
    final applicantsAsync = ref.watch(
      campaignApplicantsProvider(widget.campaignId),
    );

    return Scaffold(
      appBar: AppBar(
        title: campaignAsync.when(
          data: (c) => Text('${c.title} • Applicants'),
          loading: () => const Text('Applicants'),
          error: (_, _) => const Text('Applicants'),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: _filterStatus == null,
                  onSelected: (_) => setState(() => _filterStatus = null),
                ),
                const SizedBox(width: AppSpacing.xs),
                ...CampaignApplicationStatus.values.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xs),
                    child: ChoiceChip(
                      label: Text(s.label),
                      selected: _filterStatus == s,
                      onSelected: (_) => setState(() => _filterStatus = s),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Capacity Banner
          campaignAsync.when(
            data: (c) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Slots Filled: ${c.selectedCount} / ${c.creatorSlots}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (c.selectedCount >= c.creatorSlots)
                    const AppBadge(label: 'Capacity Full'),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),

          // Applicant List
          Expanded(
            child: applicantsAsync.when(
              loading: () => const Center(child: AppLoader()),
              error: (e, _) => Center(
                child: AppErrorState(
                  message: e.toString(),
                  onRetry: () => ref.invalidate(
                    campaignApplicantsProvider(widget.campaignId),
                  ),
                ),
              ),
              data: (applicants) {
                var filtered = applicants;
                if (_filterStatus != null) {
                  filtered = filtered
                      .where((a) => a.status == _filterStatus)
                      .toList();
                }

                if (filtered.isEmpty) {
                  return const Center(
                    child: AppEmptyState(
                      title: 'No Applicants',
                      message: 'No creators have applied matching this filter.',
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final applicant = filtered[index];
                    return AppCard(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      child: Text(
                                        applicant.creatorDisplayName != null &&
                                                applicant
                                                    .creatorDisplayName!
                                                    .isNotEmpty
                                            ? applicant.creatorDisplayName![0]
                                                  .toUpperCase()
                                            : 'C',
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          applicant.creatorDisplayName ??
                                              'Creator ${applicant.creatorId}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Applied: ${applicant.createdAt.day}/${applicant.createdAt.month}/${applicant.createdAt.year}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                AppBadge(label: applicant.status.label),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),

                            // Pitch preview
                            Text(
                              applicant.pitch,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                            if (applicant.proposedRate != null) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Proposed Rate: ₹${applicant.proposedRate!.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                            const SizedBox(height: AppSpacing.md),

                            // Actions
                            Wrap(
                              spacing: AppSpacing.xs,
                              runSpacing: AppSpacing.xs,
                              children: [
                                OutlinedButton(
                                  onPressed: () => context.push(
                                    '/discover/creator/${applicant.creatorId}',
                                  ),
                                  child: const Text('View Profile'),
                                ),
                                if (applicant.status ==
                                    CampaignApplicationStatus.submitted)
                                  OutlinedButton(
                                    onPressed: () => _updateStatus(
                                      applicant.id,
                                      CampaignApplicationStatus.underReview,
                                    ),
                                    child: const Text('Under Review'),
                                  ),
                                if (applicant.status ==
                                        CampaignApplicationStatus.submitted ||
                                    applicant.status ==
                                        CampaignApplicationStatus.underReview)
                                  OutlinedButton(
                                    onPressed: () => _updateStatus(
                                      applicant.id,
                                      CampaignApplicationStatus.shortlisted,
                                    ),
                                    child: const Text('Shortlist'),
                                  ),
                                if (applicant.status !=
                                        CampaignApplicationStatus.selected &&
                                    applicant.status !=
                                        CampaignApplicationStatus.rejected &&
                                    applicant.status !=
                                        CampaignApplicationStatus.withdrawn)
                                  FilledButton(
                                    onPressed: () => _updateStatus(
                                      applicant.id,
                                      CampaignApplicationStatus.selected,
                                    ),
                                    child: const Text('Select'),
                                  ),
                                if (applicant.status !=
                                        CampaignApplicationStatus.rejected &&
                                    applicant.status !=
                                        CampaignApplicationStatus.withdrawn)
                                  TextButton(
                                    onPressed: () => _updateStatus(
                                      applicant.id,
                                      CampaignApplicationStatus.rejected,
                                    ),
                                    child: const Text(
                                      'Reject',
                                      style: TextStyle(color: AppColors.error),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateStatus(
    String applicationId,
    CampaignApplicationStatus newStatus,
  ) async {
    final success = await ref
        .read(campaignActionControllerProvider.notifier)
        .transitionApplicationStatus(
          applicationId: applicationId,
          campaignId: widget.campaignId,
          newStatus: newStatus,
        );
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Applicant updated to ${newStatus.label}')),
      );
    } else {
      final error = ref.read(campaignActionControllerProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error?.toString() ?? 'Failed to update applicant status',
          ),
        ),
      );
    }
  }
}
