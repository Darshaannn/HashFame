import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/agency_profile.dart';
import '../domain/agency_repository.dart';

class SupabaseAgencyDataSource implements AgencyDataSource {
  SupabaseAgencyDataSource(this.client);
  final SupabaseClient client;

  @override
  String? get userId => client.auth.currentUser?.id;
  String get _actor => userId ?? (throw const AuthException('Session missing'));

  @override
  Future<AgencyProfile> getProfile({String? userId}) async {
    final targetId = userId ?? _actor;

    final agencyRow = await client
        .from('agency_profiles')
        .select()
        .eq('user_id', targetId)
        .maybeSingle();

    if (agencyRow == null) {
      return AgencyProfile(userId: targetId, agencyName: '');
    }

    final servicesList = (agencyRow['services'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    return AgencyProfile(
      userId: targetId,
      agencyName: agencyRow['agency_name'] as String? ?? '',
      website: agencyRow['website'] as String?,
      description: agencyRow['description'] as String?,
      location: agencyRow['location'] as String?,
      services: servicesList,
      organizationId: agencyRow['organization_id'] as String?,
      createdAt: agencyRow['created_at'] != null
          ? DateTime.tryParse(agencyRow['created_at'] as String)
          : null,
      updatedAt: agencyRow['updated_at'] != null
          ? DateTime.tryParse(agencyRow['updated_at'] as String)
          : null,
    );
  }

  @override
  Future<AgencyProfile> updateProfile(AgencyProfile profile) async {
    await client.from('agency_profiles').upsert({
      'user_id': _actor,
      'agency_name': profile.agencyName,
      'website': profile.website,
      'description': profile.description,
      'location': profile.location,
      'services': profile.services,
      'organization_id': profile.organizationId,
    });
    return getProfile();
  }
}

class AgencyRepositoryImpl implements AgencyRepository {
  AgencyRepositoryImpl(this.dataSource);
  final AgencyDataSource dataSource;

  @override
  Future<AgencyProfile> getProfile({String? userId}) =>
      dataSource.getProfile(userId: userId);

  @override
  Future<AgencyProfile> updateProfile(AgencyProfile profile) =>
      dataSource.updateProfile(profile);
}
