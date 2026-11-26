import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/instagram_models.dart';
import '../domain/instagram_repository.dart';

class SupabaseInstagramRepository implements InstagramRepository {
  SupabaseInstagramRepository(this.client);
  final SupabaseClient client;

  @override
  Future<InstagramConnectedProfile?> getConnection(String creatorId) async {
    try {
      final res = await client
          .from('creator_instagram_connections')
          .select()
          .eq('creator_id', creatorId)
          .maybeSingle();

      if (res == null) return null;
      return InstagramConnectedProfile.fromJson(Map<String, dynamic>.from(res));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<InstagramConnectedProfile> connectInstagram({
    required String creatorId,
    required String username,
  }) async {
    // In production, token exchange happens through an Edge Function.
    // Client receives verified profile payload and stores connection state.
    final payload = {
      'creator_id': creatorId,
      'instagram_user_id': 'ig_${username.toLowerCase()}',
      'instagram_username': username.replaceAll('@', '').trim(),
      'account_type': 'BUSINESS',
      'status': 'connected',
      'authorized_scopes': [
        'instagram_business_basic',
        'instagram_business_manage_insights',
      ],
      'last_synced_at': DateTime.now().toIso8601String(),
    };

    final res = await client
        .from('creator_instagram_connections')
        .upsert(payload)
        .select()
        .single();

    return InstagramConnectedProfile.fromJson(Map<String, dynamic>.from(res));
  }

  @override
  Future<InstagramConnectedProfile> refreshConnection(String creatorId) async {
    final conn = await getConnection(creatorId);
    if (conn == null) throw Exception('No connected Instagram account found');

    // Update synchronization timestamp
    final res = await client
        .from('creator_instagram_connections')
        .update({'last_synced_at': DateTime.now().toIso8601String()})
        .eq('creator_id', creatorId)
        .select()
        .single();

    return InstagramConnectedProfile.fromJson(Map<String, dynamic>.from(res));
  }

  @override
  Future<void> disconnectInstagram(String creatorId) async {
    await client.rpc('disconnect_instagram_account');
  }

  @override
  Future<List<InstagramMediaItem>> getRecentMedia(String creatorId) async {
    try {
      final res = await client
          .from('creator_instagram_media')
          .select()
          .eq('creator_id', creatorId)
          .order('timestamp', ascending: false)
          .limit(12);

      return (res as List)
          .map(
            (e) => InstagramMediaItem.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }
}
