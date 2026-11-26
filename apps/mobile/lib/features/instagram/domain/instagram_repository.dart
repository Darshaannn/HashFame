import 'instagram_models.dart';

abstract interface class InstagramRepository {
  /// Check current Instagram connection state for a creator
  Future<InstagramConnectedProfile?> getConnection(String creatorId);

  /// Initiate simulated / server-side OAuth flow
  Future<InstagramConnectedProfile> connectInstagram({
    required String creatorId,
    required String username,
  });

  /// Refresh latest followers and media from official Graph API
  Future<InstagramConnectedProfile> refreshConnection(String creatorId);

  /// Disconnect Instagram account and revoke tokens
  Future<void> disconnectInstagram(String creatorId);

  /// Fetch authenticated creator media showcase
  Future<List<InstagramMediaItem>> getRecentMedia(String creatorId);
}
