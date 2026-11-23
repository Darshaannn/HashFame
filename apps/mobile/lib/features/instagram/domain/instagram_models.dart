import 'package:flutter/foundation.dart';

enum InstagramConnectionStatus {
  notConnected,
  connected,
  expired,
  permissionRevoked,
  error;

  static InstagramConnectionStatus fromWire(String? value) {
    return switch (value) {
      'connected' => InstagramConnectionStatus.connected,
      'expired' => InstagramConnectionStatus.expired,
      'permission_revoked' => InstagramConnectionStatus.permissionRevoked,
      'error' => InstagramConnectionStatus.error,
      _ => InstagramConnectionStatus.notConnected,
    };
  }

  String get wire => switch (this) {
    InstagramConnectionStatus.connected => 'connected',
    InstagramConnectionStatus.expired => 'expired',
    InstagramConnectionStatus.permissionRevoked => 'permission_revoked',
    InstagramConnectionStatus.error => 'error',
    InstagramConnectionStatus.notConnected => 'not_connected',
  };
}

enum InstagramMediaType {
  image,
  video,
  carouselAlbum,
  reel;

  static InstagramMediaType fromWire(String? value) {
    return switch (value) {
      'video' || 'VIDEO' => InstagramMediaType.video,
      'carousel_album' || 'CAROUSEL_ALBUM' => InstagramMediaType.carouselAlbum,
      'reel' || 'REELS' => InstagramMediaType.reel,
      _ => InstagramMediaType.image,
    };
  }
}

@immutable
class InstagramConnectedProfile {
  const InstagramConnectedProfile({
    required this.creatorId,
    required this.instagramUserId,
    required this.username,
    this.accountType = 'BUSINESS',
    this.status = InstagramConnectionStatus.connected,
    this.authorizedScopes = const [],
    this.followersCount,
    this.mediaCount = 0,
    this.profilePictureUrl,
    required this.lastSyncedAt,
    this.tokenExpiresAt,
  });

  final String creatorId;
  final String instagramUserId;
  final String username;
  final String accountType;
  final InstagramConnectionStatus status;
  final List<String> authorizedScopes;
  final int? followersCount;
  final int mediaCount;
  final String? profilePictureUrl;
  final DateTime lastSyncedAt;
  final DateTime? tokenExpiresAt;

  factory InstagramConnectedProfile.fromJson(Map<String, dynamic> json) {
    return InstagramConnectedProfile(
      creatorId: json['creator_id'] as String? ?? '',
      instagramUserId: json['instagram_user_id'] as String? ?? '',
      username: json['instagram_username'] as String? ?? '',
      accountType: json['account_type'] as String? ?? 'BUSINESS',
      status: InstagramConnectionStatus.fromWire(json['status'] as String?),
      authorizedScopes: (json['authorized_scopes'] as List?)?.map((e) => e.toString()).toList() ?? [],
      followersCount: json['followers_count'] is int
          ? json['followers_count'] as int
          : int.tryParse(json['followers_count']?.toString() ?? ''),
      mediaCount: json['media_count'] as int? ?? 0,
      profilePictureUrl: json['profile_picture_url'] as String?,
      lastSyncedAt: json['last_synced_at'] != null
          ? DateTime.parse(json['last_synced_at'] as String)
          : DateTime.now(),
      tokenExpiresAt: json['token_expires_at'] != null
          ? DateTime.parse(json['token_expires_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'creator_id': creatorId,
    'instagram_user_id': instagramUserId,
    'instagram_username': username,
    'account_type': accountType,
    'status': status.wire,
    'authorized_scopes': authorizedScopes,
    'followers_count': followersCount,
    'media_count': mediaCount,
    'profile_picture_url': profilePictureUrl,
    'last_synced_at': lastSyncedAt.toIso8601String(),
    'token_expires_at': tokenExpiresAt?.toIso8601String(),
  };
}

@immutable
class InstagramMediaItem {
  const InstagramMediaItem({
    required this.id,
    required this.creatorId,
    required this.instagramMediaId,
    this.mediaType = InstagramMediaType.image,
    this.mediaUrl,
    this.thumbnailUrl,
    this.permalink,
    this.caption,
    this.timestamp,
    this.likeCount = 0,
    this.commentsCount = 0,
  });

  final String id;
  final String creatorId;
  final String instagramMediaId;
  final InstagramMediaType mediaType;
  final String? mediaUrl;
  final String? thumbnailUrl;
  final String? permalink;
  final String? caption;
  final DateTime? timestamp;
  final int likeCount;
  final int commentsCount;

  factory InstagramMediaItem.fromJson(Map<String, dynamic> json) {
    return InstagramMediaItem(
      id: json['id'] as String? ?? '',
      creatorId: json['creator_id'] as String? ?? '',
      instagramMediaId: json['instagram_media_id'] as String? ?? '',
      mediaType: InstagramMediaType.fromWire(json['media_type'] as String?),
      mediaUrl: json['media_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      permalink: json['permalink'] as String?,
      caption: json['caption'] as String?,
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp'] as String) : null,
      likeCount: json['like_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
    );
  }
}
