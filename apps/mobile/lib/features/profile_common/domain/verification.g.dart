// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FieldVerification _$FieldVerificationFromJson(Map<String, dynamic> json) =>
    _FieldVerification(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      subject: $enumDecode(_$VerificationSubjectEnumMap, json['subject']),
      subjectId: json['subject_id'] as String? ?? '',
      status: $enumDecode(_$FieldVerificationStatusEnumMap, json['status']),
      verifiedAt: json['verified_at'] == null
          ? null
          : DateTime.parse(json['verified_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$FieldVerificationToJson(_FieldVerification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'subject': _$VerificationSubjectEnumMap[instance.subject]!,
      'subject_id': instance.subjectId,
      'status': _$FieldVerificationStatusEnumMap[instance.status]!,
      'verified_at': instance.verifiedAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'notes': instance.notes,
    };

const _$VerificationSubjectEnumMap = {
  VerificationSubject.identity: 'identity',
  VerificationSubject.phone: 'phone',
  VerificationSubject.email: 'email',
  VerificationSubject.socialAccount: 'social_account',
  VerificationSubject.company: 'company',
  VerificationSubject.managerRelationship: 'manager_relationship',
};

const _$FieldVerificationStatusEnumMap = {
  FieldVerificationStatus.notStarted: 'not_started',
  FieldVerificationStatus.pending: 'pending',
  FieldVerificationStatus.verified: 'verified',
  FieldVerificationStatus.rejected: 'rejected',
  FieldVerificationStatus.expired: 'expired',
};

_VerificationSummary _$VerificationSummaryFromJson(Map<String, dynamic> json) =>
    _VerificationSummary(
      identityStatus:
          $enumDecodeNullable(
            _$FieldVerificationStatusEnumMap,
            json['identity_status'],
          ) ??
          FieldVerificationStatus.notStarted,
      emailStatus:
          $enumDecodeNullable(
            _$FieldVerificationStatusEnumMap,
            json['email_status'],
          ) ??
          FieldVerificationStatus.notStarted,
      phoneStatus:
          $enumDecodeNullable(
            _$FieldVerificationStatusEnumMap,
            json['phone_status'],
          ) ??
          FieldVerificationStatus.notStarted,
      socialStatus:
          $enumDecodeNullable(
            _$FieldVerificationStatusEnumMap,
            json['social_status'],
          ) ??
          FieldVerificationStatus.notStarted,
      managerStatus:
          $enumDecodeNullable(
            _$FieldVerificationStatusEnumMap,
            json['manager_status'],
          ) ??
          FieldVerificationStatus.notStarted,
      companyStatus:
          $enumDecodeNullable(
            _$FieldVerificationStatusEnumMap,
            json['company_status'],
          ) ??
          FieldVerificationStatus.notStarted,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => FieldVerification.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$VerificationSummaryToJson(
  _VerificationSummary instance,
) => <String, dynamic>{
  'identity_status': _$FieldVerificationStatusEnumMap[instance.identityStatus]!,
  'email_status': _$FieldVerificationStatusEnumMap[instance.emailStatus]!,
  'phone_status': _$FieldVerificationStatusEnumMap[instance.phoneStatus]!,
  'social_status': _$FieldVerificationStatusEnumMap[instance.socialStatus]!,
  'manager_status': _$FieldVerificationStatusEnumMap[instance.managerStatus]!,
  'company_status': _$FieldVerificationStatusEnumMap[instance.companyStatus]!,
  'items': instance.items.map((e) => e.toJson()).toList(),
};
