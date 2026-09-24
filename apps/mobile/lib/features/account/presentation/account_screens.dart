import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../core/config/app_config.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../core/errors/app_failure.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/account.dart';
import 'account_controller.dart';

class ActionError extends ConsumerWidget {
  const ActionError({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(accountActionProvider);
    return action.hasError
        ? AppErrorState(message: mapFailure(action.error!).message)
        : const SizedBox.shrink();
  }
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final name = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(selectedRoleProvider);
    final busy = ref.watch(accountActionProvider).isLoading;
    return AppScaffold(
      title: 'Complete your profile',
      children: [
        const Text('Confirm your role and name', style: AppTypography.heading),
        const Text(
          'Choose the role that fits your work. Your private account details stay private.',
        ),
        Wrap(
          spacing: 8,
          children: [
            for (final option in ProfessionalRole.values.where(
              (r) => r.canSelfRegister,
            ))
              AppChip(
                label: option.label,
                selected: role == option,
                onSelected: busy
                    ? null
                    : (_) => ref
                          .read(selectedRoleProvider.notifier)
                          .choose(option),
              ),
          ],
        ),
        Form(
          key: form,
          child: AppTextField(
            label: 'Display name',
            controller: name,
            validator: validateName,
            maxLength: 80,
            enabled: !busy,
          ),
        ),
        const ActionError(),
        AppButton(
          label: 'Finish setup',
          busy: busy,
          onPressed: role == null
              ? null
              : () {
                  if (form.currentState!.validate()) {
                    ref
                        .read(accountActionProvider.notifier)
                        .onboard(name.text, role);
                  }
                },
        ),
        TextButton(
          onPressed: busy
              ? null
              : () => ref.read(accountActionProvider.notifier).logout(),
          child: const Text('Sign out'),
        ),
      ],
    );
  }
}

class RoleHomeScreen extends ConsumerWidget {
  const RoleHomeScreen({super.key, required this.role});
  final ProfessionalRole role;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final snapshot = session.snapshot;
    if (snapshot == null) {
      return const AppScaffold(title: 'Account', children: [AppSkeleton()]);
    }
    final account = snapshot.account;
    return AppScaffold(
      title: '${role.label} home',
      children: [
        AppAvatar(label: account.displayName),
        Text('Hello, ${account.displayName}', style: AppTypography.title),
        AppBadge(label: role.label),
        if (snapshot.offline)
          AppCard(
            child: Text(
              'Offline • Last updated ${snapshot.fetchedAt.toLocal()}\nShowing your saved profile. Reconnect to make changes.',
            ),
          ),
        AppEmptyState(
          title: 'Your account is ready',
          message: switch (role) {
            ProfessionalRole.creator =>
              'Your creator profile foundation is in place.',
            ProfessionalRole.brandMarketer =>
              'Organization association will be available in a later phase.',
            ProfessionalRole.agency =>
              'Agency organization setup will be available in a later phase.',
            ProfessionalRole.talentManager =>
              'Your manager profile is ready. Creator linking comes later.',
            ProfessionalRole.admin => 'Your server-assigned operator identity is active. Administration tools are reserved for the next phase.',
          },
        ),
        OutlinedButton(
          onPressed: () => context.go('/profile'),
          child: const Text('View profile'),
        ),
        AppButton(
          label: 'Account settings',
          onPressed: snapshot.offline ? null : () => context.go('/settings'),
        ),
        OutlinedButton(
          onPressed: () => ref.read(sessionProvider.notifier).refresh(),
          child: const Text('Refresh account'),
        ),
        if (ref.watch(configProvider).environment != AppEnvironment.production)
          TextButton(
            onPressed: () => context.go('/gallery'),
            child: const Text('Component gallery'),
          ),
        const ActionError(),
        TextButton(
          onPressed: ref.watch(accountActionProvider).isLoading
              ? null
              : () => ref.read(accountActionProvider.notifier).logout(),
          child: const Text('Sign out'),
        ),
      ],
    );
  }
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(sessionProvider).snapshot;
    if (snapshot == null) {
      return const AppScaffold(title: 'Profile', children: [AppSkeleton()]);
    }
    final account = snapshot.account;
    return AppScaffold(
      title: 'Profile',
      children: [
        Row(
          children: [
            AppAvatar(label: account.displayName),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.displayName, style: AppTypography.heading),
                  Text(
                    account.primaryRoleLabel?.label ?? 'Role setup incomplete',
                  ),
                ],
              ),
            ),
          ],
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Account foundation', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              Text('Status: ${account.accountState.name}'),
              Text(
                account.avatarPath == null
                    ? 'Profile image not added'
                    : 'Profile image configured',
              ),
            ],
          ),
        ),
        if (snapshot.offline)
          const AppCard(
            child: Text(
              'Offline profile snapshot. Reconnect before making changes.',
            ),
          ),
        AppButton(
          label: 'Edit account settings',
          onPressed: snapshot.offline ? null : () => context.go('/settings'),
        ),
        TextButton(
          onPressed: () =>
              context.go('/home/${account.primaryRoleLabel!.wire}'),
          child: const Text('Back to home'),
        ),
      ],
    );
  }
}

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController name;
  final form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    name = TextEditingController(
      text: ref.read(sessionProvider).snapshot?.account.displayName,
    );
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(accountActionProvider).isLoading;
    final settings = ref.watch(settingsProvider);
    final action = ref.read(accountActionProvider.notifier);
    return AppScaffold(
      title: 'Account settings',
      children: [
        Form(
          key: form,
          child: AppTextField(
            label: 'Display name',
            controller: name,
            validator: validateName,
            maxLength: 80,
            enabled: !busy,
          ),
        ),
        AppButton(
          label: 'Save name',
          busy: busy,
          onPressed: () {
            if (form.currentState!.validate()) action.saveName(name.text);
          },
        ),
        settings.when(
          loading: () => const AppSkeleton(),
          error: (e, s) => AppErrorState(
            message: mapFailure(e).message,
            onRetry: () => ref.invalidate(settingsProvider),
          ),
          data: (value) => SwitchListTile(
            title: const Text('Product updates'),
            subtitle: const Text('Receive optional news about the product.'),
            value: value.notificationPreferences.productUpdates,
            onChanged: busy
                ? null
                : (enabled) => action.saveSettings(
                    value.copyWith(
                      notificationPreferences: value.notificationPreferences
                          .copyWith(productUpdates: enabled),
                    ),
                  ),
          ),
        ),
        const ActionError(),
        OutlinedButton(
          onPressed: busy
              ? null
              : () async {
                  final confirmed = await AppDialog.confirm(
                    context,
                    title: 'Request account deletion?',
                    message: 'This records a deletion request and restricts your account. Full deletion is handled by support; it is not immediate.',
                  );
                  if (confirmed && mounted) await action.deleteRequest();
                },
          child: const Text('Request account deletion'),
        ),
        const SupportButton(),
        TextButton(
          onPressed: busy ? null : action.logout,
          child: const Text('Sign out'),
        ),
      ],
    );
  }
}

class SupportButton extends ConsumerWidget {
  const SupportButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => TextButton(
    onPressed: () async {
      final support = ref.read(configProvider).supportUrl;
      final opened = await launchUrl(
        Uri.parse(support),
        mode: LaunchMode.externalApplication,
      );
      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Open $support to contact support.')),
        );
      }
    },
    child: const Text('Contact support'),
  );
}

class SessionStatusScreen extends ConsumerWidget {
  const SessionStatusScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    if (session.phase == SessionPhase.loading) {
      return const AppScaffold(
        title: 'Opening your account',
        children: [AppLoader()],
      );
    }
    final pendingDeletion =
        session.snapshot?.account.accountState ==
        AccountState.deletionRequested;
    return AppScaffold(
      title: 'Account status',
      children: [
        if (session.phase == SessionPhase.restricted)
          AppEmptyState(
            title: pendingDeletion
                ? 'Deletion requested'
                : 'Account restricted',
            message: pendingDeletion
                ? 'Your request was recorded. Your data has not yet been deleted. Contact support for progress.'
                : 'This account is blocked. Contact support to review your account status.',
          )
        else
          AppErrorState(
            message:
                session.failure?.message ?? 'Your account could not be loaded.',
            onRetry: () => ref.read(sessionProvider.notifier).refresh(),
          ),
        const SupportButton(),
        const ActionError(),
        TextButton(
          onPressed: ref.watch(accountActionProvider).isLoading
              ? null
              : () => ref.read(accountActionProvider.notifier).logout(),
          child: const Text('Return to sign in'),
        ),
      ],
    );
  }
}
