import 'package:flutter/material.dart';

import '../../../core/design_system/tokens.dart';

class BrandShell extends StatelessWidget {
  const BrandShell({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onNavigationIndexChanged,
    this.topBanner,
  });

  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChanged;
  final Widget? topBanner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          ?topBanner,
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onNavigationIndexChanged,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        elevation: 0,
        height: 56,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.home, color: AppColors.burgundy, size: 22),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_search_outlined, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.person_search, color: AppColors.burgundy, size: 22),
            label: 'Creator',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.campaign, color: AppColors.burgundy, size: 22),
            label: 'Campaigns',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.bookmark, color: AppColors.burgundy, size: 22),
            label: 'Shortlists',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.person, color: AppColors.burgundy, size: 22),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
