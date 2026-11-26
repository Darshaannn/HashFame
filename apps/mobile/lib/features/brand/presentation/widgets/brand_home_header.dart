import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../demo/demo_repositories.dart';
import '../../../profile_common/presentation/widgets/account_switcher_menu.dart';

class BrandHomeHeader extends ConsumerWidget {
  const BrandHomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDemo = ref.watch(authRepositoryProvider) is DemoAuthRepository;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderGray, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // GGs. Wordmark in burgundy
            const Text(
              'GGs.',
              style: TextStyle(
                fontFamily: AppTypography.khandFont,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.burgundy,
                letterSpacing: -0.5,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 6),
            Container(height: 18, width: 1, color: AppColors.borderGray),
            const SizedBox(width: 6),

            // Role Selector Pill (interactive only in Demo Mode)
            Flexible(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: isDemo ? () => GGAccountSwitcherMenu.show(context) : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderGray, width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.swap_horiz, size: 14, color: AppColors.black),
                      SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          'BRAND / MARKETER',
                          style: TextStyle(
                            fontFamily: AppTypography.hindFont,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                            color: AppColors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 14,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (isDemo) ...[
              const SizedBox(width: 6),
              Container(height: 18, width: 1, color: AppColors.borderGray),
              const SizedBox(width: 6),
              const Text(
                'PREVIEW',
                style: TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.secondaryGray,
                ),
              ),
            ],

            const Spacer(),

            // Notification Icon
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 20),
              color: AppColors.black,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: 'Activity & Notifications',
              onPressed: () => context.push('/activity'),
            ),

            // Top-right Account Menu Button
            const SizedBox(width: 4),
            const GGAccountAvatarButton(),
          ],
        ),
      ),
    );
  }
}
