import 'package:freezed_annotation/freezed_annotation.dart';

import 'shortlist_member.dart';

part 'shortlist.freezed.dart';
part 'shortlist.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class Shortlist with _$Shortlist {
  const factory Shortlist({
    required String id,
    required String organizationId,
    required String createdBy,
    required String name,
    String? description,
    @Default(false) bool isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int memberCount,
    @Default([]) List<ShortlistMember> members,
  }) = _Shortlist;

  factory Shortlist.fromJson(Map<String, dynamic> json) =>
      _$ShortlistFromJson(json);
}
