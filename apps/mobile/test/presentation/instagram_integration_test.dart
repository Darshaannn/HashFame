import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/features/instagram/data/demo_instagram_repository.dart';
import 'package:ggs_mobile/features/instagram/domain/instagram_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phase 06 Instagram & Meta Graph API Integration Tests', () {
    test(
      'Demo repository retrieves default connected profile for demo creator',
      () async {
        final repo = DemoInstagramRepository();
        final conn = await repo.getConnection('demo_creator_user_id');

        expect(conn, isNotNull);
        expect(conn!.username, 'priya_mehra_official');
        expect(conn.status, InstagramConnectionStatus.connected);
        expect(conn.followersCount, 125000);
        expect(conn.mediaCount, 342);
      },
    );

    test('Demo repository retrieves portfolio media showcase', () async {
      final repo = DemoInstagramRepository();
      final media = await repo.getRecentMedia('demo_creator_user_id');

      expect(media.isNotEmpty, isTrue);
      expect(media.any((m) => m.mediaType == InstagramMediaType.reel), isTrue);
      expect(media.first.likeCount, greaterThan(0));
    });

    test(
      'Connecting an Instagram account updates connection status cleanly',
      () async {
        final repo = DemoInstagramRepository();
        const creatorId = 'new_creator_id';

        expect(await repo.getConnection(creatorId), isNull);

        final connected = await repo.connectInstagram(
          creatorId: creatorId,
          username: '@ananya_fitness',
        );

        expect(connected.username, 'ananya_fitness');
        expect(connected.status, InstagramConnectionStatus.connected);
        expect(connected.followersCount, isNotNull);

        final retrieved = await repo.getConnection(creatorId);
        expect(retrieved?.username, 'ananya_fitness');
      },
    );

    test(
      'Refreshing connection updates timestamp and follower metrics',
      () async {
        final repo = DemoInstagramRepository();
        final initial = await repo.getConnection('demo_creator_user_id');
        final initialFollowers = initial!.followersCount!;

        final refreshed = await repo.refreshConnection('demo_creator_user_id');
        expect(refreshed.followersCount, greaterThan(initialFollowers));
      },
    );

    test(
      'Disconnecting Instagram account revokes access and cleans media',
      () async {
        final repo = DemoInstagramRepository();
        await repo.disconnectInstagram('demo_creator_user_id');

        final conn = await repo.getConnection('demo_creator_user_id');
        expect(conn, isNull);

        final media = await repo.getRecentMedia('demo_creator_user_id');
        expect(media.isEmpty, isTrue);
      },
    );
  });
}
