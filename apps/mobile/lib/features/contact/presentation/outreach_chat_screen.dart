import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/contact_models.dart';

class OutreachChatScreen extends ConsumerStatefulWidget {
  const OutreachChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  ConsumerState<OutreachChatScreen> createState() => _OutreachChatScreenState();
}

class _OutreachChatScreenState extends ConsumerState<OutreachChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  OutreachConversation? _conversation;
  List<OutreachMessage> _messages = [];
  bool _loading = true;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _loadConversationAndMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadConversationAndMessages() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(contactOutreachRepositoryProvider);
      final conv = await repo.getConversation(widget.conversationId);
      final msgs = await repo.getMessages(widget.conversationId);
      if (mounted) {
        setState(() {
          _conversation = conv;
          _messages = msgs;
          _loading = false;
        });
        _scrollToBottom();
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    _messageController.clear();

    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(contactOutreachRepositoryProvider);
      final userId = session.snapshot?.account.id ?? 'demo_user_id';
      final role = session.snapshot?.account.primaryRoleLabel?.wire ?? 'brand';
      final senderName = role == 'creator'
          ? 'Creator'
          : (role == 'agency' ? 'Agency Partner' : 'Brand Partner');

      final newMsg = await repo.sendMessage(
        conversationId: widget.conversationId,
        senderId: userId,
        senderName: senderName,
        content: text,
      );

      if (mounted) {
        setState(() {
          _messages.add(newMsg);
          _sending = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _sending = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.error,
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.read(sessionProvider);
    final currentUserId = session.snapshot?.account.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _conversation?.subject ?? 'Outreach Chat',
              style: const TextStyle(
                fontFamily: AppTypography.khandFont,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              'Direct Collaboration Discussion',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (ctx, i) {
                      final msg = _messages[i];
                      final isMe =
                          msg.senderId == currentUserId ||
                          (currentUserId.contains('creator') &&
                              msg.senderId.contains('creator')) ||
                          (!currentUserId.contains('creator') &&
                              !msg.senderId.contains('creator'));

                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? AppColors.burgundy
                                : (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.surfaceDark
                                      : AppColors.lightGray),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(14),
                              topRight: const Radius.circular(14),
                              bottomLeft: Radius.circular(isMe ? 14 : 2),
                              bottomRight: Radius.circular(isMe ? 2 : 14),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.senderName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: isMe
                                      ? Colors.white70
                                      : AppColors.secondaryGray,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                msg.content,
                                style: TextStyle(
                                  color: isMe ? Colors.white : AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${msg.createdAt.hour.toString().padLeft(2, '0')}:${msg.createdAt.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isMe ? Colors.white60 : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                            decoration: const InputDecoration(
                              hintText: 'Type your message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: _sending
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.send_rounded,
                                  color: AppColors.burgundy,
                                ),
                          onPressed: _sending ? null : _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
