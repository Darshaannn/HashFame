import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/tokens.dart';
import '../../data/external_communication_launcher.dart';
import '../../domain/contact_models.dart';
import 'contact_request_dialog.dart';

class ContactCreatorBottomSheet extends ConsumerStatefulWidget {
  const ContactCreatorBottomSheet({
    super.key,
    required this.creatorId,
    required this.displayName,
    this.avatarPath,
    required this.isRegistered,
    this.instagramHandle,
    this.email,
    this.phone,
    this.whatsapp,
  });

  final String creatorId;
  final String displayName;
  final String? avatarPath;
  final bool isRegistered;
  final String? instagramHandle;
  final String? email;
  final String? phone;
  final String? whatsapp;

  static Future<void> show(
    BuildContext context, {
    required String creatorId,
    required String displayName,
    String? avatarPath,
    required bool isRegistered,
    String? instagramHandle,
    String? email,
    String? phone,
    String? whatsapp,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ContactCreatorBottomSheet(
        creatorId: creatorId,
        displayName: displayName,
        avatarPath: avatarPath,
        isRegistered: isRegistered,
        instagramHandle: instagramHandle,
        email: email,
        phone: phone,
        whatsapp: whatsapp,
      ),
    );
  }

  @override
  ConsumerState<ContactCreatorBottomSheet> createState() => _ContactCreatorBottomSheetState();
}

class _ContactCreatorBottomSheetState extends ConsumerState<ContactCreatorBottomSheet> {
  CreatorContactPreferences? _preferences;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isRegistered) {
      _loadPreferences();
    }
  }

  Future<void> _loadPreferences() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(contactOutreachRepositoryProvider);
      final prefs = await repo.getCreatorContactPreferences(widget.creatorId);
      if (mounted) {
        setState(() {
          _preferences = prefs;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : AppColors.white;

    // Contact info resolution
    final effectiveEmail = _preferences?.allowBusinessEmail == true
        ? _preferences?.businessEmail
        : widget.email;
    final effectivePhone = _preferences?.allowPhone == true
        ? _preferences?.phoneNumber
        : widget.phone;
    final effectiveWhatsapp = _preferences?.allowWhatsapp == true
        ? _preferences?.whatsappNumber
        : widget.whatsapp;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.burgundy.withValues(alpha: 0.1),
                child: Text(
                  widget.displayName.isNotEmpty ? widget.displayName[0].toUpperCase() : 'C',
                  style: const TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontWeight: FontWeight.bold,
                    color: AppColors.burgundy,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.displayName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontFamily: AppTypography.khandFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.isRegistered
                          ? 'Registered Creator • Direct Outreach Available'
                          : 'Directory Influencer • External Outreach',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: widget.isRegistered ? AppColors.success : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),

          if (_loading)
            const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
          else ...[
            if (widget.isRegistered) ...[
              _ActionTile(
                icon: Icons.send_rounded,
                iconColor: AppColors.burgundy,
                title: 'Send Collaboration Proposal',
                subtitle: 'Submit campaign requirements and timeline directly to creator',
                onTap: () {
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => ContactRequestDialog(
                      recipientCreatorId: widget.creatorId,
                      recipientDisplayName: widget.displayName,
                      recipientAvatarPath: widget.avatarPath,
                      isRegistered: true,
                      initialRequestType: ContactRequestType.brandCollaboration,
                    ),
                  );
                },
              ),
              _ActionTile(
                icon: Icons.request_quote_rounded,
                iconColor: AppColors.burgundy,
                title: 'Request Private Quotation',
                subtitle: 'Ask for custom pricing and deliverables tailored to your brief',
                onTap: () {
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => ContactRequestDialog(
                      recipientCreatorId: widget.creatorId,
                      recipientDisplayName: widget.displayName,
                      recipientAvatarPath: widget.avatarPath,
                      isRegistered: true,
                      initialRequestType: ContactRequestType.requestQuotation,
                    ),
                  );
                },
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.burgundy.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.burgundy.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.burgundy, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This creator has not claimed their GGs profile yet. Connect directly via their verified social channels.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: AppTypography.hindFont,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Direct External Channels
            if (widget.instagramHandle != null && widget.instagramHandle!.isNotEmpty)
              _ActionTile(
                icon: Icons.camera_alt_outlined,
                iconColor: const Color(0xFFE1306C),
                title: 'Instagram Profile',
                subtitle: '@${widget.instagramHandle!.replaceAll('@', '')}',
                onTap: () => ExternalCommunicationLauncher.openInstagram(widget.instagramHandle!),
              ),

            if (effectiveWhatsapp != null && effectiveWhatsapp.isNotEmpty)
              _ActionTile(
                icon: Icons.chat_bubble_outline,
                iconColor: const Color(0xFF25D366),
                title: 'WhatsApp Message',
                subtitle: effectiveWhatsapp,
                onTap: () => ExternalCommunicationLauncher.openWhatsApp(
                  phone: effectiveWhatsapp,
                  message: 'Hello ${widget.displayName}, we discovered your profile on GGs and would love to collaborate!',
                ),
              ),

            if (effectiveEmail != null && effectiveEmail.isNotEmpty)
              _ActionTile(
                icon: Icons.email_outlined,
                iconColor: Colors.blueAccent,
                title: 'Business Email',
                subtitle: effectiveEmail,
                onTap: () => ExternalCommunicationLauncher.openEmail(
                  email: effectiveEmail,
                  subject: 'Collaboration Enquiry via GGs',
                  body: 'Hello ${widget.displayName},\n\nWe are interested in collaborating with you...',
                ),
              ),

            if (effectivePhone != null && effectivePhone.isNotEmpty)
              _ActionTile(
                icon: Icons.phone_outlined,
                iconColor: Colors.green,
                title: 'Call Direct',
                subtitle: effectivePhone,
                onTap: () => ExternalCommunicationLauncher.openPhoneDialer(effectivePhone),
              ),
          ],
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: AppTypography.khandFont,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontFamily: AppTypography.hindFont,
          fontSize: 12,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      onTap: onTap,
    );
  }
}
