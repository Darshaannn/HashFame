import 'package:flutter/material.dart';

import 'tokens.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.children,
    this.actions,
  });
  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title), actions: actions),
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (final child in children)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: child,
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool busy;
  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: busy ? null : onPressed,
    child: Text(busy ? 'Please wait…' : label),
  );
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.maxLength,
    this.onChanged,
  });
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label),
    validator: validator,
    keyboardType: keyboardType,
    enabled: enabled,
    maxLength: maxLength,
    onChanged: onChanged,
    autocorrect: false,
  );
}

class AppSearchField extends StatelessWidget {
  const AppSearchField({super.key, this.onChanged});
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) => TextField(
    onChanged: onChanged,
    decoration: const InputDecoration(
      labelText: 'Search',
      prefixIcon: Icon(Icons.search),
    ),
  );
}

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
    elevation: AppElevation.flat,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.card),
      side: const BorderSide(color: AppColors.outline),
    ),
    child: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: child),
  );
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Profile avatar for $label',
    container: true,
    excludeSemantics: true,
    child: CircleAvatar(
      radius: 24,
      child: Text(label.isEmpty ? '?' : label.characters.first.toUpperCase()),
    ),
  );
}

class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(AppRadius.control),
    ),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Text(label),
    ),
  );
}

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
  });
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  @override
  Widget build(BuildContext context) => FilterChip(
    label: Text(label),
    selected: selected,
    onSelected: onSelected,
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
}

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.label = 'Loading'});
  final String label;
  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    liveRegion: true,
    child: const Padding(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Center(child: CircularProgressIndicator()),
    ),
  );
}

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key});
  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Loading content',
    child: ExcludeSemantics(
      child: Column(
        children: List.generate(
          3,
          (i) => Container(
            height: 64,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.control),
            ),
          ),
        ),
      ),
    ),
  );
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, required this.title, required this.message});
  final String title, message;
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.heading),
        const SizedBox(height: AppSpacing.sm),
        Text(message),
      ],
    ),
  );
}

class AppErrorState extends StatelessWidget {
  const AppErrorState({super.key, required this.message, this.onRetry});
  final String message;
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    ),
  );
}

class AppDialog {
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirm'),
            ),
          ],
        ),
      ) ??
      false;
}

class AppSheet {
  static Future<void> show(BuildContext context, Widget child) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              24,
              24,
              24 + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: child,
          ),
        ),
      );
}
