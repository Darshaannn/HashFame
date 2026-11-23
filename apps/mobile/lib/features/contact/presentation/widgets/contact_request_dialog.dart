import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../auth/presentation/session_controller.dart';
import '../../domain/contact_models.dart';

class ContactRequestDialog extends ConsumerStatefulWidget {
  const ContactRequestDialog({
    super.key,
    this.recipientCreatorId,
    this.recipientDirectoryId,
    required this.recipientDisplayName,
    this.recipientAvatarPath,
    required this.isRegistered,
    this.initialRequestType = ContactRequestType.brandCollaboration,
  });

  final String? recipientCreatorId;
  final String? recipientDirectoryId;
  final String recipientDisplayName;
  final String? recipientAvatarPath;
  final bool isRegistered;
  final ContactRequestType initialRequestType;

  @override
  ConsumerState<ContactRequestDialog> createState() => _ContactRequestDialogState();
}

class _ContactRequestDialogState extends ConsumerState<ContactRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  late ContactRequestType _requestType;
  final _campaignNameController = TextEditingController();
  final _requirementController = TextEditingController();
  final _timelineController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _requestType = widget.initialRequestType;
  }

  @override
  void dispose() {
    _campaignNameController.dispose();
    _requirementController.dispose();
    _timelineController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(contactOutreachRepositoryProvider);
      final senderId = session.snapshot?.account.id ?? 'sender_id';
      final senderOrgName = session.snapshot?.account.primaryRoleLabel?.wire == 'agency'
          ? 'Agency Partner'
          : 'Brand Partner';

      await repo.sendContactRequest(
        senderUserId: senderId,
        senderOrganizationName: senderOrgName,
        recipientCreatorId: widget.recipientCreatorId,
        recipientDirectoryId: widget.recipientDirectoryId,
        recipientDisplayName: widget.recipientDisplayName,
        recipientAvatarPath: widget.recipientAvatarPath,
        isRegisteredCreator: widget.isRegistered,
        requestType: _requestType,
        campaignName: _campaignNameController.text.trim().isEmpty
            ? null
            : _campaignNameController.text.trim(),
        collaborationRequirement: _requirementController.text.trim(),
        expectedTimeline: _timelineController.text.trim().isEmpty
            ? null
            : _timelineController.text.trim(),
        personalMessage: _messageController.text.trim().isEmpty
            ? null
            : _messageController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.burgundy,
            content: Text('Contact request sent to ${widget.recipientDisplayName}!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: AppColors.error, content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    const Icon(Icons.send_rounded, color: AppColors.burgundy, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Contact ${widget.recipientDisplayName}',
                        style: const TextStyle(
                          fontFamily: AppTypography.khandFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ContactRequestType>(
                  value: _requestType,
                  decoration: const InputDecoration(
                    labelText: 'Request Purpose',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: ContactRequestType.brandCollaboration,
                      child: Text('Brand Collaboration'),
                    ),
                    DropdownMenuItem(
                      value: ContactRequestType.requestQuotation,
                      child: Text('Request Private Quotation'),
                    ),
                    DropdownMenuItem(
                      value: ContactRequestType.paidPartnership,
                      child: Text('Paid Partnership'),
                    ),
                    DropdownMenuItem(
                      value: ContactRequestType.barterCollaboration,
                      child: Text('Barter Collaboration'),
                    ),
                    DropdownMenuItem(
                      value: ContactRequestType.ugcRequirement,
                      child: Text('UGC Content Creation'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _requestType = val);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _campaignNameController,
                  decoration: const InputDecoration(
                    labelText: 'Campaign or Project Name',
                    hintText: 'e.g. Festive Launch 2026',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _requirementController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Deliverables & Requirement *',
                    hintText: 'e.g. 1 Reel (60s), 2 Instagram Stories with link...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().length < 5)
                      ? 'Please enter detailed requirements (min 5 chars)'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _timelineController,
                  decoration: const InputDecoration(
                    labelText: 'Expected Timeline',
                    hintText: 'e.g. Within next 2 weeks',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _messageController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Personal Note',
                    hintText: 'Why this creator is a great fit...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _submitting ? null : () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.burgundy,
                        foregroundColor: AppColors.white,
                      ),
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
                            )
                          : const Text('Send Request'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
