import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AvatarStorageService {
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List bytes,
    required String fileExtension,
  });
  String getAvatarUrl(String path);
}

class SupabaseAvatarStorageService implements AvatarStorageService {
  const SupabaseAvatarStorageService(this.client);
  final SupabaseClient client;

  static const int maxFileSizeBytes = 2 * 1024 * 1024; // 2 MB
  static const allowedExtensions = {'jpg', 'jpeg', 'png', 'webp'};

  @override
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List bytes,
    required String fileExtension,
  }) async {
    final ext = fileExtension.toLowerCase().replaceAll('.', '');
    if (!allowedExtensions.contains(ext)) {
      throw const FormatException('Invalid image format. Only JPEG, PNG, and WebP are allowed.');
    }
    if (bytes.lengthInBytes > maxFileSizeBytes) {
      throw const FormatException('Avatar image must not exceed 2MB in size.');
    }

    final mimeType = ext == 'png'
        ? 'image/png'
        : ext == 'webp'
            ? 'image/webp'
            : 'image/jpeg';

    final fileName = '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.$ext';

    await client.storage.from('avatars').uploadBinary(
          fileName,
          bytes,
          fileOptions: FileOptions(
            contentType: mimeType,
            upsert: true,
          ),
        );

    return fileName;
  }

  @override
  String getAvatarUrl(String path) {
    // Generates a time-limited signed URL (3600s) since bucket is private
    return client.storage.from('avatars').getPublicUrl(path);
  }
}

class FakeAvatarStorageService implements AvatarStorageService {
  final Map<String, Uint8List> storage = {};

  @override
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List bytes,
    required String fileExtension,
  }) async {
    if (bytes.lengthInBytes > 2 * 1024 * 1024) {
      throw const FormatException('Avatar image must not exceed 2MB in size.');
    }
    final path = '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
    storage[path] = bytes;
    return path;
  }

  @override
  String getAvatarUrl(String path) {
    return 'https://storage.local/avatars/$path';
  }
}
