import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../account/domain/account.dart';
import '../domain/auth_repository.dart';
import 'auth_controller.dart';
import 'session_controller.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => AppScaffold(
    title: ref.watch(configProvider).name,
    children: [
      const SizedBox(height: AppSpacing.xl),
      const Text(
        'Your professional story starts here.',
        style: AppTypography.title,
      ),
      const Text(
        'Set up your account and choose how you work with creators and brands.',
      ),
      if (ref.watch(sessionProvider).failure case final failure?)
        AppErrorState(message: failure.message),
      AppButton(
        label: 'Get started or sign in',
        onPressed: () => context.go('/roles'),
      ),
    ],
  );
}

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => AppScaffold(
    title: 'Choose your role',
    children: [
      const Text('How do you work?', style: AppTypography.title),
      const Text(
        'Choose your professional role before signing in. Existing accounts keep their assigned role.',
      ),
      for (final role in ProfessionalRole.values.where(
        (r) => r.canSelfRegister,
      ))
        OutlinedButton(
          onPressed: () {
            ref.read(selectedRoleProvider.notifier).choose(role);
            ref.read(authFormProvider.notifier).reset();
            context.go('/auth');
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(role.label),
            ),
          ),
        ),
    ],
  );
}

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});
  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final email = TextEditingController();
  final otp = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authFormProvider);
    final role = ref.watch(selectedRoleProvider);
    final controller = ref.read(authFormProvider.notifier);
    return AppScaffold(
      title: 'Sign in',
      children: [
        Text(role?.label ?? 'Your account', style: AppTypography.heading),
        const Text(
          'Personal and work email addresses are welcome. We’ll send a six-digit sign-in code.',
        ),
        Form(
          key: form,
          child: Column(
            children: [
              AppTextField(
                label: 'Email address',
                controller: email,
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                enabled: !state.busy && !state.codeSent,
              ),
              if (state.codeSent) ...[
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'Verification code',
                  controller: otp,
                  validator: validateOtp,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  enabled: !state.busy,
                ),
              ],
            ],
          ),
        ),
        if (state.failure case final failure?)
          AppErrorState(message: failure.message),
        if (state.codeSent)
          const Text('Check your inbox. Codes expire after ten minutes.'),
        AppButton(
          label: state.codeSent ? 'Verify code' : 'Send sign-in code',
          busy: state.busy,
          onPressed: () {
            if (form.currentState!.validate()) {
              if (state.codeSent) {
                controller.verify(email.text, otp.text);
              } else {
                controller.sendOtp(email.text);
              }
            }
          },
        ),
        if (state.codeSent)
          TextButton(
            onPressed: state.busy
                ? null
                : () {
                    controller.reset();
                    otp.clear();
                  },
            child: const Text('Change email or request another code'),
          ),
        OutlinedButton(
          onPressed: state.busy
              ? null
              : () => controller.social(SocialProvider.google),
          child: const Text('Continue with Google'),
        ),
        if (defaultTargetPlatform == TargetPlatform.iOS)
          OutlinedButton(
            onPressed: state.busy
                ? null
                : () => controller.social(SocialProvider.apple),
            child: const Text('Continue with Apple'),
          ),
        TextButton(
          onPressed: state.busy ? null : () => context.go('/roles'),
          child: const Text('Change role'),
        ),
      ],
    );
  }
}
