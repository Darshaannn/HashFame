import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/core/telemetry/analytics_service.dart';
import 'package:ggs_mobile/features/creator/domain/collaboration.dart';
import 'package:ggs_mobile/features/creator/domain/creator_manager.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/portfolio.dart';
import 'package:ggs_mobile/features/creator/domain/profile_completion.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data.dart';

final creatorProfileProvider = FutureProvider.autoDispose
    .family<CreatorProfile, String?>((ref, userId) async {
      final repo = ref.watch(creatorRepositoryProvider);
      return repo.getProfile(userId: userId);
    });

final currentCreatorProfileProvider =
    FutureProvider.autoDispose<CreatorProfile>((ref) async {
      final repo = ref.watch(creatorRepositoryProvider);
      return repo.getProfile();
    });

final profileCompletionProvider = Provider.autoDispose
    .family<ProfileCompletionReport?, CreatorProfile?>((ref, profile) {
      if (profile == null) return null;
      return ProfileCompletionCalculator.calculate(profile);
    });

final referenceCategoriesProvider = FutureProvider.autoDispose<List<Category>>((
  ref,
) async {
  final repo = ref.watch(referenceDataRepositoryProvider);
  return repo.getCategories();
});

final referenceLanguagesProvider = FutureProvider.autoDispose<List<Language>>((
  ref,
) async {
  final repo = ref.watch(referenceDataRepositoryProvider);
  return repo.getLanguages();
});

final creatorControllerProvider =
    NotifierProvider<CreatorController, AsyncValue<void>>(
      CreatorController.new,
    );

class CreatorController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> _run(Future<void> Function() action) async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    try {
      await action();
      if (ref.mounted) state = const AsyncData(null);
    } catch (error, stack) {
      if (ref.mounted) state = AsyncError(mapFailure(error), stack);
    }
  }

  Future<void> updateBasicProfile({
    String? professionalName,
    String? bio,
    String? city,
    String? state,
    String? country,
  }) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    final current = await repo.getProfile();
    final updated = current.copyWith(
      professionalName: professionalName ?? current.professionalName,
      bio: bio ?? current.bio,
      location: current.location.copyWith(
        city: city ?? current.location.city,
        state: state ?? current.location.state,
        country: country ?? current.location.country,
      ),
    );
    await repo.updateProfile(updated);
    ref.invalidate(currentCreatorProfileProvider);
    await ref
        .read(analyticsProvider)
        .event(AnalyticsEvent.creatorProfileUpdated);
  });

  Future<void> updateAvailability(CreatorAvailability availability) =>
      _run(() async {
        final repo = ref.read(creatorRepositoryProvider);
        await repo.updateAvailability(availability);
        ref.invalidate(currentCreatorProfileProvider);
        await ref
            .read(analyticsProvider)
            .event(AnalyticsEvent.availabilityChanged);
      });

  Future<void> saveCategories({
    required List<String> categoryIds,
    String? primaryId,
  }) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.setCategories(
      categoryIds: categoryIds,
      primaryCategoryId: primaryId,
    );
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> saveLanguages({
    required List<String> languageCodes,
    String? primaryCode,
  }) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.setLanguages(
      languageCodes: languageCodes,
      primaryLanguageCode: primaryCode,
    );
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> addSocialAccount(SocialAccount account) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.addSocialAccount(account);
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> deleteSocialAccount(String id) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.deleteSocialAccount(id);
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> addRateItem(RateItem item) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.addRateItem(item);
    ref.invalidate(currentCreatorProfileProvider);
    await ref.read(analyticsProvider).event(AnalyticsEvent.rateCardAdded);
  });

  Future<void> updateRateItem(RateItem item) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.updateRateItem(item);
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> deleteRateItem(String id) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.deleteRateItem(id);
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> addPortfolioItem(PortfolioItem item) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.addPortfolioItem(item);
    ref.invalidate(currentCreatorProfileProvider);
    await ref.read(analyticsProvider).event(AnalyticsEvent.portfolioItemAdded);
  });

  Future<void> deletePortfolioItem(String id) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.deletePortfolioItem(id);
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> addCollaboration(PastCollaboration collab) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.addCollaboration(collab);
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> deleteCollaboration(String id) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.deleteCollaboration(id);
    ref.invalidate(currentCreatorProfileProvider);
  });

  Future<void> respondToManagerRequest(
    String relationshipId,
    ManagerRelationshipStatus status,
  ) => _run(() async {
    final repo = ref.read(creatorRepositoryProvider);
    await repo.respondToManagerRequest(relationshipId, status);
    ref.invalidate(currentCreatorProfileProvider);
  });
}
