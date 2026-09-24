import 'package:freezed_annotation/freezed_annotation.dart';

part 'creator_manager.freezed.dart';
part 'creator_manager.g.dart';

enum ManagerRelationshipStatus {
  pending,
  accepted,
  revoked;

  String get label => switch (this) {
    pending => 'Pending Creator Confirmation',
    accepted => 'Accepted & Active',
    revoked => 'Revoked / Ended',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class CreatorManagerRelationship with _$CreatorManagerRelationship {
  const factory CreatorManagerRelationship({
    required String id,
    required String creatorId,
    required String managerId,
    String? managerName,
    String? managerCompany,
    @Default(ManagerRelationshipStatus.pending)
    ManagerRelationshipStatus status,
    String? notes,
    DateTime? createdAt,
  }) = _CreatorManagerRelationship;

  factory CreatorManagerRelationship.fromJson(Map<String, dynamic> json) =>
      _$CreatorManagerRelationshipFromJson(json);
}
