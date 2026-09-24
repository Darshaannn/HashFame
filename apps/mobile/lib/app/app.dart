import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/design_system/tokens.dart';
import 'providers.dart';
import 'router.dart';

class FoundationApp extends ConsumerWidget {
  const FoundationApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    title: ref.watch(configProvider).name,
    theme: buildAppTheme(),
    debugShowCheckedModeBanner: false,
    routerConfig: ref.watch(routerProvider),
  );
}
