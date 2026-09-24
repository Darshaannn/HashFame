import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification.freezed.dart';
part 'verification.g.dart';

enum FieldVerificationStatus {
  @JsonValue('not_started')
  notStarted,
  pending,
  verified,
  rejected,
  expired;

  String get label => switch (this) {
    notStarted => 'Not Started',
    pending => 'Pending Verification',
    verified => 'Verified',
    rejected => 'Rejected',
    expired => 'Expired',
  };
}

enum VerificationSubject {
  identity,
  phone,
  email,
  @JsonValue('social_account')
  socialAccount,
  company,
  @JsonValue('manager_relationship')
  managerRelationship;

  String get label => switch (this) {
    identity => 'Identity / Govt ID',
    phone => 'Phone Number',
    email => 'Email Address',
    socialAccount => 'Social Account',
    company => 'Registered Company',
    managerRelationship => 'Talent Management',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class FieldVerification with _$FieldVerification {
  const factory FieldVerification({
    required String id,
    required String userId,
    required VerificationSubject subject,
    @Default('') String subjectId,
    required FieldVerificationStatus status,
    DateTime? verifiedAt,
    DateTime? expiresAt,
    String? notes,
  }) = _FieldVerification;

  factory FieldVerification.fromJson(Map<String, dynamic> json) =>
      _$FieldVerificationFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class VerificationSummary with _$VerificationSummary {
  const factory VerificationSummary({
    @Default(FieldVerificationStatus.notStarted) FieldVerificationStatus identityStatus,
    @Default(FieldVerificationStatus.notStarted) FieldVerificationStatus emailStatus,
    @Default(FieldVerificationStatus.notStarted) FieldVerificationStatus phoneStatus,
    @Default(FieldVerificationStatus.notStarted) FieldVerificationStatus socialStatus,
    @Default(FieldVerificationStatus.notStarted) FieldVerificationStatus managerStatus,
    @Default(FieldVerificationStatus.notStarted) FieldVerificationStatus companyStatus,
    @Default([]) List<FieldVerification> items,
  }) = _VerificationSummary;

  factory VerificationSummary.fromJson(Map<String, dynamic> json) =>
      _$VerificationSummaryFromJson(json);
}
