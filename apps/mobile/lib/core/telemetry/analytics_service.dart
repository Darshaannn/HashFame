import 'dart:developer' as developer;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';

import '../errors/app_failure.dart';

enum AnalyticsEvent {
  appOpen,
  roleSelected,
  authStarted,
  authCompleted,
  onboardingCompleted,
  logout,
  fatalErrorScreen,
  creatorOnboardingStarted,
  creatorOnboardingCompleted,
  creatorProfileUpdated,
  rateCardAdded,
  portfolioItemAdded,
  availabilityChanged,
  brandProfileCompleted,
  creatorSearchPerformed,
  creatorFilterApplied,
  creatorProfileViewed,
  shortlistCreated,
  creatorShortlisted,
  creatorRemovedFromShortlist,
  creatorComparisonStarted,
  campaignDraftCreated,
  campaignDraftUpdated,
  campaignSubmitted,
  campaignViewed,
  campaignFilterApplied,
  campaignApplicationStarted,
  campaignApplicationSubmitted,
  campaignApplicationWithdrawn,
  applicationStatusChanged,
  campaignClosed,
}

extension EventName on AnalyticsEvent {
  String get wire => switch (this) {
    AnalyticsEvent.appOpen => 'app_open',
    AnalyticsEvent.roleSelected => 'role_selected',
    AnalyticsEvent.authStarted => 'auth_started',
    AnalyticsEvent.authCompleted => 'auth_completed',
    AnalyticsEvent.onboardingCompleted => 'onboarding_completed',
    AnalyticsEvent.logout => 'logout',
    AnalyticsEvent.fatalErrorScreen => 'fatal_error_screen',
    AnalyticsEvent.creatorOnboardingStarted => 'creator_onboarding_started',
    AnalyticsEvent.creatorOnboardingCompleted => 'creator_onboarding_completed',
    AnalyticsEvent.creatorProfileUpdated => 'creator_profile_updated',
    AnalyticsEvent.rateCardAdded => 'rate_card_added',
    AnalyticsEvent.portfolioItemAdded => 'portfolio_item_added',
    AnalyticsEvent.availabilityChanged => 'availability_changed',
    AnalyticsEvent.brandProfileCompleted => 'brand_profile_completed',
    AnalyticsEvent.creatorSearchPerformed => 'creator_search_performed',
    AnalyticsEvent.creatorFilterApplied => 'creator_filter_applied',
    AnalyticsEvent.creatorProfileViewed => 'creator_profile_viewed',
    AnalyticsEvent.shortlistCreated => 'shortlist_created',
    AnalyticsEvent.creatorShortlisted => 'creator_shortlisted',
    AnalyticsEvent.creatorRemovedFromShortlist =>
      'creator_removed_from_shortlist',
    AnalyticsEvent.creatorComparisonStarted => 'creator_comparison_started',
    AnalyticsEvent.campaignDraftCreated => 'campaign_draft_created',
    AnalyticsEvent.campaignDraftUpdated => 'campaign_draft_updated',
    AnalyticsEvent.campaignSubmitted => 'campaign_submitted',
    AnalyticsEvent.campaignViewed => 'campaign_viewed',
    AnalyticsEvent.campaignFilterApplied => 'campaign_filter_applied',
    AnalyticsEvent.campaignApplicationStarted => 'campaign_application_started',
    AnalyticsEvent.campaignApplicationSubmitted =>
      'campaign_application_submitted',
    AnalyticsEvent.campaignApplicationWithdrawn =>
      'campaign_application_withdrawn',
    AnalyticsEvent.applicationStatusChanged => 'application_status_changed',
    AnalyticsEvent.campaignClosed => 'campaign_closed',
  };
}

abstract interface class AnalyticsService {
  Future<void> event(AnalyticsEvent event);
  Future<void> failure(AppFailure failure, {bool fatal = false});
  Future<T> trace<T>(String name, Future<T> Function() operation);
}

class NoopAnalyticsService implements AnalyticsService {
  const NoopAnalyticsService();
  @override
  Future<void> event(AnalyticsEvent event) async {}
  @override
  Future<void> failure(AppFailure failure, {bool fatal = false}) async {}
  @override
  Future<T> trace<T>(String name, Future<T> Function() operation) =>
      operation();
}

class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalyticsService(this.analytics, this.crashes, this.performance);
  final FirebaseAnalytics analytics;
  final FirebaseCrashlytics crashes;
  final FirebasePerformance performance;
  // No arbitrary event parameters, raw exceptions, stack payloads or user IDs.
  @override
  Future<void> event(AnalyticsEvent event) =>
      analytics.logEvent(name: event.wire);
  @override
  Future<void> failure(AppFailure failure, {bool fatal = false}) =>
      crashes.recordError(
        failure.toString(),
        StackTrace.empty,
        fatal: fatal,
        reason: failure.kind.name,
      );
  @override
  Future<T> trace<T>(String name, Future<T> Function() operation) async {
    if (!{'account_load', 'bootstrap'}.contains(name)) {
      throw ArgumentError('Unknown performance trace');
    }
    final trace = performance.newTrace(name);
    var started = false;
    try {
      await trace.start().timeout(const Duration(seconds: 2));
      started = true;
    } catch (_) {
      developer.log('performance_start_failed', name: 'foundation');
    }
    try {
      return await operation();
    } finally {
      if (started) {
        try {
          await trace.stop().timeout(const Duration(seconds: 2));
        } catch (_) {
          developer.log('performance_stop_failed', name: 'foundation');
        }
      }
    }
  }
}

class SafeAnalyticsService implements AnalyticsService {
  SafeAnalyticsService(this.delegate);
  final AnalyticsService delegate;
  Future<void> _report(Future<void> Function() action) async {
    try {
      await action().timeout(const Duration(seconds: 2));
    } catch (_) {
      developer.log('telemetry_delivery_failed', name: 'foundation');
    }
  }

  @override
  Future<void> event(AnalyticsEvent event) =>
      _report(() => delegate.event(event));
  @override
  Future<void> failure(AppFailure failure, {bool fatal = false}) =>
      _report(() => delegate.failure(failure, fatal: fatal));
  @override
  Future<T> trace<T>(String name, Future<T> Function() operation) =>
      delegate.trace(name, operation);
}
