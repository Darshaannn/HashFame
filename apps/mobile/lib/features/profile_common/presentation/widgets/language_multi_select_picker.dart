import 'package:flutter/material.dart';

import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/reference_data.dart';

class LanguageMultiSelectPicker extends StatefulWidget {
  const LanguageMultiSelectPicker({
    super.key,
    required this.languages,
    required this.selectedLanguageCodes,
    required this.onChanged,
    this.primaryLanguageCode,
    this.onPrimaryChanged,
    this.maxSelections = 5,
  });

  final List<Language> languages;
  final Set<String> selectedLanguageCodes;
  final ValueChanged<Set<String>> onChanged;
  final String? primaryLanguageCode;
  final ValueChanged<String?>? onPrimaryChanged;
  final int maxSelections;

  @override
  State<LanguageMultiSelectPicker> createState() =>
      _LanguageMultiSelectPickerState();
}

class _LanguageMultiSelectPickerState extends State<LanguageMultiSelectPicker> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredLanguages = widget.languages.where((l) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return l.name.toLowerCase().contains(query) ||
          l.nativeName.toLowerCase().contains(query) ||
          l.code.toLowerCase().contains(query);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSearchField(onChanged: (val) => setState(() => _searchQuery = val)),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Selected ${widget.selectedLanguageCodes.length} of max ${widget.maxSelections}',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filteredLanguages.map((lang) {
            final isSelected = widget.selectedLanguageCodes.contains(lang.code);
            final isPrimary = widget.primaryLanguageCode == lang.code;

            return AppChip(
              label: isPrimary
                  ? '${lang.name} (${lang.nativeName}) - Primary'
                  : '${lang.name} (${lang.nativeName})',
              selected: isSelected,
              onSelected: (selected) {
                final updated = Set<String>.from(widget.selectedLanguageCodes);
                if (selected) {
                  if (updated.length >= widget.maxSelections) return;
                  updated.add(lang.code);
                  if (updated.length == 1 && widget.onPrimaryChanged != null) {
                    widget.onPrimaryChanged!(lang.code);
                  }
                } else {
                  updated.remove(lang.code);
                  if (isPrimary && widget.onPrimaryChanged != null) {
                    widget.onPrimaryChanged!(
                      updated.isNotEmpty ? updated.first : null,
                    );
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
