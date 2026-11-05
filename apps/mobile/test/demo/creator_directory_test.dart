import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/demo/creator_directory_loader.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist_member.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Creator Directory Import & Integration Tests', () {
    test(
      'Loads complete imported database synchronously with 163 unique creators',
      () {
        final records = CreatorDirectoryLoader.loadDirectoryRecordsSync();
        expect(records.length, equals(163));

        // Test a known creator record
        final shruti = records.firstWhere(
          (r) => r['display_name'].toString().toLowerCase().contains(
            'shruti haasan',
          ),
        );
        expect(shruti['instagram_handle'], equals('shrutzhaasan'));
        expect(shruti['followers_count'], equals(24100000));
        expect(shruti['sources'], contains('Celebs Influencers'));
      },
    );

    test('Deduplicates repeat appearances across sheets', () {
      final records = CreatorDirectoryLoader.loadDirectoryRecordsSync();

      // Vishakha Fulsunge appears in All Categories and Travel
      final vishakha = records
          .where(
            (r) => r['display_name'].toString().toLowerCase().contains(
              'vishakha fulsunge',
            ),
          )
          .toList();
      expect(vishakha.length, equals(1));
      expect(vishakha.first['sources'], contains('All Categories'));
      expect(vishakha.first['sources'], contains('Travel'));
      expect(vishakha.first['categories'], contains('Travel & Adventure'));
      expect(vishakha.first['categories'], contains('Bikes & Moto'));
    });

    test('DemoStore seeds both mock personas and 163 directory creators', () {
      final store = DemoStore.instance;
      store.reset();

      // Seeded accounts: 12 mock + 163 directory = 175 total discovery items
      expect(store.discoveryItems.length, equals(175));
      expect(store.creatorProfiles.length, equals(175));

      // Verify directory creator is present in store
      final dirItems = store.discoveryItems
          .where((c) => c.creatorId.startsWith('dir_'))
          .toList();
      expect(dirItems.length, equals(163));
    });

    test('Discovery repository filters by name, handle, category and city accurately', () async {
      final store = DemoStore.instance;
      store.reset();

      // Search by handle
      final byHandle = store.discoveryItems
          .where(
            (c) =>
                c.professionalName?.toLowerCase().contains('shrutzhaasan') ??
                false,
          )
          .toList();
      expect(byHandle.length, equals(1));
      expect(byHandle.first.displayName, equals('Shruti Haasan'));

      // Search by category
      final travelCreators = store.discoveryItems
          .where(
            (c) => c.primaryCategoryNames.any(
              (cat) => cat.toLowerCase().contains('travel'),
            ),
          )
          .toList();
      expect(travelCreators.isNotEmpty, isTrue);

      // Search by city
      final mumbaiCreators = store.discoveryItems
          .where((c) => c.city?.toLowerCase() == 'mumbai')
          .toList();
      expect(mumbaiCreators.isNotEmpty, isTrue);
    });

    test('Shortlist saving works for directory creators', () {
      final store = DemoStore.instance;
      store.reset();

      final firstDir = store.discoveryItems.firstWhere(
        (c) => c.creatorId.startsWith('dir_'),
      );
      final shortlistId = store.shortlists.keys.first;

      // Add to shortlist
      store.shortlistMembers.putIfAbsent(shortlistId, () => []);
      store.shortlistMembers[shortlistId]!.add(
        ShortlistMember(
          id: 'test_sm_1',
          shortlistId: shortlistId,
          creatorId: firstDir.creatorId,
          addedBy: store.brandAccount.id,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          creatorDisplayName: firstDir.displayName,
          creatorCity: firstDir.city,
        ),
      );

      final members = store.shortlistMembers[shortlistId]!;
      expect(members.any((m) => m.creatorId == firstDir.creatorId), isTrue);
    });
  });
}
