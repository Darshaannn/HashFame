import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_application.freezed.dart';
part 'campaign_application.g.dart';

enum CampaignApplicationStatus {
  @JsonValue('submitted')
  submitted,
  @JsonValue('under_review')
  underReview,
  @JsonValue('shortlisted')
  shortlisted,
  @JsonValue('selected')
  selected,
  @JsonValue('rejected')
  rejected,
  @JsonValue('withdrawn')
  withdrawn,
}

extension CampaignApplicationStatusExtension on CampaignApplicationStatus {
  String get wire => switch (this) {
    CampaignApplicationStatus.submitted => 'submitted',
    CampaignApplicationStatus.underReview => 'under_review',
    CampaignApplicationStatus.shortlisted => 'shortlisted',
    CampaignApplicationStatus.selected => 'selected',
    CampaignApplicationStatus.rejected => 'rejected',
    CampaignApplicationStatus.withdrawn => 'withdrawn',
  };

  String get label => switch (this) {
    CampaignApplicationStatus.submitted => 'Submitted',
    CampaignApplicationStatus.underReview => 'Under Review',
    CampaignApplicationStatus.shortlisted => 'Shortlisted',
    CampaignApplicationStatus.selected => 'Selected',
    CampaignApplicationStatus.rejected => 'Not Selected',
    CampaignApplicationStatus.withdrawn => 'Withdrawn',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class CampaignApplicationStatusHistory
    with _$CampaignApplicationStatusHistory {
  const factory CampaignApplicationStatusHistory({
    required String id,
    required String applicationId,
    CampaignApplicationStatus? fromStatus,
    required CampaignApplicationStatus toStatus,
    String? changedBy,
    String? reason,
    required DateTime createdAt,
  }) = _CampaignApplicationStatusHistory;

  factory CampaignApplicationStatusHistory.fromJson(
    Map<String, dynamic> json,
  ) => _$CampaignApplicationStatusHistoryFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class CampaignApplication with _$CampaignApplication {
  const factory CampaignApplication({
    required String id,
    required String campaignId,
    required String creatorId,
    @Default(CampaignApplicationStatus.submitted)
    CampaignApplicationStatus status,
    required String pitch,
    double? proposedRate,
    @Default('INR') String currency,
    DateTime? reviewedAt,
    DateTime? withdrawnAt,
    required DateTime createdAt,
    DateTime? updatedAt,
    // Joined summary fields for creator or brand viewing
    String? campaignTitle,
    String? brandName,
    String? brandLogoUrl,
    String? creatorDisplayName,
    String? creatorAvatarPath,
    String? creatorCity,
    int? creatorFollowers,
    @Default([]) List<String> creatorPrimaryCategories,
    @Default([]) List<CampaignApplicationStatusHistory> statusHistory,
  }) = _CampaignApplication;

  factory CampaignApplication.fromJson(Map<String, dynamic> json) =>
      _$CampaignApplicationFromJson(json);
}
