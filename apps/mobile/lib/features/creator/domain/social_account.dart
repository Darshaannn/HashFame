import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ggs_mobile/features/profile_common/domain/verification.dart';

part 'social_account.freezed.dart';
part 'social_account.g.dart';

enum SocialPlatform {
  instagram,
  youtube,
  facebook,
  x,
  linkedin,
  other;

  String get label => switch (this) {
    instagram => 'Instagram',
    youtube => 'YouTube',
    facebook => 'Facebook',
    x => 'X (Twitter)',
    linkedin => 'LinkedIn',
    other => 'Other Platform',
  };
}

enum SocialConnectionStatus {
  @JsonValue('self_reported')
  selfReported,
  connected,
  disconnected;

  String get label => switch (this) {
    selfReported => 'Self-Reported',
    connected => 'Platform Connected',
    disconnected => 'Disconnected',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class SocialAccount with _$SocialAccount {
  const factory SocialAccount({
    required String id,
    required String userId,
    required SocialPlatform platform,
    required String handle,
    String? profileUrl,
    int? userProvidedFollowerCount,
    @Default(SocialConnectionStatus.selfReported)
    SocialConnectionStatus connectionStatus,
    @Default(FieldVerificationStatus.notStarted)
    FieldVerificationStatus verificationStatus,
    DateTime? lastVerifiedAt,
  }) = _SocialAccount;

  factory SocialAccount.fromJson(Map<String, dynamic> json) =>
      _$SocialAccountFromJson(json);
}
