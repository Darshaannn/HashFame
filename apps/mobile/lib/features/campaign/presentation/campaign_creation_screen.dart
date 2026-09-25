import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/campaign.dart';
import 'campaign_controller.dart';

class CampaignCreationScreen extends ConsumerStatefulWidget {
  const CampaignCreationScreen({super.key, this.draftCampaignId});

  final String? draftCampaignId;

  @override
  ConsumerState<CampaignCreationScreen> createState() =>
      _CampaignCreationScreenState();
}

class _CampaignCreationScreenState
    extends ConsumerState<CampaignCreationScreen> {
  int _currentStep = 0;
  String? _savedCampaignId;

  // Step 1: Basics
  final _titleController = TextEditingController();
  final _objectiveController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Step 2: Requirements & Location
  final _slotsController = TextEditingController(text: '1');
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _minFollowersController = TextEditingController();

  // Step 3: Deliverables
  final List<CampaignDeliverable> _deliverables = [];

  // Step 4: Compensation
  CampaignCompensationType _compensationType = CampaignCompensationType.paid;
  final _budgetMinController = TextEditingController();
  final _budgetMaxController = TextEditingController();
  final _barterDescController = TextEditingController();

  // Step 5: Usage Rights
  bool _organicReposting = true;
  bool _paidUsage = false;
  bool _whitelisting = false;
  bool _contentApproval = true;
  bool _disclosureRequired = true;

  // Step 6: Timeline
  DateTime? _appDeadline;
  DateTime? _contentDeadline;

  @override
  void initState() {
    super.initState();
    _savedCampaignId = widget.draftCampaignId;
    if (_savedCampaignId != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _loadExistingCampaign(),
      );
    }
  }

  Future<void> _loadExistingCampaign() async {
    final campaign = await ref
        .read(campaignRepositoryProvider)
        .getCampaign(_savedCampaignId!);
    if (!mounted) return;
    setState(() {
      _titleController.text = campaign.title;
      _objectiveController.text = campaign.objective ?? '';
      _descriptionController.text = campaign.description;
      _slotsController.text = campaign.creatorSlots.toString();
      _cityController.text = campaign.targetCity ?? '';
      _stateController.text = campaign.targetState ?? '';
      _minFollowersController.text = campaign.minFollowers?.toString() ?? '';
      _compensationType = campaign.compensationType;
      _budgetMinController.text = campaign.budgetMin?.toStringAsFixed(0) ?? '';
      _budgetMaxController.text = campaign.budgetMax?.toStringAsFixed(0) ?? '';
      _barterDescController.text = campaign.barterDescription ?? '';
      _organicReposting = campaign.usageRights.organicRepostingAllowed;
      _paidUsage = campaign.usageRights.paidUsageRequired;
      _whitelisting = campaign.usageRights.whitelistingRequired;
      _contentApproval = campaign.usageRights.contentApprovalRequired;
      _disclosureRequired = campaign.usageRights.disclosureRequired;
      _appDeadline = campaign.applicationDeadline;
      _contentDeadline = campaign.contentDeadline;
      _deliverables.clear();
      _deliverables.addAll(campaign.deliverables);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _objectiveController.dispose();
    _descriptionController.dispose();
    _slotsController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _minFollowersController.dispose();
    _budgetMinController.dispose();
    _budgetMaxController.dispose();
    _barterDescController.dispose();
    super.dispose();
  }

  Future<void> _saveDraft() async {
    final accountId = ref.read(sessionProvider).snapshot?.account.id;
    if (accountId == null) return;

    final slots = int.tryParse(_slotsController.text.trim()) ?? 1;
    final budgetMin = double.tryParse(_budgetMinController.text.trim());
    final budgetMax = double.tryParse(_budgetMaxController.text.trim());
    final minFollowers = int.tryParse(_minFollowersController.text.trim());

    if (_savedCampaignId == null) {
      final created = await ref
          .read(campaignActionControllerProvider.notifier)
          .createDraft(
            organizationId: accountId,
            title: _titleController.text.trim().isEmpty
                ? 'Untitled Campaign'
                : _titleController.text.trim(),
            description: _descriptionController.text.trim().isEmpty
                ? 'Campaign description draft'
                : _descriptionController.text.trim(),
            objective: _objectiveController.text.trim().isEmpty
                ? null
                : _objectiveController.text.trim(),
            compensationType: _compensationType,
            budgetMin: budgetMin,
            budgetMax: budgetMax,
            barterDescription: _barterDescController.text.trim().isEmpty
                ? null
                : _barterDescController.text.trim(),
            creatorSlots: slots,
            targetCity: _cityController.text.trim().isEmpty
                ? null
                : _cityController.text.trim(),
            targetState: _stateController.text.trim().isEmpty
                ? null
                : _stateController.text.trim(),
            minFollowers: minFollowers,
            deliverables: _deliverables,
            usageRights: CampaignUsageRights(
              organicRepostingAllowed: _organicReposting,
              paidUsageRequired: _paidUsage,
              whitelistingRequired: _whitelisting,
              contentApprovalRequired: _contentApproval,
              disclosureRequired: _disclosureRequired,
            ),
            applicationDeadline: _appDeadline,
            contentDeadline: _contentDeadline,
          );
      if (created != null && mounted) {
        setState(() => _savedCampaignId = created.id);
      }
    } else {
      await ref
          .read(campaignActionControllerProvider.notifier)
          .updateDraft(
            campaignId: _savedCampaignId!,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            objective: _objectiveController.text.trim().isEmpty
                ? null
                : _objectiveController.text.trim(),
            compensationType: _compensationType,
            budgetMin: budgetMin,
            budgetMax: budgetMax,
            barterDescription: _barterDescController.text.trim().isEmpty
                ? null
                : _barterDescController.text.trim(),
            creatorSlots: slots,
            targetCity: _cityController.text.trim().isEmpty
                ? null
                : _cityController.text.trim(),
            targetState: _stateController.text.trim().isEmpty
                ? null
                : _stateController.text.trim(),
            minFollowers: minFollowers,
            deliverables: _deliverables,
            usageRights: CampaignUsageRights(
              organicRepostingAllowed: _organicReposting,
              paidUsageRequired: _paidUsage,
              whitelistingRequired: _whitelisting,
              contentApprovalRequired: _contentApproval,
              disclosureRequired: _disclosureRequired,
            ),
            applicationDeadline: _appDeadline,
            contentDeadline: _contentDeadline,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Campaign'),
        actions: [
          TextButton(
            onPressed: () async {
              await _saveDraft();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Draft saved successfully')),
                );
              }
            },
            child: const Text('Save Draft'),
          ),
        ],
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () async {
          if (_currentStep < 6) {
            await _saveDraft();
            if (mounted) {
              setState(() => _currentStep += 1);
            }
          } else {
            // Final submission
            await _saveDraft();
            if (_savedCampaignId != null) {
              final success = await ref
                  .read(campaignActionControllerProvider.notifier)
                  .submitForReview(_savedCampaignId!);
              if (context.mounted && success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Campaign submitted for review!'),
                  ),
                );
                context.pop();
              }
            }
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            context.pop();
          }
        },
        steps: [
          // Step 1: Basics
          Step(
            title: const Text('Step 1 of 7: Campaign Basics'),
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                AppTextField(
                  controller: _titleController,
                  label: 'Campaign Title *',
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _objectiveController,
                  label: 'Campaign Objective (Optional)',
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _descriptionController,
                  label: 'Detailed Brief & Description *',
                  maxLength: 2000,
                ),
              ],
            ),
          ),

          // Step 2: Requirements
          Step(
            title: const Text('Creator Requirements'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                AppTextField(
                  controller: _slotsController,
                  label: 'Number of Creator Slots',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _cityController,
                  label: 'Target City (Optional)',
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _stateController,
                  label: 'Target State (Optional)',
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _minFollowersController,
                  label: 'Minimum Followers (Optional)',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),

          // Step 3: Deliverables
          Step(
            title: const Text('Deliverables'),
            isActive: _currentStep >= 2,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._deliverables.asMap().entries.map(
                  (entry) => ListTile(
                    title: Text(
                      '${entry.value.quantity}x ${entry.value.deliverableType.label}',
                    ),
                    subtitle: Text(entry.value.platform),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: AppColors.error),
                      onPressed: () =>
                          setState(() => _deliverables.removeAt(entry.key)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Deliverable'),
                  onPressed: () {
                    setState(() {
                      _deliverables.add(
                        CampaignDeliverable(
                          id: 'del_${DateTime.now().millisecondsSinceEpoch}',
                          campaignId: _savedCampaignId ?? '',
                          deliverableType:
                              CampaignDeliverableType.instagramReel,
                          platform: 'Instagram',
                          quantity: 1,
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          // Step 4: Compensation
          Step(
            title: const Text('Compensation'),
            isActive: _currentStep >= 3,
            content: Column(
              children: [
                DropdownButtonFormField<CampaignCompensationType>(
                  initialValue: _compensationType,
                  decoration: const InputDecoration(
                    labelText: 'Compensation Type',
                  ),
                  items: CampaignCompensationType.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.label),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(
                    () => _compensationType =
                        val ?? CampaignCompensationType.paid,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (_compensationType != CampaignCompensationType.barter) ...[
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _budgetMinController,
                          label: 'Min Budget (₹)',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: AppTextField(
                          controller: _budgetMaxController,
                          label: 'Max Budget (₹)',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                if (_compensationType != CampaignCompensationType.paid) ...[
                  AppTextField(
                    controller: _barterDescController,
                    label: 'Barter Product Details',
                  ),
                ],
              ],
            ),
          ),

          // Step 5: Usage Rights
          Step(
            title: const Text('Usage Rights & Terms'),
            isActive: _currentStep >= 4,
            content: Column(
              children: [
                SwitchListTile(
                  title: const Text('Organic Reposting on Brand Handles'),
                  value: _organicReposting,
                  onChanged: (v) => setState(() => _organicReposting = v),
                ),
                SwitchListTile(
                  title: const Text('Paid Ad Usage Permission Required'),
                  value: _paidUsage,
                  onChanged: (v) => setState(() => _paidUsage = v),
                ),
                SwitchListTile(
                  title: const Text('Brand Whitelisting Required'),
                  value: _whitelisting,
                  onChanged: (v) => setState(() => _whitelisting = v),
                ),
                SwitchListTile(
                  title: const Text(
                    'Brand Content Approval Required Before Posting',
                  ),
                  value: _contentApproval,
                  onChanged: (v) => setState(() => _contentApproval = v),
                ),
                SwitchListTile(
                  title: const Text('Paid Partnership / Collab Tag Required'),
                  value: _disclosureRequired,
                  onChanged: (v) => setState(() => _disclosureRequired = v),
                ),
              ],
            ),
          ),

          // Step 6: Timeline
          Step(
            title: const Text('Timeline & Deadlines'),
            isActive: _currentStep >= 5,
            content: Column(
              children: [
                ListTile(
                  title: const Text('Application Deadline'),
                  subtitle: Text(
                    _appDeadline == null
                        ? 'Not set'
                        : '${_appDeadline!.day}/${_appDeadline!.month}/${_appDeadline!.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 7)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => _appDeadline = picked);
                    }
                  },
                ),
                ListTile(
                  title: const Text('Content Delivery Due Date'),
                  subtitle: Text(
                    _contentDeadline == null
                        ? 'Not set'
                        : '${_contentDeadline!.day}/${_contentDeadline!.month}/${_contentDeadline!.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 14)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => _contentDeadline = picked);
                    }
                  },
                ),
              ],
            ),
          ),

          // Step 7: Preview & Submit
          Step(
            title: const Text('Review & Submit'),
            isActive: _currentStep >= 6,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Review your campaign brief before submitting for moderation.',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _titleController.text,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Compensation: ${_compensationType.label}'),
                        Text('Deliverables: ${_deliverables.length} required'),
                        Text('Slots: ${_slotsController.text} creator(s)'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
