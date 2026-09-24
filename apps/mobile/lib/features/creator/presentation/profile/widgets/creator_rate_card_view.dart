import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';

class CreatorRateCardView extends StatelessWidget {
  const CreatorRateCardView({
    super.key,
    required this.profile,
    this.onAddPressed,
    this.onEditItemPressed,
    this.onDeleteItemPressed,
  });

  final CreatorProfile profile;
  final VoidCallback? onAddPressed;
  final ValueChanged<RateItem>? onEditItemPressed;
  final ValueChanged<String>? onDeleteItemPressed;

  @override
  Widget build(BuildContext context) {
    final activeRates = profile.rateCard.where((r) => r.isActive).toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Rate Card', style: AppTypography.heading),
              if (onAddPressed != null)
                TextButton.icon(
                  onPressed: onAddPressed,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Rate'),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (activeRates.isEmpty)
            const Text(
              'No rate items added. Defining standard rates helps brands book collaborations faster.',
              style: TextStyle(color: AppColors.muted, fontStyle: FontStyle.italic),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activeRates.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final rate = activeRates[index];
                final title = rate.customTitle?.isNotEmpty == true
                    ? rate.customTitle!
                    : rate.deliverableType.label;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: const Icon(Icons.currency_rupee, size: 18),
                  ),
                  title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: rate.description?.isNotEmpty == true
                      ? Text(rate.description!, style: const TextStyle(fontSize: 12))
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${rate.currency} ${rate.priceAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      if (onDeleteItemPressed != null)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20),
                          onPressed: () => onDeleteItemPressed!(rate.id),
                        ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
