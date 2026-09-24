import 'package:flutter/material.dart';

import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/reference_data.dart';

class CategoryMultiSelectPicker extends StatefulWidget {
  const CategoryMultiSelectPicker({
    super.key,
    required this.categories,
    required this.selectedCategoryIds,
    required this.onChanged,
    this.primaryCategoryId,
    this.onPrimaryChanged,
    this.maxSelections = 5,
    this.showPrimarySelector = false,
  });

  final List<Category> categories;
  final Set<String> selectedCategoryIds;
  final ValueChanged<Set<String>> onChanged;
  final String? primaryCategoryId;
  final ValueChanged<String?>? onPrimaryChanged;
  final int maxSelections;
  final bool showPrimarySelector;

  @override
  State<CategoryMultiSelectPicker> createState() => _CategoryMultiSelectPickerState();
}

class _CategoryMultiSelectPickerState extends State<CategoryMultiSelectPicker> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredCategories = widget.categories.where((c) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      final matchName = c.name.toLowerCase().contains(query);
      final matchSub = c.subcategories.any((sub) => sub.name.toLowerCase().contains(query));
      return matchName || matchSub;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSearchField(
          onChanged: (val) => setState(() => _searchQuery = val),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Selected ${widget.selectedCategoryIds.length} of max ${widget.maxSelections}',
          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filteredCategories.map((cat) {
            final isSelected = widget.selectedCategoryIds.contains(cat.id);
            final isPrimary = widget.primaryCategoryId == cat.id;

            return AppChip(
              label: isPrimary ? '${cat.name} (Primary)' : cat.name,
              selected: isSelected,
              onSelected: (selected) {
                final updated = Set<String>.from(widget.selectedCategoryIds);
                if (selected) {
                  if (updated.length >= widget.maxSelections) return;
                  updated.add(cat.id);
                  if (updated.length == 1 && widget.onPrimaryChanged != null) {
                    widget.onPrimaryChanged!(cat.id);
                  }
                } else {
                  updated.remove(cat.id);
                  if (isPrimary && widget.onPrimaryChanged != null) {
                    widget.onPrimaryChanged!(updated.isNotEmpty ? updated.first : null);
                  }
                }
                widget.onChanged(updated);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
