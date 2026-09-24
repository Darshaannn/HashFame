import 'package:freezed_annotation/freezed_annotation.dart';

import 'rate_card.dart';

part 'collaboration.freezed.dart';
part 'collaboration.g.dart';

enum CollaborationProofType {
  @JsonValue('self_reported')
  selfReported,
  @JsonValue('platform_observed')
  platformObserved,
  @JsonValue('ggs_verified')
  ggsVerified;

  String get label => switch (this) {
    selfReported => 'Self-Reported',
    platformObserved => 'Platform Observed',
    ggsVerified => 'GGs Verified Transaction',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class PastCollaboration with _$PastCollaboration {
  const factory PastCollaboration({
    required String id,
    required String userId,
    required String brandName,
    String? campaignName,
    int? collaborationYear,
    @Default(DeliverableType.instagramReel) DeliverableType deliverableType,
    String? proofUrl,
    @Default(CollaborationProofType.selfReported)
    CollaborationProofType proofType,
  }) = _PastCollaboration;

  factory PastCollaboration.fromJson(Map<String, dynamic> json) =>
      _$PastCollaborationFromJson(json);
}
