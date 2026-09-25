import 'package:freezed_annotation/freezed_annotation.dart';

import 'campaign.dart';

part 'campaign_opportunity_item.freezed.dart';
part 'campaign_opportunity_item.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class CampaignOpportunityItem with _$CampaignOpportunityItem {
  const factory CampaignOpportunityItem({
    required String campaignId,
    required String organizationId,
    required String title,
    required String brandName,
    String? brandLogoUrl,
    required CampaignCompensationType compensationType,
    @Default('INR') String currency,
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    @Default(1) int creatorSlots,
    @Default([]) List<String> categoryNames,
    @Default([]) List<String> languageNames,
    @Default([]) List<String> platforms,
    @Default(0) int deliverableCount,
    String? targetCity,
    String? targetState,
    @Default('IN') String targetCountry,
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? publishedAt,
    String? myApplicationStatus,
    String? myApplicationId,
  }) = _CampaignOpportunityItem;

  factory CampaignOpportunityItem.fromJson(Map<String, dynamic> json) =>
      _$CampaignOpportunityItemFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class CampaignSearchFilters with _$CampaignSearchFilters {
  const factory CampaignSearchFilters({
    @Default('') String query,
    @Default([]) List<String> categoryIds,
    @Default([]) List<String> languageCodes,
    @Default([]) List<String> platforms,
    CampaignCompensationType? compensationType,
    double? minBudget,
    double? maxBudget,
    String? city,
    String? state,
    String? country,
    bool? onlyAvailableSlots,
  }) = _CampaignSearchFilters;

  factory CampaignSearchFilters.fromJson(Map<String, dynamic> json) =>
      _$CampaignSearchFiltersFromJson(json);
}

extension CampaignSearchFiltersExtension on CampaignSearchFilters {
  bool get hasActiveFilters =>
      query.isNotEmpty ||
      categoryIds.isNotEmpty ||
      languageCodes.isNotEmpty ||
      platforms.isNotEmpty ||
      compensationType != null ||
      minBudget != null ||
      maxBudget != null ||
      (city != null && city!.isNotEmpty) ||
      (state != null && state!.isNotEmpty);

  int get activeFilterCount {
    var count = 0;
    if (query.isNotEmpty) count++;
    if (categoryIds.isNotEmpty) count += categoryIds.length;
    if (languageCodes.isNotEmpty) count += languageCodes.length;
    if (platforms.isNotEmpty) count += platforms.length;
    if (compensationType != null) count++;
    if (minBudget != null || maxBudget != null) count++;
    if (city != null && city!.isNotEmpty) count++;
    if (state != null && state!.isNotEmpty) count++;
    return count;
  }
}
