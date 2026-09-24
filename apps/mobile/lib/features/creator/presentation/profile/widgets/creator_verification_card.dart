import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/profile_common/domain/verification.dart';

class CreatorVerificationCard extends StatelessWidget {
  const CreatorVerificationCard({
    super.key,
    required this.profile,
  });

  final CreatorProfile profile;

  Color _statusColor(FieldVerificationStatus status) => switch (status) {
    FieldVerificationStatus.verified => Colors.green.shade700,
    FieldVerificationStatus.pending => Colors.orange.shade800,
    FieldVerificationStatus.rejected => AppColors.error,
    FieldVerificationStatus.expired => AppColors.muted,
    FieldVerificationStatus.notStarted => AppColors.muted,
  };

  IconData _statusIcon(FieldVerificationStatus status) => switch (status) {
    FieldVerificationStatus.verified => Icons.check_circle,
    FieldVerificationStatus.pending => Icons.hourglass_top,
    FieldVerificationStatus.rejected => Icons.cancel,
    FieldVerificationStatus.expired => Icons.history,
    FieldVerificationStatus.notStarted => Icons.radio_button_unchecked,
  };

  @override
  Widget build(BuildContext context) {
    final v = profile.verificationSummary;

    final fields = [
      ('Identity / Govt ID', v.identityStatus),
      ('Email Address', v.emailStatus),
      ('Phone Number', v.phoneStatus),
      ('Social Accounts', v.socialStatus),
      ('Talent Management', v.managerStatus),
    ];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Verification Status', style: AppTypography.heading),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Field-level verification badges build verified trust with brands & agencies.',
            style: TextStyle(fontSize: 13, color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final (label, status) in fields)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_statusIcon(status), size: 16, color: _statusColor(status)),
                      const SizedBox(width: 4),
                      Text(
                        status.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _statusColor(status),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
