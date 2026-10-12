import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'tokens.dart';

class GGPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GGPageAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton,
    this.fallbackPath,
    this.bottom,
    this.elevation = 0,
    this.centerTitle = false,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? showBackButton;
  final String? fallbackPath;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final bool centerTitle;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLeading = leading;

    if (effectiveLeading == null) {
      final canPop = Navigator.of(context).canPop();
      final shouldShowBack = showBackButton ?? (canPop || fallbackPath != null);

      if (shouldShowBack) {
        effectiveLeading = Semantics(
          label: 'Back',
          button: true,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: BackButton(
              color: AppColors.deepNavy,
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else if (fallbackPath != null) {
                  context.go(fallbackPath!);
                }
              },
            ),
          ),
        );
      }
    }

    return AppBar(
      title: Text(
        title,
        style: AppTypography.heading.copyWith(
          color: AppColors.deepNavy,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: effectiveLeading,
      actions: actions,
      bottom: bottom,
      elevation: elevation,
      centerTitle: centerTitle,
      scrolledUnderElevation: 1,
      backgroundColor: AppColors.surface,
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.children,
    this.actions,
    this.bottomNavigationBar,
    this.leading,
    this.showBackButton,
    this.fallbackPath,
    this.appBar,
  });

  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Widget? leading;
  final bool? showBackButton;
  final String? fallbackPath;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:
        appBar ??
        GGPageAppBar(
          title: title,
          actions: actions,
          leading: leading,
          showBackButton: showBackButton,
          fallbackPath: fallbackPath,
        ),
    bottomNavigationBar: bottomNavigationBar,
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
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
    this.icon,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool busy;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: busy ? null : onPressed,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (busy) ...[
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Text('Please wait…'),
        ] else ...[
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(label),
        ],
      ],
    ),
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
    this.maxLines = 1,
    this.prefixIcon,
    this.onChanged,
  });
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label, prefixIcon: prefixIcon),
    validator: validator,
    keyboardType: keyboardType,
    enabled: enabled,
    maxLength: maxLength,
    maxLines: maxLines,
    onChanged: onChanged,
    autocorrect: false,
  );
}

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.onChanged,
    this.placeholder = 'Search creators, categories or cities',
    this.controller,
  });
  final ValueChanged<String>? onChanged;
  final String placeholder;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: placeholder,
      hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
      prefixIcon: const Icon(Icons.search, color: AppColors.muted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderColor,
    this.onTap,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cardContent = Card(
      color: color ?? AppColors.surfaceElevated,
      elevation: AppElevation.flat,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(
          color: borderColor ?? AppColors.outlineLight,
          width: 1,
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: cardContent,
      );
    }
    return cardContent;
  }
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.label,
    this.radius = 24,
    this.imageUrl,
    this.accentColor,
  });
  final String label;
  final double radius;
  final String? imageUrl;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = accentColor ?? _generateColor(label);
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Semantics(
      label: 'Profile avatar for $label',
      container: true,
      excludeSemantics: true,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: effectiveColor.withValues(alpha: 0.12),
          border: Border.all(color: AppColors.outlineLight, width: 1.5),
        ),
        child: ClipOval(
          child: hasImage
              ? Image.network(
                  imageUrl!,
                  width: radius * 2,
                  height: radius * 2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildFallback(effectiveColor),
                )
              : _buildFallback(effectiveColor),
        ),
      ),
    );
  }

  Widget _buildFallback(Color color) {
    return Center(
      child: Text(
        label.isEmpty ? '?' : label.characters.first.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.8,
        ),
      ),
    );
  }

  Color _generateColor(String text) {
    if (text.isEmpty) return AppColors.deepNavy;
    final hash = text.codeUnits.fold(0, (prev, elem) => prev + elem);
    final palette = [
      AppColors.deepNavy,
      AppColors.ggsGreen,
      const Color(0xFF1E40AF),
      const Color(0xFF6B21A8),
      const Color(0xFF0F766E),
      const Color(0xFFD97706),
      const Color(0xFF9D174D),
    ];
    return palette[hash % palette.length];
  }
}

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: backgroundColor ?? AppColors.accentLight,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      border: Border.all(
        color: (textColor ?? AppColors.primary).withValues(alpha: 0.2),
        width: 0.5,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor ?? AppColors.primary),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor ?? AppColors.primary,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
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
    label: Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        color: selected ? AppColors.primary : AppColors.ink,
      ),
    ),
    selected: selected,
    onSelected: onSelected,
    selectedColor: AppColors.accentLight,
    backgroundColor: Colors.white,
    checkmarkColor: AppColors.primary,
    side: BorderSide(
      color: selected ? AppColors.primary : AppColors.outlineLight,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
    ),
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
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    ),
  );
}

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, this.count = 3, this.height = 72});
  final int count;
  final double height;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Loading content',
    child: ExcludeSemantics(
      child: Column(
        children: List.generate(
          count,
          (i) => Container(
            height: height,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubtle,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(
                color: AppColors.outlineLight.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });
  final String title, message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.xl,
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubtle,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 36, color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: AppTypography.heading,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            style: const TextStyle(color: AppColors.muted, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppSpacing.md),
            FilledButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
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
      color: AppColors.errorLight,
      borderColor: AppColors.error.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.subheading.copyWith(
                    color: AppColors.error,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('Retry'),
            ),
          ],
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Text(title, style: AppTypography.heading),
          content: Text(message, style: AppTypography.body),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
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
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.lg),
          ),
        ),
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: child,
          ),
        ),
      );
}

/// Universal PopScope-backed wrapper to protect forms from accidental navigation loss.
class GGFormExitGuard extends StatelessWidget {
  const GGFormExitGuard({
    super.key,
    required this.hasUnsavedChanges,
    required this.child,
    this.title = 'Discard unsaved changes?',
    this.message = 'You have unsaved changes in this form. Leaving will discard your modifications.',
  });

  final bool hasUnsavedChanges;
  final Widget child;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await AppDialog.confirm(
          context,
          title: title,
          message: message,
        );
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop(result);
        }
      },
      child: child,
    );
  }
}

/// Premium Section Header with optional action button
class GGSectionHeader extends StatelessWidget {
  const GGSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.heading.copyWith(
                    color: AppColors.deepNavy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.ggsGreen,
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                actionLabel!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }
}

/// Visual Editorial / Hero Banner for Dashboards
class GGHeroBanner extends StatelessWidget {
  const GGHeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.tag = 'FEATURED',
    this.ctaLabel,
    this.onCtaPressed,
    this.accentColor = AppColors.ggsGreen,
    this.icon = Icons.auto_awesome,
  });

  final String title;
  final String subtitle;
  final String tag;
  final String? ctaLabel;
  final VoidCallback? onCtaPressed;
  final Color accentColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.deepNavy,
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: const LinearGradient(
          colors: [Color(0xFF14253D), Color(0xFF1C3556)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.warmAmber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                    color: AppColors.warmAmber.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: AppColors.warmAmber,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Icon(icon, color: AppColors.warmAmber, size: 22),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          if (ctaLabel != null && onCtaPressed != null) ...[
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: onCtaPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ggsGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                minimumSize: const Size(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
              ),
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: Text(
                ctaLabel!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
