// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Account _$AccountFromJson(Map<String, dynamic> json) => _Account(
  id: json['id'] as String,
  displayName: json['display_name'] as String,
  primaryRoleLabel: $enumDecodeNullable(
    _$ProfessionalRoleEnumMap,
    json['primary_role_label'],
  ),
  accountState: $enumDecode(_$AccountStateEnumMap, json['account_state']),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  avatarPath: json['avatar_path'] as String?,
);

Map<String, dynamic> _$AccountToJson(_Account instance) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'primary_role_label': _$ProfessionalRoleEnumMap[instance.primaryRoleLabel],
  'account_state': _$AccountStateEnumMap[instance.accountState]!,
  'updated_at': instance.updatedAt.toIso8601String(),
  'avatar_path': instance.avatarPath,
};

const _$ProfessionalRoleEnumMap = {
  ProfessionalRole.creator: 'creator',
  ProfessionalRole.brandMarketer: 'brand_marketer',
  ProfessionalRole.agency: 'agency',
  ProfessionalRole.talentManager: 'talent_manager',
  ProfessionalRole.admin: 'admin',
};

const _$AccountStateEnumMap = {
  AccountState.onboarding: 'onboarding',
  AccountState.active: 'active',
  AccountState.blocked: 'blocked',
  AccountState.deletionRequested: 'deletion_requested',
};

_AccountSettings _$AccountSettingsFromJson(Map<String, dynamic> json) =>
    _AccountSettings(
      locale: json['locale'] as String? ?? 'en',
      themePreference: json['theme_preference'] as String? ?? 'system',
      notificationPreferences: json['notification_preferences'] == null
          ? const NotificationPreferences()
          : NotificationPreferences.fromJson(
              json['notification_preferences'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AccountSettingsToJson(_AccountSettings instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'theme_preference': instance.themePreference,
      'notification_preferences': instance.notificationPreferences.toJson(),
    };

_NotificationPreferences _$NotificationPreferencesFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferences(
  productUpdates: json['product_updates'] as bool? ?? false,
  securityAlerts: json['security_alerts'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationPreferencesToJson(
  _NotificationPreferences instance,
) => <String, dynamic>{
  'product_updates': instance.productUpdates,
  'security_alerts': instance.securityAlerts,
};
