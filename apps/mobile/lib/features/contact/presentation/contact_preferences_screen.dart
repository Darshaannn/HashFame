import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/contact_models.dart';

class ContactPreferencesScreen extends ConsumerStatefulWidget {
  const ContactPreferencesScreen({super.key});

  @override
  ConsumerState<ContactPreferencesScreen> createState() => _ContactPreferencesScreenState();
}

class _ContactPreferencesScreenState extends ConsumerState<ContactPreferencesScreen> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  bool _allowCollabs = true;
  bool _allowEmail = false;
  bool _allowPhone = false;
  bool _allowWhatsapp = false;
  OutreachContactMethod _preferredMethod = OutreachContactMethod.inApp;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    setState(() => _loading = true);
    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(contactOutreachRepositoryProvider);
      final creatorId = session.snapshot?.account.id ?? 'demo_creator_user_id';
      final prefs = await repo.getCreatorContactPreferences(creatorId);

      if (mounted) {
        setState(() {
          _allowCollabs = prefs.allowCollaborationRequests;
          _allowEmail = prefs.allowBusinessEmail;
          _emailController.text = prefs.businessEmail ?? '';
          _allowPhone = prefs.allowPhone;
          _phoneController.text = prefs.phoneNumber ?? '';
          _allowWhatsapp = prefs.allowWhatsapp;
          _whatsappController.text = prefs.whatsappNumber ?? '';
          _preferredMethod = prefs.preferredContactMethod;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final session = ref.read(sessionProvider);
      final repo = ref.read(contactOutreachRepositoryProvider);
      final creatorId = session.snapshot?.account.id ?? 'demo_creator_user_id';

      final prefs = CreatorContactPreferences(
        creatorId: creatorId,
        allowCollaborationRequests: _allowCollabs,
        allowBusinessEmail: _allowEmail,
        businessEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        allowPhone: _allowPhone,
        phoneNumber: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        allowWhatsapp: _allowWhatsapp,
        whatsappNumber: _whatsappController.text.trim().isEmpty ? null : _whatsappController.text.trim(),
        preferredContactMethod: _preferredMethod,
      );

      await repo.updateCreatorContactPreferences(prefs);

      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.burgundy,
            content: Text('Contact preferences saved!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: AppColors.error, content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact & Outreach Privacy',
          style: TextStyle(
            fontFamily: AppTypography.khandFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SwitchListTile(
                  title: const Text('Accept Collaboration Requests', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Allow Brands & Agencies to send you direct proposals on GGs'),
                  value: _allowCollabs,
                  activeColor: AppColors.burgundy,
                  onChanged: (val) => setState(() => _allowCollabs = val),
                ),
                const Divider(height: 24),
                const Text(
                  'Direct Contact Channels (Optional)',
                  style: TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'These contact details will only be visible to verified brands and agencies when enabled.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Expose Business Email'),
                  value: _allowEmail,
                  activeColor: AppColors.burgundy,
                  onChanged: (val) => setState(() => _allowEmail = val),
                ),
                if (_allowEmail)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Business Email',
                        hintText: 'e.g. contact@creator.com',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                SwitchListTile(
                  title: const Text('Expose WhatsApp Number'),
                  value: _allowWhatsapp,
                  activeColor: AppColors.burgundy,
                  onChanged: (val) => setState(() => _allowWhatsapp = val),
                ),
                if (_allowWhatsapp)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: _whatsappController,
                      decoration: const InputDecoration(
                        labelText: 'WhatsApp Number with Country Code',
                        hintText: '+91 98765 43210',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                SwitchListTile(
                  title: const Text('Expose Phone Number (Direct Calling)'),
                  value: _allowPhone,
                  activeColor: AppColors.burgundy,
                  onChanged: (val) => setState(() => _allowPhone = val),
                ),
                if (_allowPhone)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '+91 98765 43210',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.burgundy,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
                        )
                      : const Text('Save Preferences', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
    );
  }
}
