import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../account/domain/account.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/campaign.dart';
import 'campaign_controller.dart';

class CampaignDetailScreen extends ConsumerStatefulWidget {
  const CampaignDetailScreen({super.key, required this.campaignId});

  final String campaignId;

  @override
  ConsumerState<CampaignDetailScreen> createState() =>
      _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends ConsumerState<CampaignDetailScreen> {
  final _pitchController = TextEditingController();
  final _rateController = TextEditingController();
  bool _availabilityConfirmed = false;

  @override
  void dispose() {
    _pitchController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _showApplyDialog(Campaign campaign, String creatorId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.lg,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + AppSpacing.lg,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apply to ${campaign.title}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _pitchController,
                    label: 'Your Pitch / Message (Required)',
                    maxLength: 1000,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (campaign.compensationType !=
                      CampaignCompensationType.barter)
                    AppTextField(
                      controller: _rateController,
                      label: 'Proposed Rate (₹ Optional)',
                      keyboardType: TextInputType.number,
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  CheckboxListTile(
                    title: const Text(
                      'I confirm my availability for the campaign dates and deliverable deadlines.',
                    ),
                    value: _availabilityConfirmed,
                    onChanged: (val) => setModalState(
                      () => _availabilityConfirmed = val ?? false,
                    ),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Submit Application',
                    onPressed:
                        _pitchController.text.trim().length < 10 ||
                            !_availabilityConfirmed
                        ? null
                        : () async {
                            final rate = double.tryParse(
                              _rateController.text.trim(),
                            );
                            final success = await ref
                                .read(campaignActionControllerProvider.notifier)
                                .submitApplication(
                                  campaignId: campaign.id,
                                  creatorId: creatorId,
                                  pitch: _pitchController.text.trim(),
                                  proposedRate: rate,
                                  currency: campaign.currency,
                                );
                            if (success && ctx.mounted) {
                              Navigator.of(ctx).pop();
                            }
                            if (success && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Application submitted successfully!',
                                  ),
                                ),
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final campaignAsync = ref.watch(campaignDetailProvider(widget.campaignId));
    final accountId = ref.watch(sessionProvider).snapshot?.account.id;
    final userRole = ref
        .watch(sessionProvider)
        .snapshot
        ?.account
        .primaryRoleLabel;

    return campaignAsync.when(
      loading: () => const Scaffold(body: Center(child: AppLoader())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Campaign Detail')),
        body: Center(
          child: AppErrorState(
            message: e.toString(),
            onRetry: () =>
                ref.invalidate(campaignDetailProvider(widget.campaignId)),
          ),
        ),
      ),
      data: (campaign) {
        final isCreator = userRole == ProfessionalRole.creator;
        final isLive = campaign.status == CampaignStatus.live;
        final hasPassedDeadline =
            campaign.applicationDeadline != null &&
            campaign.applicationDeadline!.isBefore(DateTime.now());

        return Scaffold(
          appBar: AppBar(title: Text(campaign.title)),
          bottomNavigationBar: isCreator && isLive
              ? Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: hasPassedDeadline
                      ? const OutlinedButton(
                          onPressed: null,
                          child: Text('Application Deadline Closed'),
                        )
                      : AppButton(
                          label: 'Apply for Campaign',
                          onPressed: accountId == null
                              ? null
                              : () => _showApplyDialog(campaign, accountId),
                        ),
                )
              : null,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand Header Card
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                              child: Text(
                                campaign.brandName != null &&
                                        campaign.brandName!.isNotEmpty
                                    ? campaign.brandName![0].toUpperCase()
                                    : 'B',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    campaign.brandName ?? 'Brand',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Status: ${campaign.status.label}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          campaign.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (campaign.objective != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Objective: ${campaign.objective!}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Description
                _buildSectionHeader('Campaign Description'),
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      campaign.description,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Compensation
                _buildSectionHeader('Compensation'),
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Type',
                              style: TextStyle(color: AppColors.muted),
                            ),
                            Text(
                              campaign.compensationType.label,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (campaign.budgetMin != null ||
                            campaign.budgetMax != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Budget',
                                style: TextStyle(color: AppColors.muted),
                              ),
                              Text(
                                '₹${campaign.budgetMin?.toStringAsFixed(0) ?? '0'} - ₹${campaign.budgetMax?.toStringAsFixed(0) ?? '0'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (campaign.barterDescription != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Product Barter',
                                style: TextStyle(color: AppColors.muted),
                              ),
                              Expanded(
                                child: Text(
                                  campaign.barterDescription!,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Deliverables
                _buildSectionHeader(
                  'Required Deliverables (${campaign.deliverables.length})',
                ),
                if (campaign.deliverables.isEmpty)
                  const AppCard(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Text('No specific deliverables listed.'),
                    ),
                  )
                else
                  ...campaign.deliverables.map(
                    (d) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: AppCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            '${d.deliverableType.label} (x${d.quantity})',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Platform: ${d.platform}${d.description != null ? ' • ${d.description}' : ''}',
                          ),
                          trailing: const Icon(
                            Icons.check_circle_outline,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),

                // Creator Requirements
                _buildSectionHeader('Creator Requirements'),
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        _buildRow(
                          'Target Location',
                          '${campaign.targetCity ?? 'Any City'}, ${campaign.targetState ?? campaign.targetCountry}',
                        ),
                        _buildRow(
                          'Slots Available',
                          '${campaign.creatorSlots} Creators',
                        ),
                        _buildRow(
                          'Categories',
                          campaign.categoryNames.isNotEmpty
                              ? campaign.categoryNames.join(', ')
                              : 'Open to all',
                        ),
                        _buildRow(
                          'Languages',
                          campaign.languageNames.isNotEmpty
                              ? campaign.languageNames.join(', ')
                              : 'Open to all',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Usage Rights & Approval
                _buildSectionHeader('Usage Rights & Terms'),
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        _buildRow(
                          'Organic Reposting',
                          campaign.usageRights.organicRepostingAllowed
                              ? 'Yes'
                              : 'No',
                        ),
                        _buildRow(
                          'Paid Ad Usage',
                          campaign.usageRights.paidUsageRequired
                              ? 'Paid Ad Usage Required'
                              : 'No',
                        ),
                        _buildRow(
                          'Whitelisting',
                          campaign.usageRights.whitelistingRequired
                              ? 'Required'
                              : 'No',
                        ),
                        _buildRow(
                          'Content Approval',
                          campaign.usageRights.contentApprovalRequired
                              ? 'Required before posting'
                              : 'Not required',
                        ),
                        _buildRow(
                          'Paid Partnership Tag',
                          campaign.usageRights.disclosureRequired
                              ? 'Mandatory'
                              : 'Optional',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Deadlines & Timeline
                _buildSectionHeader('Timeline'),
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        _buildRow(
                          'Application Deadline',
                          _formatDateTime(campaign.applicationDeadline),
                        ),
                        _buildRow(
                          'Content Due Date',
                          _formatDateTime(campaign.contentDeadline),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.xs,
        left: AppSpacing.xs,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dt) {
    if (dt == null) return 'Flexible';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
