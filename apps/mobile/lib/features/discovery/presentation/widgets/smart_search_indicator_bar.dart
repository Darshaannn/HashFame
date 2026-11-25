import 'package:flutter/material.dart';

import '../../../../core/design_system/tokens.dart';
import '../../domain/parsed_search_criteria.dart';

class SmartSearchIndicatorBar extends StatelessWidget {
  const SmartSearchIndicatorBar({
    super.key,
    required this.criteria,
    required this.onClearFilter,
  });

  final ParsedSearchCriteria criteria;
  final ValueChanged<String> onClearFilter;

  @override
  Widget build(BuildContext context) {
    if (!criteria.hasStructuredFilters &&
        criteria.unsupportedConditions.isEmpty) {
      return const SizedBox.shrink();
    }

    final chips = <Widget>[];

    if (criteria.category != null) {
      chips.add(
        _buildChip(
          label: criteria.category!,
          icon: Icons.category_outlined,
          onDeleted: () => onClearFilter('category'),
        ),
      );
    }

    if (criteria.city != null) {
      chips.add(
        _buildChip(
          label: criteria.city!,
          icon: Icons.location_on_outlined,
          onDeleted: () => onClearFilter('city'),
        ),
      );
    }

    if (criteria.tier != null) {
      chips.add(
        _buildChip(
          label: criteria.tier!.label,
          icon: Icons.groups_outlined,
          onDeleted: () => onClearFilter('tier'),
        ),
      );
    } else if (criteria.minFollowers != null || criteria.maxFollowers != null) {
      String followLabel = '';
      if (criteria.minFollowers != null && criteria.maxFollowers != null) {
        followLabel =
            '${_fmt(criteria.minFollowers!)} - ${_fmt(criteria.maxFollowers!)}';
      } else if (criteria.minFollowers != null) {
        followLabel = '>${_fmt(criteria.minFollowers!)}';
      } else if (criteria.maxFollowers != null) {
        followLabel = '<${_fmt(criteria.maxFollowers!)}';
      }
      chips.add(
        _buildChip(
          label: '$followLabel followers',
          icon: Icons.people_outline,
          onDeleted: () => onClearFilter('followers'),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.burgundy,
              ),
              const SizedBox(width: 6),
              Text(
                'Interpreted Search Intent',
                style: TextStyle(
                  fontFamily: AppTypography.khandFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.burgundy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(spacing: 6, runSpacing: 4, children: chips),
          if (criteria.unsupportedConditions.isNotEmpty) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.warningLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 14,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      criteria.unsupportedConditions.join(' · '),
                      style: const TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontSize: 11,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required VoidCallback onDeleted,
  }) {
    return InputChip(
      avatar: Icon(icon, size: 14, color: AppColors.burgundy),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: AppTypography.hindFont,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColors.lightGray,
      deleteIcon: const Icon(Icons.close, size: 12),
      onDeleted: onDeleted,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  static String _fmt(int count) {
    if (count >= 10000000) return '${(count / 10000000).toStringAsFixed(1)}Cr';
    if (count >= 100000) return '${(count / 100000).toStringAsFixed(0)}L';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(0)}K';
    return count.toString();
  }
}
