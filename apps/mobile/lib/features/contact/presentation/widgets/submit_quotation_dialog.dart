import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../auth/presentation/session_controller.dart';

class SubmitQuotationDialog extends ConsumerStatefulWidget {
  const SubmitQuotationDialog({
    super.key,
    required this.requestId,
    required this.senderOrganizationName,
    this.campaignName,
  });

  final String requestId;
  final String senderOrganizationName;
  final String? campaignName;

  @override
  ConsumerState<SubmitQuotationDialog> createState() =>
      _SubmitQuotationDialogState();
}

class _SubmitQuotationDialogState extends ConsumerState<SubmitQuotationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _deliverableController = TextEditingController();
  final _usageRightsController = TextEditingController(
    text: 'Digital Organic & 30 Days Repost',
  );
  final _timelineController = TextEditingController();
  final _notesController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _deliverableController.dispose();
    _usageRightsController.dispose();
    _timelineController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(contactOutreachRepositoryProvider);
      final creatorId = session.snapshot?.account.id ?? 'demo_creator_user_id';
      final amount = double.parse(
        _amountController.text.trim().replaceAll(',', ''),
      );

      await repo.submitPrivateQuotation(
        requestId: widget.requestId,
        creatorId: creatorId,
        proposedAmount: amount,
        currency: 'INR',
        deliverableDescription: _deliverableController.text.trim(),
        usageRights: _usageRightsController.text.trim().isEmpty
            ? null
            : _usageRightsController.text.trim(),
        timeline: _timelineController.text.trim().isEmpty
            ? null
            : _timelineController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.burgundy,
            content: Text('Private quotation submitted securely!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.error,
            content: Text('Error: $e'),
          ),
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
                    const Icon(
                      Icons.request_quote_rounded,
                      color: AppColors.burgundy,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Submit Private Quotation',
                        style: const TextStyle(
                          fontFamily: AppTypography.khandFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'For ${widget.senderOrganizationName} • ${widget.campaignName ?? 'Custom Request'}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Proposed Amount (₹ INR) *',
                    hintText: 'e.g. 45000',
                    prefixText: '₹ ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Enter proposed amount';
                    }
                    final num = double.tryParse(v.trim().replaceAll(',', ''));
                    if (num == null || num <= 0) {
                      return 'Enter a valid positive amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _deliverableController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Included Deliverables *',
                    hintText: 'e.g. 1 Reel (60s) + 2 Stories with link',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().length < 2)
                      ? 'Please specify what is included'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _usageRightsController,
                  decoration: const InputDecoration(
                    labelText: 'Usage Rights',
                    hintText: 'e.g. Digital Organic, 30 Days Ads',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _timelineController,
                  decoration: const InputDecoration(
                    labelText: 'Estimated Turnaround Time',
                    hintText: 'e.g. 5 business days after product delivery',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Terms / Notes',
                    hintText: 'e.g. Includes 1 revision round',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _submitting
                          ? null
                          : () => Navigator.pop(context),
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
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Submit Quotation'),
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
