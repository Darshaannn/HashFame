import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

enum ExternalCommunicationType {
  instagram,
  whatsapp,
  email,
  phone,
}

class ExternalCommunicationLauncher {
  const ExternalCommunicationLauncher._();

  /// Formats an international phone number (e.g. +91 98765 43210 -> +919876543210)
  static String cleanPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  }

  /// Launch creator's Instagram profile
  static Future<bool> openInstagram(String handle) async {
    final cleanHandle = handle.replaceAll('@', '').trim();
    if (cleanHandle.isEmpty) return false;
    final url = Uri.parse('https://www.instagram.com/$cleanHandle/');
    return _launchExternal(url);
  }

  /// Open WhatsApp with a prefilled enquiry message
  static Future<bool> openWhatsApp({
    required String phone,
    required String message,
  }) async {
    final cleanNumber = cleanPhoneNumber(phone).replaceAll('+', '');
    if (cleanNumber.isEmpty) return false;
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('https://wa.me/$cleanNumber?text=$encodedMessage');
    return _launchExternal(url);
  }

  /// Open default email client with prefilled subject and body
  static Future<bool> openEmail({
    required String email,
    required String subject,
    required String body,
  }) async {
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty) return false;
    final uri = Uri(
      scheme: 'mailto',
      path: cleanEmail,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    return _launchExternal(uri);
  }

  /// Open phone dialer (does not initiate call automatically)
  static Future<bool> openPhoneDialer(String phone) async {
    final cleanNumber = cleanPhoneNumber(phone);
    if (cleanNumber.isEmpty) return false;
    final uri = Uri(scheme: 'tel', path: cleanNumber);
    return _launchExternal(uri);
  }

  /// Copy professional enquiry message to clipboard as fallback
  static Future<void> copyMessage(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
  }

  static Future<bool> _launchExternal(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
    return false;
  }
}
