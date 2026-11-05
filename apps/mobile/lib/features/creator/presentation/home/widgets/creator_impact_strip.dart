import 'package:flutter/material.dart';

import '../../../../../core/design_system/tokens.dart';

class CreatorImpactStrip extends StatelessWidget {
  const CreatorImpactStrip({
    super.key,
    required this.collaborationsCount,
    required this.completedCount,
    this.rating = '4.9',
  });

  final int collaborationsCount;
  final int completedCount;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.burgundy,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.burgundy.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // Left Title Badge
            const Expanded(
              flex: 4,
              child: Text(
                'MY CREATOR IMPACT',
                style: TextStyle(
                  fontFamily: 'Khand',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 0.6,
                ),
              ),
            ),

            // Divider 1
            _buildDivider(),

            // Stat 1: Collaborations
            Expanded(
              flex: 3,
              child: _buildMetric(
                value: '$collaborationsCount',
                label: 'Collaborations',
              ),
            ),

            // Divider 2
            _buildDivider(),

            // Stat 2: Completed
            Expanded(
              flex: 3,
              child: _buildMetric(
                value: '$completedCount',
                label: 'Completed',
              ),
            ),

            // Divider 3
            _buildDivider(),

            // Stat 3: Avg. Rating
            Expanded(
              flex: 3,
              child: _buildRatingMetric(
                rating: rating,
                label: 'Avg. Rating',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 28,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      color: Colors.white.withValues(alpha: 0.25),
    );
  }

  Widget _buildMetric({required String value, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Khand',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Hind',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingMetric({required String rating, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              rating,
              style: const TextStyle(
                fontFamily: 'Khand',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
                height: 1.1,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.star_rounded,
              color: Colors.white,
              size: 14,
            ),
          ],
        ),
        const SizedBox(height: 1),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Hind',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

