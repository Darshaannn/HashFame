import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';

class BrandWelcomeSection extends StatelessWidget {
  const BrandWelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'WELCOME BACK',
                  style: TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    color: AppColors.secondaryGray,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'GGs Studio',
                  style: AppTypography.studioTitle.copyWith(
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () => context.push('/campaigns/new'),
            icon: const Icon(Icons.add, size: 15, color: AppColors.white),
            label: const Text(
              'New campaign',
              style: TextStyle(
                fontFamily: AppTypography.hindFont,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: const Size(0, 34),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
