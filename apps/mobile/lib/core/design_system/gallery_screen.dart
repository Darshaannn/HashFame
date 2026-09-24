import 'package:flutter/material.dart';

import 'components.dart';
import 'tokens.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Component gallery',
    children: [
      const Text('Foundation components', style: AppTypography.title),
      const Text(
        'Typography scales with your device settings. Controls use at least 48 logical pixels where interactive.',
      ),
      const AppAvatar(label: 'Sample profile'),
      const AppBadge(label: 'Creator'),
      AppButton(label: 'Primary button', onPressed: () {}),
      const AppButton(label: 'Disabled button', onPressed: null),
      const AppTextField(label: 'Text input'),
      const AppSearchField(),
      AppChip(label: 'Selected chip', selected: true, onSelected: (_) {}),
      const AppCard(child: Text('Reusable card')),
      const AppSkeleton(),
      const AppLoader(label: 'Loading demonstration'),
      const AppEmptyState(
        title: 'Nothing here yet',
        message: 'New information will appear here.',
      ),
      AppErrorState(message: 'An example recoverable error.', onRetry: () {}),
      AppButton(
        label: 'Open dialog',
        onPressed: () => AppDialog.confirm(
          context,
          title: 'Example dialog',
          message: 'Dialogs support clear actions.',
        ),
      ),
      AppButton(
        label: 'Open bottom sheet',
        onPressed: () => AppSheet.show(
          context,
          const Text('Accessible bottom sheet content.'),
        ),
      ),
    ],
  );
}
