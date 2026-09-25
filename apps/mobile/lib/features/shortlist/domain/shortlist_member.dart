import 'package:freezed_annotation/freezed_annotation.dart';

part 'shortlist_member.freezed.dart';
part 'shortlist_member.g.dart';

enum ShortlistMemberStatus {
  potential,
  reviewing,
  backup,
  negotiating,
  confirmed,
  rejected;

  String get label => switch (this) {
    ShortlistMemberStatus.potential => 'Potential',
    ShortlistMemberStatus.reviewing => 'Reviewing',
    ShortlistMemberStatus.backup => 'Backup',
    ShortlistMemberStatus.negotiating => 'Negotiating',
    ShortlistMemberStatus.confirmed => 'Confirmed',
    ShortlistMemberStatus.rejected => 'Rejected',
  };

  String get wire => name;
}

@Freezed(toJson: true, fromJson: true)
abstract class ShortlistMember with _$ShortlistMember {
  const factory ShortlistMember({
    required String id,
    required String shortlistId,
    required String creatorId,
    required String addedBy,
    @Default(ShortlistMemberStatus.potential) ShortlistMemberStatus status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    // Joined display details
    String? creatorDisplayName,
    String? creatorProfessionalName,
    String? creatorAvatarPath,
    String? creatorCity,
    String? creatorPrimaryCategory,
  }) = _ShortlistMember;

  factory ShortlistMember.fromJson(Map<String, dynamic> json) =>
      _$ShortlistMemberFromJson(json);
}
