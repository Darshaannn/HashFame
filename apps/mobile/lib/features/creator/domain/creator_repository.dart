import '../domain/collaboration.dart';
import '../domain/creator_manager.dart';
import '../domain/creator_profile.dart';
import '../domain/portfolio.dart';
import '../domain/rate_card.dart';
import '../domain/social_account.dart';

abstract interface class CreatorRepository {
  Future<CreatorProfile> getProfile({String? userId});
  Future<CreatorProfile> updateProfile(CreatorProfile profile);
  Future<CreatorProfile> updateOnboardingStep(int step, bool completed);
  Future<CreatorProfile> updateAvailability(CreatorAvailability availability);

  // Categories & Languages
  Future<void> setCategories({
    required List<String> categoryIds,
    String? primaryCategoryId,
  });
  Future<void> setLanguages({
    required List<String> languageCodes,
    String? primaryLanguageCode,
  });

  // Social accounts
  Future<SocialAccount> addSocialAccount(SocialAccount account);
  Future<void> updateSocialAccount(SocialAccount account);
  Future<void> deleteSocialAccount(String id);

  // Rate card
  Future<RateItem> addRateItem(RateItem item);
  Future<void> updateRateItem(RateItem item);
  Future<void> deleteRateItem(String id);

  // Portfolio
  Future<PortfolioItem> addPortfolioItem(PortfolioItem item);
  Future<void> updatePortfolioItem(PortfolioItem item);
  Future<void> deletePortfolioItem(String id);

  // Past collaborations
  Future<PastCollaboration> addCollaboration(PastCollaboration collab);
  Future<void> updateCollaboration(PastCollaboration collab);
  Future<void> deleteCollaboration(String id);

  // Manager relationships
  Future<List<CreatorManagerRelationship>> getManagerRelationships();
  Future<void> respondToManagerRequest(
    String relationshipId,
    ManagerRelationshipStatus status,
  );
}

abstract interface class CreatorDataSource {
  String? get userId;
  Future<CreatorProfile> getProfile({String? userId});
  Future<CreatorProfile> updateProfile(CreatorProfile profile);
  Future<CreatorProfile> updateOnboardingStep(int step, bool completed);
  Future<CreatorProfile> updateAvailability(CreatorAvailability availability);
  Future<void> setCategories({
    required List<String> categoryIds,
    String? primaryCategoryId,
  });
  Future<void> setLanguages({
    required List<String> languageCodes,
    String? primaryLanguageCode,
  });

  Future<SocialAccount> addSocialAccount(SocialAccount account);
  Future<void> updateSocialAccount(SocialAccount account);
  Future<void> deleteSocialAccount(String id);

  Future<RateItem> addRateItem(RateItem item);
  Future<void> updateRateItem(RateItem item);
  Future<void> deleteRateItem(String id);

  Future<PortfolioItem> addPortfolioItem(PortfolioItem item);
  Future<void> updatePortfolioItem(PortfolioItem item);
  Future<void> deletePortfolioItem(String id);

  Future<PastCollaboration> addCollaboration(PastCollaboration collab);
  Future<void> updateCollaboration(PastCollaboration collab);
  Future<void> deleteCollaboration(String id);

  Future<List<CreatorManagerRelationship>> getManagerRelationships();
  Future<void> respondToManagerRequest(
    String relationshipId,
    ManagerRelationshipStatus status,
  );
}
