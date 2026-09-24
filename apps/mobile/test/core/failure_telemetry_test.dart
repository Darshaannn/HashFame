import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/core/telemetry/analytics_service.dart';

class RecordingTelemetry implements AnalyticsService {
  bool throwOnDelivery = false;
  final events = <AnalyticsEvent>[];
  final failures = <AppFailure>[];

  @override
  Future<void> event(AnalyticsEvent event) async {
    if (throwOnDelivery) throw StateError('provider unavailable');
    events.add(event);
  }

  @override
  Future<void> failure(AppFailure failure, {bool fatal = false}) async {
    if (throwOnDelivery) throw StateError('provider unavailable');
    failures.add(failure);
  }

  @override
  Future<T> trace<T>(String name, Future<T> Function() operation) =>
      operation();
}

void main() {
  test('failure mapping distinguishes network and timeout paths', () {
    expect(
      mapFailure(const SocketException('offline')).kind,
      FailureKind.network,
    );
    expect(mapFailure(TimeoutException('late')).kind, FailureKind.timeout);
    expect(
      mapFailure(const FormatException('bad payload')).kind,
      FailureKind.server,
    );
  });

  test('unknown user message exposes only a correlation reference', () {
    final failure = mapFailure(Exception('database-password=secret'));
    expect(failure.message, isNot(contains('database-password')));
    expect(failure.message, contains(failure.correlationId));
  });

  test('analytics names are stable, lowercase and parameter-free', () {
    final names = AnalyticsEvent.values.map((event) => event.wire).toList();
    expect(names.toSet(), hasLength(names.length));
    for (final name in names) {
      expect(name, matches(RegExp(r'^[a-z][a-z0-9_]*$')));
    }
  });

  test('telemetry delivery failure never breaks the product flow', () async {
    final delegate = RecordingTelemetry()..throwOnDelivery = true;
    final safe = SafeAnalyticsService(delegate);

    await expectLater(safe.event(AnalyticsEvent.appOpen), completes);
    await expectLater(safe.failure(AppFailure(FailureKind.network)), completes);
    expect(await safe.trace('account_load', () async => 42), 42);
  });
}
