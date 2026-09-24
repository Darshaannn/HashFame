import 'package:supabase_flutter/supabase_flutter.dart';

import '../../profile_common/domain/reference_data.dart';
import '../../profile_common/domain/verification.dart';
import '../domain/collaboration.dart';
import '../domain/creator_manager.dart';
import '../domain/creator_profile.dart';
import '../domain/creator_repository.dart';
import '../domain/portfolio.dart';
import '../domain/rate_card.dart';
import '../domain/social_account.dart';

class SupabaseCreatorDataSource implements CreatorDataSource {
  SupabaseCreatorDataSource(this.client);
  final SupabaseClient client;

  @override
  String? get userId => client.auth.currentUser?.id;
  String get _actor => userId ?? (throw const AuthException('Session missing'));

  @override
  Future<CreatorProfile> getProfile({String? userId}) async {
    final targetId = userId ?? _actor;

    // 1. Fetch base profile & creator profile
    final profileRow = await client
        .from('profiles')
        .select('display_name, avatar_path')
        .eq('id', targetId)
        .maybeSingle();

    final creatorRow = await client
        .from('creator_profiles')
        .select()
        .eq('user_id', targetId)
        .maybeSingle();

    // 2. Fetch categories
    final catRows = await client
        .from('creator_categories')
        .select('category_id, is_primary, categories(id, parent_id, name, slug, sort_order)')
        .eq('user_id', targetId);

    final primaryCats = <Category>[];
    final additionalCats = <Category>[];
    for (final row in (catRows as List)) {
      final catData = row['categories'];
      if (catData != null) {
        final cat = Category.fromJson(Map<String, dynamic>.from(catData as Map));
        if (row['is_primary'] == true) {
          primaryCats.add(cat);
        } else {
          additionalCats.add(cat);
        }
      }
    }

    // 3. Fetch languages
    final langRows = await client
        .from('creator_languages')
        .select('language_code, is_primary, languages(code, name, native_name, sort_order)')
        .eq('user_id', targetId);

    final languages = <Language>[];
    for (final row in (langRows as List)) {
      final langData = row['languages'];
      if (langData != null) {
        languages.add(Language.fromJson(Map<String, dynamic>.from(langData as Map)));
      }
    }

    // 4. Fetch social accounts
    final socialRows = await client
        .from('creator_social_accounts')
        .select()
        .eq('user_id', targetId);
    final socials = (socialRows as List)
        .map((s) => SocialAccount.fromJson(Map<String, dynamic>.from(s as Map)))
        .toList();

    // 5. Fetch rate card
    final rateRows = await client
        .from('creator_rate_items')
        .select()
        .eq('user_id', targetId);
    final rateCard = (rateRows as List)
        .map((r) => RateItem.fromJson(Map<String, dynamic>.from(r as Map)))
        .toList();

    // 6. Fetch portfolio
    final portRows = await client
        .from('creator_portfolio_items')
        .select()
        .eq('user_id', targetId)
        .order('sort_order');
    final portfolio = (portRows as List)
        .map((p) => PortfolioItem.fromJson(Map<String, dynamic>.from(p as Map)))
        .toList();

    // 7. Fetch past collabs
    final collabRows = await client
        .from('creator_collaborations')
        .select()
        .eq('user_id', targetId);
    final collabs = (collabRows as List)
        .map((c) => PastCollaboration.fromJson(Map<String, dynamic>.from(c as Map)))
        .toList();

    // 8. Fetch manager relationships
    final managerRows = await client
        .from('creator_manager_relationships')
        .select()
        .eq('creator_id', targetId);
    final managerRels = (managerRows as List)
        .map((m) => CreatorManagerRelationship.fromJson(Map<String, dynamic>.from(m as Map)))
        .toList();

    // 9. Fetch field verifications
    final verifRows = await client
        .from('field_verifications')
        .select()
        .eq('user_id', targetId);
    final verifs = (verifRows as List)
        .map((v) => FieldVerification.fromJson(Map<String, dynamic>.from(v as Map)))
        .toList();

    var summary = const VerificationSummary();
    for (final v in verifs) {
      switch (v.subject) {
        case VerificationSubject.identity:
          summary = summary.copyWith(identityStatus: v.status);
        case VerificationSubject.email:
          summary = summary.copyWith(emailStatus: v.status);
        case VerificationSubject.phone:
          summary = summary.copyWith(phoneStatus: v.status);
        case VerificationSubject.socialAccount:
          summary = summary.copyWith(socialStatus: v.status);
        case VerificationSubject.managerRelationship:
          summary = summary.copyWith(managerStatus: v.status);
        case VerificationSubject.company:
          summary = summary.copyWith(companyStatus: v.status);
      }
    }
    summary = summary.copyWith(items: verifs);

    final displayName = profileRow?['display_name'] as String? ?? '';
    final avatarPath = profileRow?['avatar_path'] as String?;

    if (creatorRow == null) {
      return CreatorProfile(
        userId: targetId,
        displayName: displayName,
        avatarPath: avatarPath,
      );
    }

    final availabilityStatusStr = creatorRow['availability_status'] as String? ?? 'open';
    final availStatus = AvailabilityStatus.values.firstWhere(
      (s) => s.name == availabilityStatusStr,
      orElse: () => AvailabilityStatus.open,
    );

    return CreatorProfile(
      userId: targetId,
      displayName: displayName,
      professionalName: creatorRow['professional_name'] as String?,
      avatarPath: avatarPath,
      bio: creatorRow['bio'] as String?,
      location: LocationData(
        city: creatorRow['city'] as String?,
        state: creatorRow['state'] as String?,
        country: creatorRow['country'] as String? ?? 'IN',
      ),
      availability: CreatorAvailability(
        status: availStatus,
        availableFrom: creatorRow['available_from'] != null
            ? DateTime.tryParse(creatorRow['available_from'] as String)
            : null,
      ),
      isRepresented: creatorRow['is_represented'] as bool? ?? false,
      onboardingStep: creatorRow['onboarding_step'] as int? ?? 1,
      onboardingCompleted: creatorRow['onboarding_completed'] as bool? ?? false,
      primaryCategories: primaryCats,
      additionalCategories: additionalCats,
      languages: languages,
      socialAccounts: socials,
      rateCard: rateCard,
      portfolio: portfolio,
      pastCollaborations: collabs,
      managerRelationships: managerRels,
      verificationSummary: summary,
      createdAt: creatorRow['created_at'] != null
          ? DateTime.tryParse(creatorRow['created_at'] as String)
          : null,
      updatedAt: creatorRow['updated_at'] != null
          ? DateTime.tryParse(creatorRow['updated_at'] as String)
          : null,
    );
  }

  @override
  Future<CreatorProfile> updateProfile(CreatorProfile profile) async {
    final payload = {
      'user_id': _actor,
      'professional_name': profile.professionalName,
      'bio': profile.bio,
      'city': profile.location.city,
      'state': profile.location.state,
      'country': profile.location.country,
      'availability_status': profile.availability.status.name,
      'available_from': profile.availability.availableFrom?.toIso8601String().split('T').first,
      'is_represented': profile.isRepresented,
      'onboarding_step': profile.onboardingStep,
      'onboarding_completed': profile.onboardingCompleted,
    };

    await client.from('creator_profiles').upsert(payload);
    return getProfile();
  }

  @override
  Future<CreatorProfile> updateOnboardingStep(int step, bool completed) async {
    await client.from('creator_profiles').upsert({
      'user_id': _actor,
      'onboarding_step': step,
      'onboarding_completed': completed,
    });
    return getProfile();
  }

  @override
  Future<CreatorProfile> updateAvailability(CreatorAvailability availability) async {
    await client.from('creator_profiles').upsert({
      'user_id': _actor,
      'availability_status': availability.status.name,
      'available_from': availability.availableFrom?.toIso8601String().split('T').first,
    });
    return getProfile();
  }

  @override
  Future<void> setCategories({required List<String> categoryIds, String? primaryCategoryId}) async {
    await client.from('creator_categories').delete().eq('user_id', _actor);
    if (categoryIds.isNotEmpty) {
      final inserts = categoryIds.map((cid) => {
        'user_id': _actor,
        'category_id': cid,
        'is_primary': cid == primaryCategoryId,
      }).toList();
      await client.from('creator_categories').insert(inserts);
    }
  }

  @override
  Future<void> setLanguages({required List<String> languageCodes, String? primaryLanguageCode}) async {
    await client.from('creator_languages').delete().eq('user_id', _actor);
    if (languageCodes.isNotEmpty) {
      final inserts = languageCodes.map((code) => {
        'user_id': _actor,
        'language_code': code,
        'is_primary': code == primaryLanguageCode,
      }).toList();
      await client.from('creator_languages').insert(inserts);
    }
  }

  @override
  Future<SocialAccount> addSocialAccount(SocialAccount account) async {
    final res = await client.from('creator_social_accounts').insert({
      'user_id': _actor,
      'platform': account.platform.name,
      'handle': account.handle,
      'profile_url': account.profileUrl,
      'user_provided_follower_count': account.userProvidedFollowerCount,
      'connection_status': account.connectionStatus.name,
    }).select().single();
    return SocialAccount.fromJson(Map<String, dynamic>.from(res));
  }

  @override
  Future<void> updateSocialAccount(SocialAccount account) async {
    await client.from('creator_social_accounts').update({
      'platform': account.platform.name,
      'handle': account.handle,
      'profile_url': account.profileUrl,
      'user_provided_follower_count': account.userProvidedFollowerCount,
    }).eq('id', account.id).eq('user_id', _actor);
  }

  @override
  Future<void> deleteSocialAccount(String id) async {
    await client.from('creator_social_accounts').delete().eq('id', id).eq('user_id', _actor);
  }

  @override
  Future<RateItem> addRateItem(RateItem item) async {
    final res = await client.from('creator_rate_items').insert({
      'user_id': _actor,
      'deliverable_type': item.deliverableType.name,
      'custom_title': item.customTitle,
      'price_amount': item.priceAmount,
      'currency': item.currency,
      'description': item.description,
      'is_active': item.isActive,
    }).select().single();
    return RateItem.fromJson(Map<String, dynamic>.from(res));
  }

  @override
  Future<void> updateRateItem(RateItem item) async {
    await client.from('creator_rate_items').update({
      'deliverable_type': item.deliverableType.name,
      'custom_title': item.customTitle,
      'price_amount': item.priceAmount,
      'currency': item.currency,
      'description': item.description,
      'is_active': item.isActive,
    }).eq('id', item.id).eq('user_id', _actor);
  }

  @override
  Future<void> deleteRateItem(String id) async {
    await client.from('creator_rate_items').delete().eq('id', id).eq('user_id', _actor);
  }

  @override
  Future<PortfolioItem> addPortfolioItem(PortfolioItem item) async {
    final res = await client.from('creator_portfolio_items').insert({
      'user_id': _actor,
      'title': item.title,
      'description': item.description,
      'platform': item.platform?.name,
      'content_url': item.contentUrl,
      'media_path': item.mediaPath,
      'brand_name': item.brandName,
      'published_date': item.publishedDate?.toIso8601String().split('T').first,
      'content_type': item.contentType.name,
      'sort_order': item.sortOrder,
    }).select().single();
    return PortfolioItem.fromJson(Map<String, dynamic>.from(res));
  }

  @override
  Future<void> updatePortfolioItem(PortfolioItem item) async {
    await client.from('creator_portfolio_items').update({
      'title': item.title,
      'description': item.description,
      'platform': item.platform?.name,
      'content_url': item.contentUrl,
      'media_path': item.mediaPath,
      'brand_name': item.brandName,
      'published_date': item.publishedDate?.toIso8601String().split('T').first,
      'content_type': item.contentType.name,
    }).eq('id', item.id).eq('user_id', _actor);
  }

  @override
  Future<void> deletePortfolioItem(String id) async {
    await client.from('creator_portfolio_items').delete().eq('id', id).eq('user_id', _actor);
  }

  @override
  Future<PastCollaboration> addCollaboration(PastCollaboration collab) async {
    final res = await client.from('creator_collaborations').insert({
      'user_id': _actor,
      'brand_name': collab.brandName,
      'campaign_name': collab.campaignName,
      'collaboration_year': collab.collaborationYear,
      'deliverable_type': collab.deliverableType.name,
      'proof_url': collab.proofUrl,
    }).select().single();
    return PastCollaboration.fromJson(Map<String, dynamic>.from(res));
  }

  @override
  Future<void> updateCollaboration(PastCollaboration collab) async {
    await client.from('creator_collaborations').update({
      'brand_name': collab.brandName,
      'campaign_name': collab.campaignName,
      'collaboration_year': collab.collaborationYear,
      'deliverable_type': collab.deliverableType.name,
      'proof_url': collab.proofUrl,
    }).eq('id', collab.id).eq('user_id', _actor);
  }

  @override
  Future<void> deleteCollaboration(String id) async {
    await client.from('creator_collaborations').delete().eq('id', id).eq('user_id', _actor);
  }

  @override
  Future<List<CreatorManagerRelationship>> getManagerRelationships() async {
    final rows = await client
        .from('creator_manager_relationships')
        .select('*, talent_manager_profiles(company_name, profiles(display_name))')
        .eq('creator_id', _actor);
    return (rows as List).map((r) {
      final mgrProfile = r['talent_manager_profiles'];
      final displayName = mgrProfile?['profiles']?['display_name'] as String?;
      final compName = mgrProfile?['company_name'] as String?;
      return CreatorManagerRelationship.fromJson(Map<String, dynamic>.from(r as Map))
          .copyWith(managerName: displayName, managerCompany: compName);
    }).toList();
  }

  @override
  Future<void> respondToManagerRequest(String relationshipId, ManagerRelationshipStatus status) async {
    await client
        .from('creator_manager_relationships')
        .update({'status': status.name})
        .eq('id', relationshipId)
        .eq('creator_id', _actor);
  }
}

class CreatorRepositoryImpl implements CreatorRepository {
  CreatorRepositoryImpl(this.dataSource);
  final CreatorDataSource dataSource;

  @override
  Future<CreatorProfile> getProfile({String? userId}) =>
      dataSource.getProfile(userId: userId);

  @override
  Future<CreatorProfile> updateProfile(CreatorProfile profile) =>
      dataSource.updateProfile(profile);

  @override
  Future<CreatorProfile> updateOnboardingStep(int step, bool completed) =>
      dataSource.updateOnboardingStep(step, completed);

  @override
  Future<CreatorProfile> updateAvailability(CreatorAvailability availability) =>
      dataSource.updateAvailability(availability);

  @override
  Future<void> setCategories({required List<String> categoryIds, String? primaryCategoryId}) =>
      dataSource.setCategories(categoryIds: categoryIds, primaryCategoryId: primaryCategoryId);

  @override
  Future<void> setLanguages({required List<String> languageCodes, String? primaryLanguageCode}) =>
      dataSource.setLanguages(languageCodes: languageCodes, primaryLanguageCode: primaryLanguageCode);

  @override
  Future<SocialAccount> addSocialAccount(SocialAccount account) =>
      dataSource.addSocialAccount(account);

  @override
  Future<void> updateSocialAccount(SocialAccount account) =>
      dataSource.updateSocialAccount(account);

  @override
  Future<void> deleteSocialAccount(String id) =>
      dataSource.deleteSocialAccount(id);

  @override
  Future<RateItem> addRateItem(RateItem item) =>
      dataSource.addRateItem(item);

  @override
  Future<void> updateRateItem(RateItem item) =>
      dataSource.updateRateItem(item);

  @override
  Future<void> deleteRateItem(String id) =>
      dataSource.deleteRateItem(id);

  @override
  Future<PortfolioItem> addPortfolioItem(PortfolioItem item) =>
      dataSource.addPortfolioItem(item);

  @override
  Future<void> updatePortfolioItem(PortfolioItem item) =>
      dataSource.updatePortfolioItem(item);

  @override
  Future<void> deletePortfolioItem(String id) =>
      dataSource.deletePortfolioItem(id);

  @override
  Future<PastCollaboration> addCollaboration(PastCollaboration collab) =>
      dataSource.addCollaboration(collab);

  @override
  Future<void> updateCollaboration(PastCollaboration collab) =>
      dataSource.updateCollaboration(collab);

  @override
  Future<void> deleteCollaboration(String id) =>
      dataSource.deleteCollaboration(id);

  @override
  Future<List<CreatorManagerRelationship>> getManagerRelationships() =>
      dataSource.getManagerRelationships();

  @override
  Future<void> respondToManagerRequest(String relationshipId, ManagerRelationshipStatus status) =>
      dataSource.respondToManagerRequest(relationshipId, status);
}
