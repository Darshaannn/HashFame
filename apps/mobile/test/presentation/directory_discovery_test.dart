import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/demo/creator_directory_loader.dart';
import 'package:ggs_mobile/demo/demo_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phase 04 Online Directory & Discovery Tests', () {
    test('Creator directory fixture loads exactly 163 unique influencer records', () {
      final records = CreatorDirectoryLoader.loadDirectoryRecordsSync();
      expect(records.length, 163);

      final items = CreatorDirectoryLoader.mapToDiscoveryItems(records);
      expect(items.length, 163);

      final ids = items.map((i) => i.creatorId).toSet();
      expect(ids.length, 163);
    });

    test('Directory creators preserve stable directory_id starting with dir_', () {
      final records = CreatorDirectoryLoader.loadDirectoryRecordsSync();
      final items = CreatorDirectoryLoader.mapToDiscoveryItems(records);
      for (final item in items) {
        expect(item.creatorId.startsWith('dir_'), isTrue);
        expect(item.displayName.isNotEmpty, isTrue);
      }
    });

    test('DemoStore includes loaded directory creators alongside registered creators', () {
      final store = DemoStore.instance;
      expect(store.discoveryItems.isNotEmpty, isTrue);
      final hasRegistered = store.discoveryItems.any((i) => !i.creatorId.startsWith('dir_'));
      final hasDirectory = store.discoveryItems.any((i) => i.creatorId.startsWith('dir_'));
      expect(hasRegistered, isTrue);
      expect(hasDirectory, isTrue);
    });

    test('Category filtering accurately filters directory creators by niche', () {
      final records = CreatorDirectoryLoader.loadDirectoryRecordsSync();
      final items = CreatorDirectoryLoader.mapToDiscoveryItems(records);
      final fashionCreators = items.where(
        (i) => i.primaryCategoryNames.any((c) => c.toLowerCase().contains('fashion')),
      ).toList();
      expect(fashionCreators.isNotEmpty, isTrue);

      final beautyCreators = items.where(
        (i) => i.primaryCategoryNames.any((c) => c.toLowerCase().contains('beauty')),
      ).toList();
      expect(beautyCreators.isNotEmpty, isTrue);
    });
  });
}
