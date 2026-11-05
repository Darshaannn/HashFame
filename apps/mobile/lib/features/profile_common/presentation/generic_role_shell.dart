import 'package:flutter/material.dart';

import 'package:ggs_mobile/core/design_system/tokens.dart';

class GenericRoleShell extends StatelessWidget {
  const GenericRoleShell({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onNavigationIndexChanged,
    required this.destinations,
    this.topBanner,
  });

  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChanged;
  final List<NavigationDestination> destinations;
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
        destinations: destinations,
      ),
    );
  }
}
