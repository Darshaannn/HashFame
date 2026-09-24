import 'shortlist.dart';
import 'shortlist_member.dart';

abstract interface class ShortlistRepository {
  Future<List<Shortlist>> listShortlists({String? organizationId});
  Future<Shortlist> getShortlist({required String shortlistId});
  Future<Shortlist> createShortlist({required String name, String? description, String? organizationId});
  Future<Shortlist> updateShortlist({required String shortlistId, String? name, String? description, bool? isArchived});
  Future<void> deleteShortlist({required String shortlistId});

  // Membership
  Future<ShortlistMember> addCreatorToShortlist({
    required String shortlistId,
    required String creatorId,
    ShortlistMemberStatus status = ShortlistMemberStatus.potential,
    String? notes,
  });
  Future<void> removeCreatorFromShortlist({required String shortlistId, required String creatorId});
  Future<void> updateMemberStatus({required String memberId, required ShortlistMemberStatus status});
  Future<void> updateMemberNotes({required String memberId, required String notes});

  // Fast saved state lookup: returns Set of shortlist IDs containing creatorId
  Future<Set<String>> getCreatorShortlistMemberships({required String creatorId, String? organizationId});
  // Fast lookup for all saved creators in current org: returns Map<creatorId, List<shortlistId>>
  Future<Map<String, List<String>>> getSavedCreatorMemberships({String? organizationId});
}
