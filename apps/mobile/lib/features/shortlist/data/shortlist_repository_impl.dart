import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/shortlist.dart';
import '../domain/shortlist_member.dart';
import '../domain/shortlist_repository.dart';

class SupabaseShortlistDataSource {
  SupabaseShortlistDataSource(this.client);
  final SupabaseClient client;

  String? get _userId => client.auth.currentUser?.id;

  Future<List<Shortlist>> listShortlists({String? organizationId}) async {
    var query = client
        .from('shortlists')
        .select('*, shortlist_members(id)')
        .eq('is_archived', false);

    if (organizationId != null) {
      query = query.eq('organization_id', organizationId);
    }

    final rows = await query.order('updated_at', ascending: false) as List;
    return rows.map((row) {
      final members = row['shortlist_members'] as List? ?? [];
      return Shortlist(
        id: row['id'] as String,
        organizationId: row['organization_id'] as String,
        createdBy: row['created_by'] as String,
        name: row['name'] as String,
        description: row['description'] as String?,
        isArchived: row['is_archived'] as bool? ?? false,
        createdAt: DateTime.parse(row['created_at'] as String),
        updatedAt: DateTime.parse(row['updated_at'] as String),
        memberCount: members.length,
      );
    }).toList();
  }

  Future<Shortlist> getShortlist({required String shortlistId}) async {
    final row = await client
        .from('shortlists')
        .select('''
          *,
          shortlist_members(
            id, shortlist_id, creator_id, added_by, status, notes, created_at, updated_at,
            creator_profiles(
              city,
              profiles(display_name, avatar_path),
              creator_categories(is_primary, categories(name))
            )
          )
        ''')
        .eq('id', shortlistId)
        .single();

    final memberRows = row['shortlist_members'] as List? ?? [];
    final members = memberRows.map((m) {
      final cp = m['creator_profiles'] as Map<String, dynamic>? ?? {};
      final p = cp['profiles'] as Map<String, dynamic>? ?? {};
      final catList = cp['creator_categories'] as List? ?? [];
      String? primaryCat;
      for (final c in catList) {
        if (c['is_primary'] == true && c['categories'] != null) {
          primaryCat = c['categories']['name'] as String?;
          break;
        }
      }

      final statusStr = m['status'] as String? ?? 'potential';
      final status = ShortlistMemberStatus.values.where((s) => s.name == statusStr).firstOrNull ??
          ShortlistMemberStatus.potential;

      return ShortlistMember(
        id: m['id'] as String,
        shortlistId: m['shortlist_id'] as String,
        creatorId: m['creator_id'] as String,
        addedBy: m['added_by'] as String,
        status: status,
        notes: m['notes'] as String?,
        createdAt: DateTime.parse(m['created_at'] as String),
        updatedAt: DateTime.parse(m['updated_at'] as String),
        creatorDisplayName: p['display_name'] as String?,
        creatorAvatarPath: p['avatar_path'] as String?,
        creatorCity: cp['city'] as String?,
        creatorPrimaryCategory: primaryCat,
      );
    }).toList();

    return Shortlist(
      id: row['id'] as String,
      organizationId: row['organization_id'] as String,
      createdBy: row['created_by'] as String,
      name: row['name'] as String,
      description: row['description'] as String?,
      isArchived: row['is_archived'] as bool? ?? false,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
      memberCount: members.length,
      members: members,
    );
  }

  Future<Shortlist> createShortlist({
    required String name,
    String? description,
    String? organizationId,
  }) async {
    // If organizationId not provided, look up primary organization membership
    var orgId = organizationId;
    if (orgId == null) {
      final membership = await client
          .from('organization_memberships')
          .select('organization_id')
          .eq('user_id', _userId!)
          .eq('membership_status', 'active')
          .limit(1)
          .maybeSingle();
      orgId = membership?['organization_id'] as String?;
    }
    if (orgId == null) {
      throw const FormatException('Organization required to create a shortlist');
    }

    final row = await client.from('shortlists').insert({
      'organization_id': orgId,
      'created_by': _userId,
      'name': name.trim(),
      'description': description?.trim(),
    }).select().single();

    return Shortlist(
      id: row['id'] as String,
      organizationId: row['organization_id'] as String,
      createdBy: row['created_by'] as String,
      name: row['name'] as String,
      description: row['description'] as String?,
      isArchived: row['is_archived'] as bool? ?? false,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  Future<Shortlist> updateShortlist({
    required String shortlistId,
    String? name,
    String? description,
    bool? isArchived,
  }) async {
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name.trim();
    if (description != null) updates['description'] = description.trim();
    if (isArchived != null) updates['is_archived'] = isArchived;

    final row = await client
        .from('shortlists')
        .update(updates)
        .eq('id', shortlistId)
        .select()
        .single();

    return Shortlist(
      id: row['id'] as String,
      organizationId: row['organization_id'] as String,
      createdBy: row['created_by'] as String,
      name: row['name'] as String,
      description: row['description'] as String?,
      isArchived: row['is_archived'] as bool? ?? false,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  Future<void> deleteShortlist({required String shortlistId}) async {
    await client.from('shortlists').delete().eq('id', shortlistId);
  }

  Future<ShortlistMember> addCreatorToShortlist({
    required String shortlistId,
    required String creatorId,
    ShortlistMemberStatus status = ShortlistMemberStatus.potential,
    String? notes,
  }) async {
    final row = await client.from('shortlist_members').insert({
      'shortlist_id': shortlistId,
      'creator_id': creatorId,
      'added_by': _userId,
      'status': status.name,
      'notes': notes?.trim(),
    }).select().single();

    return ShortlistMember(
      id: row['id'] as String,
      shortlistId: row['shortlist_id'] as String,
      creatorId: row['creator_id'] as String,
      addedBy: row['added_by'] as String,
      status: status,
      notes: row['notes'] as String?,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  Future<void> removeCreatorFromShortlist({
    required String shortlistId,
    required String creatorId,
  }) async {
    await client
        .from('shortlist_members')
        .delete()
        .eq('shortlist_id', shortlistId)
        .eq('creator_id', creatorId);
  }

  Future<void> updateMemberStatus({
    required String memberId,
    required ShortlistMemberStatus status,
  }) async {
    await client
        .from('shortlist_members')
        .update({'status': status.name})
        .eq('id', memberId);
  }

  Future<void> updateMemberNotes({
    required String memberId,
    required String notes,
  }) async {
    await client
        .from('shortlist_members')
        .update({'notes': notes.trim()})
        .eq('id', memberId);
  }

  Future<Set<String>> getCreatorShortlistMemberships({
    required String creatorId,
    String? organizationId,
  }) async {
    final rows = await client
        .from('shortlist_members')
        .select('shortlist_id')
        .eq('creator_id', creatorId) as List;
    return rows.map((r) => r['shortlist_id'] as String).toSet();
  }

  Future<Map<String, List<String>>> getSavedCreatorMemberships({
    String? organizationId,
  }) async {
    final rows = await client
        .from('shortlist_members')
        .select('creator_id, shortlist_id') as List;

    final map = <String, List<String>>{};
    for (final r in rows) {
      final cId = r['creator_id'] as String;
      final sId = r['shortlist_id'] as String;
      map.putIfAbsent(cId, () => []).add(sId);
    }
    return map;
  }
}

class ShortlistRepositoryImpl implements ShortlistRepository {
  ShortlistRepositoryImpl(this.dataSource);
  final SupabaseShortlistDataSource dataSource;

  @override
  Future<List<Shortlist>> listShortlists({String? organizationId}) =>
      dataSource.listShortlists(organizationId: organizationId);

  @override
  Future<Shortlist> getShortlist({required String shortlistId}) =>
      dataSource.getShortlist(shortlistId: shortlistId);

  @override
  Future<Shortlist> createShortlist({
    required String name,
    String? description,
    String? organizationId,
  }) =>
      dataSource.createShortlist(
        name: name,
        description: description,
        organizationId: organizationId,
      );

  @override
  Future<Shortlist> updateShortlist({
    required String shortlistId,
    String? name,
    String? description,
    bool? isArchived,
  }) =>
      dataSource.updateShortlist(
        shortlistId: shortlistId,
        name: name,
        description: description,
        isArchived: isArchived,
      );

  @override
  Future<void> deleteShortlist({required String shortlistId}) =>
      dataSource.deleteShortlist(shortlistId: shortlistId);

  @override
  Future<ShortlistMember> addCreatorToShortlist({
    required String shortlistId,
    required String creatorId,
    ShortlistMemberStatus status = ShortlistMemberStatus.potential,
    String? notes,
  }) =>
      dataSource.addCreatorToShortlist(
        shortlistId: shortlistId,
        creatorId: creatorId,
        status: status,
        notes: notes,
      );

  @override
  Future<void> removeCreatorFromShortlist({
    required String shortlistId,
    required String creatorId,
  }) =>
      dataSource.removeCreatorFromShortlist(
        shortlistId: shortlistId,
        creatorId: creatorId,
      );

  @override
  Future<void> updateMemberStatus({
    required String memberId,
    required ShortlistMemberStatus status,
  }) =>
      dataSource.updateMemberStatus(memberId: memberId, status: status);

  @override
  Future<void> updateMemberNotes({
    required String memberId,
    required String notes,
  }) =>
      dataSource.updateMemberNotes(memberId: memberId, notes: notes);

  @override
  Future<Set<String>> getCreatorShortlistMemberships({
    required String creatorId,
    String? organizationId,
  }) =>
      dataSource.getCreatorShortlistMemberships(
        creatorId: creatorId,
        organizationId: organizationId,
      );

  @override
  Future<Map<String, List<String>>> getSavedCreatorMemberships({
    String? organizationId,
  }) =>
      dataSource.getSavedCreatorMemberships(organizationId: organizationId);
}
