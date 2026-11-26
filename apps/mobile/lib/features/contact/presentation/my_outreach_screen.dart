import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/contact_models.dart';

class MyOutreachScreen extends ConsumerStatefulWidget {
  const MyOutreachScreen({super.key});

  @override
  ConsumerState<MyOutreachScreen> createState() => _MyOutreachScreenState();
}

class _MyOutreachScreenState extends ConsumerState<MyOutreachScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CreatorContactRequest> _requests = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      final userId = session.snapshot?.account.id ?? 'demo_brand_user_id';
      final requests = await repo.listSentOutreach(userId: userId);
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
          'My Outreach',
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
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Quotations'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildRequestList(_requests),
                _buildRequestList(
                  _requests
                      .where((r) => r.status == ContactRequestStatus.pending)
                      .toList(),
                ),
                _buildRequestList(
                  _requests
                      .where((r) => r.status == ContactRequestStatus.accepted)
                      .toList(),
                ),
                _buildRequestList(
                  _requests
                      .where(
                        (r) =>
                            r.requestType ==
                            ContactRequestType.requestQuotation,
                      )
                      .toList(),
                ),
              ],
            ),
    );
  }

  Widget _buildRequestList(List<CreatorContactRequest> list) {
    if (list.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send_rounded, size: 64, color: AppColors.outline),
            SizedBox(height: 16),
            Text(
              'No outreach requests found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Discover creators and send collaboration proposals or quotation requests.',
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
          return _OutreachCard(request: req, onRefresh: _loadRequests);
        },
      ),
    );
  }
}

class _OutreachCard extends ConsumerWidget {
  const _OutreachCard({required this.request, required this.onRefresh});

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
                  backgroundColor: AppColors.burgundy.withValues(alpha: 0.1),
                  child: Text(
                    request.recipientDisplayName.isNotEmpty
                        ? request.recipientDisplayName[0].toUpperCase()
                        : 'C',
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
                        request.recipientDisplayName,
                        style: const TextStyle(
                          fontFamily: AppTypography.khandFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        request.campaignName ?? 'Direct Collaboration Proposal',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
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
                    color: statusColor.withValues(alpha: 0.12),
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sent: ${request.createdAt.day}/${request.createdAt.month}/${request.createdAt.year}',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                Row(
                  children: [
                    if (request.status == ContactRequestStatus.accepted &&
                        request.conversationId != null)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.burgundy,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: const Icon(Icons.chat_bubble_outline, size: 14),
                        label: const Text('Open Chat'),
                        onPressed: () {
                          context.push(
                            '/outreach/chat/${request.conversationId!}',
                          );
                        },
                      ),
                    if (request.requestType ==
                        ContactRequestType.requestQuotation)
                      TextButton.icon(
                        icon: const Icon(Icons.visibility_outlined, size: 14),
                        label: const Text('View Quotation'),
                        onPressed: () =>
                            _showQuotationDialog(context, ref, request.id),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showQuotationDialog(
    BuildContext context,
    WidgetRef ref,
    String requestId,
  ) async {
    final repo = ref.read(contactOutreachRepositoryProvider);
    final quote = await repo.getPrivateQuotation(requestId);

    if (context.mounted) {
      if (quote == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No quotation received yet for this request.'),
          ),
        );
        return;
      }

      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.request_quote_rounded, color: AppColors.burgundy),
              SizedBox(width: 8),
              Text(
                'Private Quotation',
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
              Text(
                '₹${quote.proposedAmount.toStringAsFixed(0)} ${quote.currency}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.burgundy,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Deliverables:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                quote.deliverableDescription,
                style: const TextStyle(fontSize: 13),
              ),
              if (quote.usageRights != null) ...[
                const SizedBox(height: 8),
                const Text(
                  'Usage Rights:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(quote.usageRights!, style: const TextStyle(fontSize: 13)),
              ],
              if (quote.timeline != null) ...[
                const SizedBox(height: 8),
                const Text(
                  'Timeline:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(quote.timeline!, style: const TextStyle(fontSize: 13)),
              ],
              if (quote.notes != null) ...[
                const SizedBox(height: 8),
                const Text(
                  'Notes:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(quote.notes!, style: const TextStyle(fontSize: 13)),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }
}
