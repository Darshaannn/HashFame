import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/profile_common/domain/verification.dart';

class CreatorSocialAccountsCard extends StatelessWidget {
  const CreatorSocialAccountsCard({
    super.key,
    required this.profile,
    this.onAddPressed,
    this.onDeletePressed,
  });

  final CreatorProfile profile;
  final VoidCallback? onAddPressed;
  final ValueChanged<String>? onDeletePressed;

  IconData _platformIcon(SocialPlatform platform) => switch (platform) {
    SocialPlatform.instagram => Icons.camera_alt_outlined,
    SocialPlatform.youtube => Icons.video_library_outlined,
    SocialPlatform.facebook => Icons.facebook,
    SocialPlatform.x => Icons.tag,
    SocialPlatform.linkedin => Icons.work_outline,
    SocialPlatform.other => Icons.link,
  };

  @override
  Widget build(BuildContext context) {
    final socials = profile.socialAccounts;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text('Social Platforms', style: AppTypography.heading),
              ),
              if (onAddPressed != null)
                TextButton.icon(
                  onPressed: onAddPressed,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Account'),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (socials.isEmpty)
            const Text(
              'No social platforms connected yet. Add your social handles to showcase your online presence.',
              style: TextStyle(
                color: AppColors.muted,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: socials.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final acc = socials[index];
                final isVerified =
                    acc.verificationStatus == FieldVerificationStatus.verified;
                final followerCount = acc.userProvidedFollowerCount;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    _platformIcon(acc.platform),
                    color: AppColors.primary,
                  ),
                  title: Row(
                    children: [
                      Flexible(
                        child: Text(
                          '@${acc.handle}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (isVerified)
                        const Icon(
                          Icons.verified,
                          color: AppColors.primary,
                          size: 16,
                        ),
                    ],
                  ),
                  subtitle: Text(
                    [
                      acc.platform.label,
                      if (followerCount != null)
                        '${_formatFollowers(followerCount)} followers (Self-Reported)',
                      acc.connectionStatus.label,
                    ].join(' • '),
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: onDeletePressed != null
                      ? IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20),
                          onPressed: () => onDeletePressed!(acc.id),
                        )
                      : null,
                );
              },
            ),
        ],
      ),
    );
  }

  String _formatFollowers(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
