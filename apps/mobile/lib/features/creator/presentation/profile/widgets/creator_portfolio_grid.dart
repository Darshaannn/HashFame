import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/portfolio.dart';

class CreatorPortfolioGrid extends StatelessWidget {
  const CreatorPortfolioGrid({
    super.key,
    required this.profile,
    this.onAddPressed,
    this.onDeleteItemPressed,
  });

  final CreatorProfile profile;
  final VoidCallback? onAddPressed;
  final ValueChanged<String>? onDeleteItemPressed;

  @override
  Widget build(BuildContext context) {
    final portfolio = profile.portfolio;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text('Portfolio & Work', style: AppTypography.heading),
              ),
              if (onAddPressed != null)
                TextButton.icon(
                  onPressed: onAddPressed,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Work'),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (portfolio.isEmpty)
            const Text(
              'No portfolio items added yet. Showcase your top creations and viral videos to impress marketers.',
              style: TextStyle(
                color: AppColors.muted,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: portfolio.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final item = portfolio[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    child: Icon(
                      item.contentType == PortfolioContentType.video
                          ? Icons.play_circle_outline
                          : Icons.image_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    [
                      item.contentType.label,
                      if (item.brandName != null && item.brandName!.isNotEmpty)
                        'Brand: ${item.brandName}',
                      if (item.platform != null) item.platform!.label,
                    ].join(' • '),
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: onDeleteItemPressed != null
                      ? IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20),
                          onPressed: () => onDeleteItemPressed!(item.id),
                        )
                      : null,
                );
              },
            ),
        ],
      ),
    );
  }
}
