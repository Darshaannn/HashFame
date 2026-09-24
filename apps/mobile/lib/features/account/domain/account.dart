import 'package:freezed_annotation/freezed_annotation.dart';
part 'account.freezed.dart';
part 'account.g.dart';

enum ProfessionalRole {
  creator,
  @JsonValue('brand_marketer')
  brandMarketer,
  agency,
  @JsonValue('talent_manager')
  talentManager,
  admin;

  String get wire => switch (this) {
    brandMarketer => 'brand_marketer',
    talentManager => 'talent_manager',
    _ => name,
  };
  String get label => switch (this) {
    creator => 'Creator',
    brandMarketer => 'Brand / Marketer',
    agency => 'Agency',
    talentManager => 'Talent Manager',
    admin => 'Admin',
  };
  bool get canSelfRegister => this != admin;
}

enum AccountState {
  onboarding,
  active,
  blocked,
  @JsonValue('deletion_requested')
  deletionRequested,
}

@Freezed(toJson: true, fromJson: true)
abstract class Account with _$Account {
  const Account._();
  const factory Account({
    required String id,
    required String displayName,
    ProfessionalRole? primaryRoleLabel,
    required AccountState accountState,
    required DateTime updatedAt,
    String? avatarPath,
  }) = _Account;
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  bool get canEnterHome =>
      accountState == AccountState.active && primaryRoleLabel != null;
}

@Freezed(toJson: true, fromJson: true)
abstract class AccountSettings with _$AccountSettings {
  const factory AccountSettings({
    @Default('en') String locale,
    @Default('system') String themePreference,
    @Default(NotificationPreferences())
    NotificationPreferences notificationPreferences,
  }) = _AccountSettings;
  factory AccountSettings.fromJson(Map<String, dynamic> json) =>
      _$AccountSettingsFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    @Default(false) bool productUpdates,
    @Default(true) bool securityAlerts,
  }) = _NotificationPreferences;
  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);
}

class AccountSnapshot {
  const AccountSnapshot(
    this.account, {
    required this.fetchedAt,
    this.offline = false,
  });
  final Account account;
  final DateTime fetchedAt;
  final bool offline;
}

String? validateName(String? input) =>
    input == null || input.trim().length < 2 || input.trim().length > 80
    ? 'Enter a name between 2 and 80 characters.'
    : null;
String? validateEmail(String? input) =>
    input == null ||
        input.length > 254 ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(input.trim())
    ? 'Enter a valid email address.'
    : null;
String? validatePhone(String? input) =>
    input == null || !RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(input.trim())
    ? 'Enter a phone number in international format, such as +919876543210.'
    : null;
String? validateOtp(String? input) =>
    input == null || !RegExp(r'^\d{6}$').hasMatch(input.trim())
    ? 'Enter the six-digit code sent to you.'
    : null;
