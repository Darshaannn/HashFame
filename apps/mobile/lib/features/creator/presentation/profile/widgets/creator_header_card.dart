import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/profile_common/domain/verification.dart';

class CreatorHeaderCard extends StatelessWidget {
  const CreatorHeaderCard({
    super.key,
    required this.profile,
    this.onEditPressed,
  });

  final CreatorProfile profile;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    final name = profile.displayName.isEmpty ? 'Creator' : profile.displayName;
    final profName = profile.professionalName;
    final isVerified =
        profile.verificationSummary.identityStatus ==
        FieldVerificationStatus.verified;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppAvatar(label: name),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: AppTypography.heading,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ],
                      ],
                    ),
                    if (profName != null &&
                        profName.isNotEmpty &&
                        profName != name)
                      Text(
                        'aka $profName',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 4),
                    AppBadge(label: profile.availability.status.label),
                  ],
                ),
              ),
              if (onEditPressed != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit Profile',
                  onPressed: onEditPressed,
                ),
            ],
          ),
          if (profile.isRepresented) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  Icons.business_center_outlined,
                  size: 16,
                  color: AppColors.muted,
                ),
                const SizedBox(width: 4),
                Text(
                  'Represented by Talent Agency',
                  style: TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
