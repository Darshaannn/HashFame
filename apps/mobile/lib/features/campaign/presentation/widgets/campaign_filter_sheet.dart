import 'package:flutter/material.dart';

import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/campaign.dart';
import '../../domain/campaign_opportunity_item.dart';

class CampaignFilterSheet extends StatefulWidget {
  const CampaignFilterSheet({
    super.key,
    required this.initialFilters,
    required this.onApply,
  });

  final CampaignSearchFilters initialFilters;
  final ValueChanged<CampaignSearchFilters> onApply;

  @override
  State<CampaignFilterSheet> createState() => _CampaignFilterSheetState();
}

class _CampaignFilterSheetState extends State<CampaignFilterSheet> {
  late CampaignCompensationType? _compensationType;
  late TextEditingController _cityController;
  late TextEditingController _stateController;

  @override
  void initState() {
    super.initState();
    _compensationType = widget.initialFilters.compensationType;
    _cityController = TextEditingController(
      text: widget.initialFilters.city ?? '',
    );
    _stateController = TextEditingController(
      text: widget.initialFilters.state ?? '',
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Campaigns',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _compensationType = null;
                      _cityController.clear();
                      _stateController.clear();
                    });
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Compensation Type Filter
            const Text(
              'Compensation Type',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: _compensationType == null,
                  onSelected: (_) => setState(() => _compensationType = null),
                ),
                ...CampaignCompensationType.values.map(
                  (type) => ChoiceChip(
                    label: Text(type.label),
                    selected: _compensationType == type,
                    onSelected: (_) => setState(() => _compensationType = type),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Location Filters
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.xs),
            AppTextField(
              controller: _cityController,
              label: 'Target City (e.g. Mumbai, Bengaluru)',
            ),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: _stateController,
              label: 'Target State (e.g. Maharashtra, Karnataka)',
            ),
            const SizedBox(height: AppSpacing.lg),

            AppButton(
              label: 'Apply Filters',
              onPressed: () {
                final updated = widget.initialFilters.copyWith(
                  compensationType: _compensationType,
                  city: _cityController.text.trim().isEmpty
                      ? null
                      : _cityController.text.trim(),
                  state: _stateController.text.trim().isEmpty
                      ? null
                      : _stateController.text.trim(),
                );
                widget.onApply(updated);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
