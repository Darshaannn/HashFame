import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/contact_models.dart';
import 'widgets/submit_quotation_dialog.dart';

class CreatorContactRequestsScreen extends ConsumerStatefulWidget {
  const CreatorContactRequestsScreen({super.key});

  @override
  ConsumerState<CreatorContactRequestsScreen> createState() =>
      _CreatorContactRequestsScreenState();
}

class _CreatorContactRequestsScreenState
    extends ConsumerState<CreatorContactRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CreatorContactRequest> _requests = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadRequests() async {
    setState(() => _loading = true);
    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(contactOutreachRepositoryProvider);
      final creatorId = session.snapshot?.account.id ?? 'demo_creator_user_id';
      final requests = await repo.listCreatorIncomingRequests(creatorId: creatorId);
      if (mounted) {
        setState(() {
          _requests = requests;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact & Quotation Requests',
          style: TextStyle(
            fontFamily: AppTypography.khandFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.burgundy,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.burgundy,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'All'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildList(_requests.where((r) => r.status == ContactRequestStatus.pending).toList()),
                _buildList(_requests.where((r) => r.status == ContactRequestStatus.accepted).toList()),
                _buildList(_requests),
              ],
            ),
    );
  }

  Widget _buildList(List<CreatorContactRequest> list) {
    if (list.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: AppColors.outline),
            SizedBox(height: 16),
            Text(
              'No requests in this tab',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Brands and Agencies will send collaboration and quotation requests here.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRequests,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (ctx, i) {
          final req = list[i];
          return _IncomingCard(request: req, onRefresh: _loadRequests);
        },
      ),
    );
  }
}

class _IncomingCard extends ConsumerWidget {
  const _IncomingCard({required this.request, required this.onRefresh});

  final CreatorContactRequest request;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusColor = switch (request.status) {
      ContactRequestStatus.pending => AppColors.warning,
      ContactRequestStatus.accepted => AppColors.success,
      ContactRequestStatus.declined => AppColors.error,
      ContactRequestStatus.cancelled => Colors.grey,
      ContactRequestStatus.expired => Colors.grey,
    };

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.burgundy.withOpacity(0.1),
                  child: Text(
                    request.senderOrganizationName.isNotEmpty
                        ? request.senderOrganizationName[0].toUpperCase()
                        : 'B',
                    style: const TextStyle(
                      fontFamily: AppTypography.khandFont,
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.senderOrganizationName,
                        style: const TextStyle(
                          fontFamily: AppTypography.khandFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        request.campaignName ?? 'Collaboration Inquiry',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    request.status.name.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              request.collaborationRequirement,
              style: const TextStyle(fontSize: 13),
            ),
            if (request.personalMessage != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '"${request.personalMessage}"',
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (request.status == ContactRequestStatus.pending) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
                    onPressed: () => _decline(context, ref),
                    child: const Text('Decline'),
                  ),
                  const SizedBox(width: 8),
                  if (request.requestType == ContactRequestType.requestQuotation)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.burgundy,
                        foregroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (ctx) => SubmitQuotationDialog(
                            requestId: request.id,
                            senderOrganizationName: request.senderOrganizationName,
                            campaignName: request.campaignName,
                          ),
                        ).then((_) => onRefresh());
                      },
                      child: const Text('Submit Quotation'),
                    ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: () => _accept(context, ref),
                    child: const Text('Accept & Chat'),
                  ),
                ],
              ),
            ] else if (request.status == ContactRequestStatus.accepted &&
                request.conversationId != null) ...[
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.burgundy,
                    foregroundColor: AppColors.white,
                  ),
                  icon: const Icon(Icons.chat_bubble_outline, size: 16),
                  label: const Text('Open Chat'),
                  onPressed: () {
                    context.push('/outreach/chat/${request.conversationId!}');
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _accept(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(contactOutreachRepositoryProvider);
    final session = ref.read(sessionProvider);
    final creatorId = session.snapshot?.account.id ?? 'demo_creator_user_id';
    try {
      final updatedReq = await repo.acceptContactRequest(
        requestId: request.id,
        creatorUserId: creatorId,
      );
      onRefresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.success,
            content: Text('Request accepted! Chat channel created.'),
          ),
        );
        if (updatedReq.conversationId != null) {
          context.push('/outreach/chat/${updatedReq.conversationId!}');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: AppColors.error, content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _decline(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(contactOutreachRepositoryProvider);
    try {
      await repo.declineContactRequest(requestId: request.id, reason: 'Not available currently');
      onRefresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request declined.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: AppColors.error, content: Text('Error: $e')),
        );
      }
    }
  }
}
