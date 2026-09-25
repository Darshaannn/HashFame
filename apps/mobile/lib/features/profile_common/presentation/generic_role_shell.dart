import 'package:flutter/material.dart';

import 'package:ggs_mobile/demo/demo_banner.dart';

class GenericRoleShell extends StatelessWidget {
  const GenericRoleShell({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onNavigationIndexChanged,
    required this.destinations,
  });

  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChanged;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DemoTopBanner(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onNavigationIndexChanged,
        destinations: destinations,
      ),
    );
  }
}
