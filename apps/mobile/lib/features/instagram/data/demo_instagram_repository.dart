import 'dart:async';

import '../domain/instagram_models.dart';
import '../domain/instagram_repository.dart';

class DemoInstagramRepository implements InstagramRepository {
  DemoInstagramRepository();

  final Map<String, InstagramConnectedProfile> _connections = {
    'demo_creator_user_id': InstagramConnectedProfile(
      creatorId: 'demo_creator_user_id',
      instagramUserId: 'ig_priya_mehra_official',
      username: 'priya_mehra_official',
      accountType: 'BUSINESS',
      status: InstagramConnectionStatus.connected,
      authorizedScopes: ['instagram_business_basic'],
      followersCount: 125000,
      mediaCount: 342,
      profilePictureUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      lastSyncedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  };

  final Map<String, List<InstagramMediaItem>> _media = {
    'demo_creator_user_id': [
      InstagramMediaItem(
        id: 'ig_media_1',
        creatorId: 'demo_creator_user_id',
        instagramMediaId: '179283749283',
        mediaType: InstagramMediaType.reel,
        thumbnailUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=600&q=80',
        permalink: 'https://instagram.com/p/reel1',
        caption: 'Golden hour skincare secrets ✨ #CleanBeauty #Glow',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        likeCount: 4200,
        commentsCount: 124,
      ),
      InstagramMediaItem(
        id: 'ig_media_2',
        creatorId: 'demo_creator_user_id',
        instagramMediaId: '179283749284',
        mediaType: InstagramMediaType.image,
        thumbnailUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=600&q=80',
        permalink: 'https://instagram.com/p/image2',
        caption: 'Festive lookbook 2026 🥻',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        likeCount: 6800,
        commentsCount: 210,
      ),
    ],
  };

  @override
  Future<InstagramConnectedProfile?> getConnection(String creatorId) async {
    return _connections[creatorId];
  }

  @override
  Future<InstagramConnectedProfile> connectInstagram({
    required String creatorId,
    required String username,
  }) async {
    final cleanHandle = username.replaceAll('@', '').trim();
    final profile = InstagramConnectedProfile(
      creatorId: creatorId,
      instagramUserId: 'ig_${cleanHandle.toLowerCase()}',
      username: cleanHandle,
      accountType: 'BUSINESS',
      status: InstagramConnectionStatus.connected,
      authorizedScopes: ['instagram_business_basic'],
      followersCount: 88500,
      mediaCount: 140,
      lastSyncedAt: DateTime.now(),
    );
    _connections[creatorId] = profile;
    return profile;
  }

  @override
  Future<InstagramConnectedProfile> refreshConnection(String creatorId) async {
    final conn = _connections[creatorId];
    if (conn == null) throw Exception('No connected Instagram account found');

    final updated = InstagramConnectedProfile(
      creatorId: conn.creatorId,
      instagramUserId: conn.instagramUserId,
      username: conn.username,
      accountType: conn.accountType,
      status: conn.status,
      authorizedScopes: conn.authorizedScopes,
      followersCount: (conn.followersCount ?? 0) + 150,
      mediaCount: conn.mediaCount + 1,
      profilePictureUrl: conn.profilePictureUrl,
      lastSyncedAt: DateTime.now(),
    );
    _connections[creatorId] = updated;
    return updated;
  }

  @override
  Future<void> disconnectInstagram(String creatorId) async {
    _connections.remove(creatorId);
    _media.remove(creatorId);
  }

  @override
  Future<List<InstagramMediaItem>> getRecentMedia(String creatorId) async {
    return _media[creatorId] ?? [];
  }
}
