import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_search_filters.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist_member.dart';
import '../support/fakes.dart';

void main() {
  group('CreatorSearchFilters Domain Tests', () {
    test('default filter is empty and activeFilterCount is 0', () {
      const filters = CreatorSearchFilters();
      expect(filters.isEmpty, isTrue);
      expect(filters.activeFilterCount, equals(0));
    });

    test('activeFilterCount increments accurately for populated fields', () {
      const filters = CreatorSearchFilters(
        query: 'tech',
        categoryIds: ['cat1'],
        city: 'Mumbai',
        minRate: 10000,
        availability: AvailabilityStatus.open,
      );
      // activeFilterCount calculates non-query active filter chips
      expect(filters.activeFilterCount, equals(4));
    });
  });

  group('FakeDiscoveryRepository Unit Tests', () {
    late FakeDiscoveryRepository repo;

    setUp(() {
      repo = FakeDiscoveryRepository();
    });

    test('searchCreators returns default list with pagination metadata', () async {
      final res = await repo.searchCreators(filters: const CreatorSearchFilters(), limit: 2);
      expect(res.items.length, equals(2));
      expect(res.hasMore, isTrue);
      expect(res.nextOffset, equals(2));
    });

    test('searchCreators filters by textual query against displayName and professionalName', () async {
      final res = await repo.searchCreators(filters: const CreatorSearchFilters(query: 'ananya'));
      expect(res.items.length, equals(1));
      expect(res.items.first.displayName, equals('Ananya Verma'));
    });

    test('searchCreators filters by city and availability', () async {
      final res = await repo.searchCreators(
        filters: const CreatorSearchFilters(city: 'Delhi', availability: AvailabilityStatus.limited),
      );
      expect(res.items.length, equals(1));
      expect(res.items.first.displayName, equals('Vikram Joshi'));
    });

    test('searchCreators filters by rate range', () async {
      final res = await repo.searchCreators(
        filters: const CreatorSearchFilters(minRate: 20000, maxRate: 30000),
      );
      expect(res.items.length, equals(1));
      expect(res.items.first.displayName, equals('Rohan Sharma'));
    });

    test('getCreatorsForComparison returns matched items up to request', () async {
      final list = await repo.getCreatorsForComparison(creatorIds: ['c1', 'c2']);
      expect(list.length, equals(2));
      expect(list.map((c) => c.creatorId), containsAll(['c1', 'c2']));
    });
  });

  group('FakeShortlistRepository Unit Tests', () {
    late FakeShortlistRepository repo;

    setUp(() {
      repo = FakeShortlistRepository();
    });

    test('creates and retrieves shortlist', () async {
      final created = await repo.createShortlist(name: 'Q3 Diwali Campaign', description: 'Tech creators');
      expect(created.name, equals('Q3 Diwali Campaign'));
      expect(created.memberCount, equals(0));

      final all = await repo.listShortlists();
      expect(all.length, equals(1));
      expect(all.first.id, equals(created.id));
    });

    test('adds creator to shortlist and updates member status and notes', () async {
      final list = await repo.createShortlist(name: 'Fashion Collabs');
      final member = await repo.addCreatorToShortlist(
        shortlistId: list.id,
        creatorId: 'c1',
        status: ShortlistMemberStatus.potential,
        notes: 'Initial outreach planned',
      );

      expect(member.status, equals(ShortlistMemberStatus.potential));
      expect(member.notes, equals('Initial outreach planned'));

      await repo.updateMemberStatus(memberId: member.id, status: ShortlistMemberStatus.negotiating);
      await repo.updateMemberNotes(memberId: member.id, notes: 'Offered 25k INR');

      final updatedList = await repo.getShortlist(shortlistId: list.id);
      expect(updatedList.memberCount, equals(1));
      expect(updatedList.members.first.status, equals(ShortlistMemberStatus.negotiating));
      expect(updatedList.members.first.notes, equals('Offered 25k INR'));
    });

    test('prevents duplicate creator membership in same shortlist', () async {
      final list = await repo.createShortlist(name: 'Gaming Shortlist');
      await repo.addCreatorToShortlist(shortlistId: list.id, creatorId: 'c3');

      expect(
        () => repo.addCreatorToShortlist(shortlistId: list.id, creatorId: 'c3'),
        throwsA(isA<Exception>()),
      );
    });

    test('removes creator and deletes shortlist', () async {
      final list = await repo.createShortlist(name: 'Temporary List');
      await repo.addCreatorToShortlist(shortlistId: list.id, creatorId: 'c1');

      await repo.removeCreatorFromShortlist(shortlistId: list.id, creatorId: 'c1');
      var updatedList = await repo.getShortlist(shortlistId: list.id);
      expect(updatedList.memberCount, equals(0));

      await repo.deleteShortlist(shortlistId: list.id);
      final all = await repo.listShortlists();
      expect(all.isEmpty, isTrue);
    });

    test('efficient saved creator memberships mapping', () async {
      final l1 = await repo.createShortlist(name: 'List 1');
      final l2 = await repo.createShortlist(name: 'List 2');
      await repo.addCreatorToShortlist(shortlistId: l1.id, creatorId: 'c1');
      await repo.addCreatorToShortlist(shortlistId: l2.id, creatorId: 'c1');
      await repo.addCreatorToShortlist(shortlistId: l2.id, creatorId: 'c2');

      final map = await repo.getSavedCreatorMemberships();
      expect(map['c1'], containsAll([l1.id, l2.id]));
      expect(map['c2'], containsAll([l2.id]));
    });
  });
}
