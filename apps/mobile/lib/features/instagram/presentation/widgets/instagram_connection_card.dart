import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../auth/presentation/session_controller.dart';
import '../../domain/instagram_models.dart';

class InstagramConnectionCard extends ConsumerStatefulWidget {
  const InstagramConnectionCard({super.key});

  @override
  ConsumerState<InstagramConnectionCard> createState() =>
      _InstagramConnectionCardState();
}

class _InstagramConnectionCardState
    extends ConsumerState<InstagramConnectionCard> {
  InstagramConnectedProfile? _profile;
  List<InstagramMediaItem> _media = [];
  bool _loading = true;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _loadConnection();
  }

  Future<void> _loadConnection() async {
    setState(() => _loading = true);
    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(instagramRepositoryProvider);
      final creatorId = session.snapshot?.account.id ?? 'demo_creator_user_id';
      final conn = await repo.getConnection(creatorId);
      List<InstagramMediaItem> media = [];
      if (conn != null) {
        media = await repo.getRecentMedia(creatorId);
      }
      if (mounted) {
        setState(() {
          _profile = conn;
          _media = media;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _connect() async {
    final handleCtrl = TextEditingController();
    final shouldConnect = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.camera_alt_outlined, color: AppColors.burgundy),
            SizedBox(width: 8),
            Text(
              'Connect Professional Instagram',
              style: TextStyle(
                fontFamily: AppTypography.khandFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'GGs connects via official Meta Instagram Login. We request basic profile details and media to display on your verified portfolio.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: handleCtrl,
              decoration: const InputDecoration(
                labelText: 'Instagram Handle',
                hintText: '@yourhandle',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.burgundy,
              foregroundColor: AppColors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Authorize via Meta'),
          ),
        ],
      ),
    );

    if (shouldConnect == true && handleCtrl.text.trim().isNotEmpty) {
      setState(() => _busy = true);
      try {
        final session = ref.read(sessionProvider);
        final repo = ref.read(instagramRepositoryProvider);
        final creatorId =
            session.snapshot?.account.id ?? 'demo_creator_user_id';
        await repo.connectInstagram(
          creatorId: creatorId,
          username: handleCtrl.text.trim(),
        );
        await _loadConnection();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.success,
              content: Text(
                'Instagram account connected and verified via official Meta API!',
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text('Connection error: $e'),
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _busy = false);
      }
    }
  }

  Future<void> _refresh() async {
    setState(() => _busy = true);
    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(instagramRepositoryProvider);
      final creatorId = session.snapshot?.account.id ?? 'demo_creator_user_id';
      await repo.refreshConnection(creatorId);
      await _loadConnection();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Instagram metrics refreshed!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.error,
            content: Text('Refresh error: $e'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _disconnect() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Disconnect Instagram?'),
        content: const Text(
          'This will revoke access and remove your verified follower metrics and media showcase from GGs.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _busy = true);
      try {
        final session = ref.read(sessionProvider);
        final repo = ref.read(instagramRepositoryProvider);
        final creatorId =
            session.snapshot?.account.id ?? 'demo_creator_user_id';
        await repo.disconnectInstagram(creatorId);
        await _loadConnection();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Instagram account disconnected.')),
          );
        }
      } finally {
        if (mounted) setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isConnected =
        _profile != null &&
        _profile!.status == InstagramConnectionStatus.connected;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE1306C),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Official Instagram Connection',
                        style: TextStyle(
                          fontFamily: AppTypography.khandFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        isConnected
                            ? 'Verified Meta Graph API Link'
                            : 'Connect to verify identity & sync metrics',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (isConnected ? AppColors.success : Colors.grey)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isConnected ? 'CONNECTED' : 'NOT CONNECTED',
                    style: TextStyle(
                      color: isConnected ? AppColors.success : Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            if (isConnected) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statColumn('Handle', '@${_profile!.username}'),
                    _statColumn(
                      'Followers',
                      _profile!.followersCount != null
                          ? '${(_profile!.followersCount! / 1000).toStringAsFixed(1)}K'
                          : 'Unverified',
                    ),
                    _statColumn('Posts', '${_profile!.mediaCount}'),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              if (_media.isNotEmpty) ...[
                const Text(
                  'Recent Portfolio Media',
                  style: TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _media.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (ctx, i) {
                      final m = _media[i];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 90,
                          color: AppColors.surfaceSubtle,
                          child: m.thumbnailUrl != null
                              ? Image.network(
                                  m.thumbnailUrl!,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(Icons.image, color: Colors.grey),
                                ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.sync, size: 14),
                    label: const Text('Refresh'),
                    onPressed: _busy ? null : _refresh,
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.error,
                    ),
                    icon: const Icon(Icons.link_off, size: 14),
                    label: const Text('Disconnect'),
                    onPressed: _busy ? null : _disconnect,
                  ),
                ],
              ),
            ] else ...[
              const Text(
                'Connecting your Instagram professional account enables brands to see your verified audience size and official media showcase directly on GGs.',
                style: TextStyle(fontSize: 12, color: AppColors.secondaryGray),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.burgundy,
                  foregroundColor: AppColors.white,
                ),
                icon: const Icon(Icons.link, size: 16),
                label: const Text('Connect Instagram Account'),
                onPressed: _busy ? null : _connect,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
