import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// NavigationHistoryManager manages an intelligent stack of visited routes so that
/// Android system Back and in-app Back arrow consistently walk back
/// the user's journey across tabs and subpages before prompting to exit.
class NavigationHistoryManager with ChangeNotifier {
  NavigationHistoryManager._();
  static final NavigationHistoryManager instance = NavigationHistoryManager._();

  final List<String> _history = [];

  List<String> get history => List.unmodifiable(_history);

  bool get canPop => _history.length > 1;

  String? get currentPath => _history.isNotEmpty ? _history.last : null;

  String? get previousPath => _history.length > 1 ? _history[_history.length - 2] : null;

  /// Records a path in navigation history. Avoids duplicate adjacent entries.
  void record(String path) {
    if (path.isEmpty) return;
    if (_history.isNotEmpty && _history.last == path) return;
    _history.add(path);
    notifyListeners();
  }

  /// Removes the current path and returns the previous path, or null if cannot pop.
  String? pop() {
    if (_history.length > 1) {
      _history.removeLast();
      notifyListeners();
      return _history.last;
    }
    return null;
  }

  /// Resets the history with an initial root path.
  void resetTo(String rootPath) {
    _history.clear();
    _history.add(rootPath);
    notifyListeners();
  }

  /// Clears the history stack.
  void clear() {
    _history.clear();
    notifyListeners();
  }

  /// Checks if a path is considered a role or demo root screen.
  static bool isRootPath(String path) {
    return path == '/demo' ||
        path == '/welcome' ||
        path == '/roles' ||
        path == '/home/creator' ||
        path == '/home/brand_marketer' ||
        path == '/home/agency' ||
        path == '/home/talent_manager' ||
        path == '/home/admin';
  }

  /// Helper to handle back navigation logic across the app.
  /// Returns true if navigation was handled (popped stack or previous tab/screen),
  /// or false if at root and exit confirmation is needed.
  static Future<bool> handleBack(BuildContext context, {String? fallbackPath}) async {
    // 1. If an active modal, dialog or pushed Navigator route can pop, pop it first!
    final nav = Navigator.maybeOf(context);
    if (nav != null && nav.canPop()) {
      nav.pop();
      return true;
    }

    String? currentLoc;
    try {
      currentLoc = GoRouterState.of(context).uri.path;
    } catch (_) {
      // In standalone widget tests where GoRouter is not set up
    }

    // 2. If history stack has previous screens, pop and navigate to previous screen
    while (instance._history.isNotEmpty) {
      final last = instance._history.last;
      if (currentLoc != null && last == currentLoc) {
        instance._history.removeLast();
      } else {
        break;
      }
    }

    if (instance.canPop || instance._history.isNotEmpty) {
      final prev = instance._history.isNotEmpty ? instance._history.removeLast() : null;
      if (prev != null && prev != currentLoc && context.mounted) {
        instance.notifyListeners();
        context.go(prev);
        return true;
      }
    }

    // 3. If fallbackPath is provided and not already on it
    if (fallbackPath != null && fallbackPath != currentLoc && context.mounted) {
      context.go(fallbackPath);
      return true;
    }

    // 4. We are at the root level! Show Exit confirmation
    if (context.mounted) {
      final shouldExit = await showExitConfirmation(context);
      if (shouldExit) {
        SystemNavigator.pop();
      }
      return true; // We handled the back event
    }

    return false;
  }

  /// Shows the standard "Exit GGs?" confirmation dialog with Cancel and Exit.
  static Future<bool> showExitConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Exit GGs?'),
        content: const Text('Are you sure you want to exit the application?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

/// Route observer to record navigation transitions in NavigationHistoryManager
class NavigationHistoryObserver extends NavigatorObserver {
  NavigationHistoryObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final name = route.settings.name;
    if (name != null && name.startsWith('/')) {
      NavigationHistoryManager.instance.record(name);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final name = newRoute?.settings.name;
    if (name != null && name.startsWith('/')) {
      NavigationHistoryManager.instance.record(name);
    }
  }
}

/// Global Root Back Guard wrapping MaterialApp router to provide unified system Back &
/// in-app Back handling, including "Exit GGs?" confirmation only at the root screen.
class RootNavigationGuard extends StatelessWidget {
  const RootNavigationGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await NavigationHistoryManager.handleBack(context);
      },
      child: child,
    );
  }
}
