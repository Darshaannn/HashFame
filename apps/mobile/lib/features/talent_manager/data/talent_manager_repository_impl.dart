import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/talent_manager_profile.dart';
import '../domain/talent_manager_repository.dart';

class SupabaseTalentManagerDataSource implements TalentManagerDataSource {
  SupabaseTalentManagerDataSource(this.client);
  final SupabaseClient client;

  @override
  String? get userId => client.auth.currentUser?.id;
  String get _actor => userId ?? (throw const AuthException('Session missing'));

  @override
  Future<TalentManagerProfile> getProfile({String? userId}) async {
    final targetId = userId ?? _actor;

    final profileRow = await client
        .from('profiles')
        .select('display_name')
        .eq('id', targetId)
        .maybeSingle();

    final mgrRow = await client
        .from('talent_manager_profiles')
        .select()
        .eq('user_id', targetId)
        .maybeSingle();

    final relsCount = await client
        .from('creator_manager_relationships')
        .select('id')
        .eq('manager_id', targetId)
        .eq('status', 'accepted');

    final displayName = profileRow?['display_name'] as String? ?? '';

    if (mgrRow == null) {
      return TalentManagerProfile(
        userId: targetId,
        displayName: displayName,
        representedCreatorsCount: (relsCount as List).length,
      );
    }

    return TalentManagerProfile(
      userId: targetId,
      displayName: displayName,
      bio: mgrRow['bio'] as String?,
      companyName: mgrRow['company_name'] as String?,
      organizationId: mgrRow['organization_id'] as String?,
      representedCreatorsCount: (relsCount as List).length,
      createdAt: mgrRow['created_at'] != null
          ? DateTime.tryParse(mgrRow['created_at'] as String)
          : null,
      updatedAt: mgrRow['updated_at'] != null
          ? DateTime.tryParse(mgrRow['updated_at'] as String)
          : null,
    );
  }

  @override
  Future<TalentManagerProfile> updateProfile(
    TalentManagerProfile profile,
  ) async {
    await client.from('talent_manager_profiles').upsert({
      'user_id': _actor,
      'bio': profile.bio,
      'company_name': profile.companyName,
      'organization_id': profile.organizationId,
    });
    return getProfile();
  }
}

class TalentManagerRepositoryImpl implements TalentManagerRepository {
  TalentManagerRepositoryImpl(this.dataSource);
  final TalentManagerDataSource dataSource;

  @override
  Future<TalentManagerProfile> getProfile({String? userId}) =>
      dataSource.getProfile(userId: userId);

  @override
  Future<TalentManagerProfile> updateProfile(TalentManagerProfile profile) =>
      dataSource.updateProfile(profile);
}
