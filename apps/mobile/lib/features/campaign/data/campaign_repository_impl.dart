import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/campaign.dart';
import '../domain/campaign_application.dart';
import '../domain/campaign_opportunity_item.dart';
import '../domain/campaign_repository.dart';

class SupabaseCampaignDataSource {
  const SupabaseCampaignDataSource(this.client);
  final SupabaseClient client;

  Future<Campaign> createDraft({
    required String organizationId,
    required String title,
    required String description,
    String? objective,
    CampaignCompensationType compensationType = CampaignCompensationType.paid,
    String currency = 'INR',
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    int creatorSlots = 1,
    String? targetCity,
    String? targetState,
    String targetCountry = 'IN',
    int? minFollowers,
    int? maxFollowers,
    List<String> categoryIds = const [],
    List<String> languageCodes = const [],
    List<CampaignDeliverable> deliverables = const [],
    CampaignUsageRights usageRights = const CampaignUsageRights(),
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
    String? additionalRequirements,
  }) async {
    final user = client.auth.currentUser;
    if (user == null) throw StateError('Authentication required');

    final campaignPayload = {
      'organization_id': organizationId,
      'created_by': user.id,
      'title': title,
      'objective': objective,
      'description': description,
      'status': 'draft',
      'compensation_type': compensationType.wire,
      'currency': currency,
      'budget_min': budgetMin,
      'budget_max': budgetMax,
      'barter_value': barterValue,
      'barter_description': barterDescription,
      'creator_slots': creatorSlots,
      'target_city': targetCity,
      'target_state': targetState,
      'target_country': targetCountry,
      'min_followers': minFollowers,
      'max_followers': maxFollowers,
      'organic_reposting_allowed': usageRights.organicRepostingAllowed,
      'paid_usage_required': usageRights.paidUsageRequired,
      'whitelisting_required': usageRights.whitelistingRequired,
      'usage_duration_months': usageRights.usageDurationMonths,
      'usage_territory': usageRights.usageTerritory,
      'exclusivity_required': usageRights.exclusivityRequired,
      'exclusivity_duration_days': usageRights.exclusivityDurationDays,
      'content_approval_required': usageRights.contentApprovalRequired,
      'disclosure_required': usageRights.disclosureRequired,
      'application_deadline': applicationDeadline?.toIso8601String(),
      'content_deadline': contentDeadline?.toIso8601String(),
      'campaign_start_date': campaignStartDate
          ?.toIso8601String()
          .split('T')
          .first,
      'campaign_end_date': campaignEndDate?.toIso8601String().split('T').first,
      'additional_requirements': additionalRequirements,
    };

    final response = await client
        .from('campaigns')
        .insert(campaignPayload)
        .select()
        .single();

    final campaignId = response['id'] as String;

    if (categoryIds.isNotEmpty) {
      final categoryPayloads = categoryIds
          .map((id) => {'campaign_id': campaignId, 'category_id': id})
          .toList();
      await client.from('campaign_categories').insert(categoryPayloads);
    }

    if (languageCodes.isNotEmpty) {
      final langPayloads = languageCodes
          .map((code) => {'campaign_id': campaignId, 'language_code': code})
          .toList();
      await client.from('campaign_languages').insert(langPayloads);
    }

    if (deliverables.isNotEmpty) {
      final deliverablePayloads = deliverables
          .map(
            (d) => {
              'campaign_id': campaignId,
              'deliverable_type': d.deliverableType.wire,
              'platform': d.platform,
              'quantity': d.quantity,
              'description': d.description,
            },
          )
          .toList();
      await client.from('campaign_deliverables').insert(deliverablePayloads);
    }

    return getCampaign(campaignId);
  }

  Future<Campaign> updateDraft({
    required String campaignId,
    String? title,
    String? description,
    String? objective,
    CampaignCompensationType? compensationType,
    String? currency,
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    int? creatorSlots,
    String? targetCity,
    String? targetState,
    String? targetCountry,
    int? minFollowers,
    int? maxFollowers,
    List<String>? categoryIds,
    List<String>? languageCodes,
    List<CampaignDeliverable>? deliverables,
    CampaignUsageRights? usageRights,
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
    String? additionalRequirements,
  }) async {
    final updatePayload = <String, dynamic>{};
    if (title != null) updatePayload['title'] = title;
    if (description != null) updatePayload['description'] = description;
    if (objective != null) {
      updatePayload['objective'] = objective;
    }
    if (compensationType != null) {
      updatePayload['compensation_type'] = compensationType.wire;
    }
    if (currency != null) {
      updatePayload['currency'] = currency;
    }
    if (budgetMin != null) {
      updatePayload['budget_min'] = budgetMin;
    }
    if (budgetMax != null) {
      updatePayload['budget_max'] = budgetMax;
    }
    if (barterValue != null) {
      updatePayload['barter_value'] = barterValue;
    }
    if (barterDescription != null) {
      updatePayload['barter_description'] = barterDescription;
    }
    if (creatorSlots != null) {
      updatePayload['creator_slots'] = creatorSlots;
    }
    if (targetCity != null) {
      updatePayload['target_city'] = targetCity;
    }
    if (targetState != null) {
      updatePayload['target_state'] = targetState;
    }
    if (targetCountry != null) {
      updatePayload['target_country'] = targetCountry;
    }
    if (minFollowers != null) {
      updatePayload['min_followers'] = minFollowers;
    }
    if (maxFollowers != null) {
      updatePayload['max_followers'] = maxFollowers;
    }
    if (usageRights != null) {
      updatePayload['organic_reposting_allowed'] =
          usageRights.organicRepostingAllowed;
      updatePayload['paid_usage_required'] = usageRights.paidUsageRequired;
      updatePayload['whitelisting_required'] = usageRights.whitelistingRequired;
      updatePayload['usage_duration_months'] = usageRights.usageDurationMonths;
      updatePayload['usage_territory'] = usageRights.usageTerritory;
      updatePayload['exclusivity_required'] = usageRights.exclusivityRequired;
      updatePayload['exclusivity_duration_days'] =
          usageRights.exclusivityDurationDays;
      updatePayload['content_approval_required'] =
          usageRights.contentApprovalRequired;
      updatePayload['disclosure_required'] = usageRights.disclosureRequired;
    }
    if (applicationDeadline != null) {
      updatePayload['application_deadline'] = applicationDeadline
          .toIso8601String();
    }
    if (contentDeadline != null) {
      updatePayload['content_deadline'] = contentDeadline.toIso8601String();
    }
    if (campaignStartDate != null) {
      updatePayload['campaign_start_date'] = campaignStartDate
          .toIso8601String()
          .split('T')
          .first;
    }
    if (campaignEndDate != null) {
      updatePayload['campaign_end_date'] = campaignEndDate
          .toIso8601String()
          .split('T')
          .first;
    }
    if (additionalRequirements != null) {
      updatePayload['additional_requirements'] = additionalRequirements;
    }

    if (updatePayload.isNotEmpty) {
      await client.from('campaigns').update(updatePayload).eq('id', campaignId);
    }

    if (categoryIds != null) {
      await client
          .from('campaign_categories')
          .delete()
          .eq('campaign_id', campaignId);
      if (categoryIds.isNotEmpty) {
        final categoryPayloads = categoryIds
            .map((id) => {'campaign_id': campaignId, 'category_id': id})
            .toList();
        await client.from('campaign_categories').insert(categoryPayloads);
      }
    }

    if (languageCodes != null) {
      await client
          .from('campaign_languages')
          .delete()
          .eq('campaign_id', campaignId);
      if (languageCodes.isNotEmpty) {
        final langPayloads = languageCodes
            .map((code) => {'campaign_id': campaignId, 'language_code': code})
            .toList();
        await client.from('campaign_languages').insert(langPayloads);
      }
    }

    if (deliverables != null) {
      await client
          .from('campaign_deliverables')
          .delete()
          .eq('campaign_id', campaignId);
      if (deliverables.isNotEmpty) {
        final deliverablePayloads = deliverables
            .map(
              (d) => {
                'campaign_id': campaignId,
                'deliverable_type': d.deliverableType.wire,
                'platform': d.platform,
                'quantity': d.quantity,
                'description': d.description,
              },
            )
            .toList();
        await client.from('campaign_deliverables').insert(deliverablePayloads);
      }
    }

    return getCampaign(campaignId);
  }

  Future<Campaign> getCampaign(String campaignId) async {
    final response = await client
        .from('campaigns')
        .select('''
          *,
          organizations(name, logo_path),
          campaign_categories(category_id, categories(name)),
          campaign_languages(language_code, languages(name)),
          campaign_deliverables(id, deliverable_type, platform, quantity, description),
          campaign_applications(id, status)
        ''')
        .eq('id', campaignId)
        .single();

    return _mapCampaign(response);
  }

  Future<List<Campaign>> listOrganizationCampaigns({
    required String organizationId,
    CampaignStatus? status,
  }) async {
    var query = client
        .from('campaigns')
        .select('''
          *,
          organizations(name, logo_path),
          campaign_categories(category_id, categories(name)),
          campaign_languages(language_code, languages(name)),
          campaign_deliverables(id, deliverable_type, platform, quantity, description),
          campaign_applications(id, status)
        ''')
        .eq('organization_id', organizationId);

    if (status != null) {
      query = query.eq('status', status.wire);
    }

    final response = await query.order('created_at', ascending: false);
    return (response as List).map((row) => _mapCampaign(row)).toList();
  }

  Future<Campaign> submitForReview(String campaignId) async {
    await client.rpc(
      'submit_campaign_for_review',
      params: {'p_campaign_id': campaignId},
    );
    return getCampaign(campaignId);
  }

  Future<Campaign> pauseCampaign(String campaignId) async {
    await client
        .from('campaigns')
        .update({
          'status': 'paused',
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', campaignId);
    return getCampaign(campaignId);
  }

  Future<Campaign> resumeCampaign(String campaignId) async {
    await client
        .from('campaigns')
        .update({
          'status': 'live',
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', campaignId);
    return getCampaign(campaignId);
  }

  Future<Campaign> closeCampaign(String campaignId) async {
    await client
        .from('campaigns')
        .update({
          'status': 'closed',
          'closed_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', campaignId);
    return getCampaign(campaignId);
  }

  Future<void> deleteDraft(String campaignId) async {
    await client.from('campaigns').delete().eq('id', campaignId);
  }

  Future<Campaign> moderateCampaign({
    required String campaignId,
    required String action,
    String? reason,
  }) async {
    await client.rpc(
      'moderate_campaign',
      params: {
        'p_campaign_id': campaignId,
        'p_action': action,
        'p_reason': reason,
      },
    );
    return getCampaign(campaignId);
  }

  Future<CampaignOpportunitySearchResult> searchLiveCampaigns({
    required CampaignSearchFilters filters,
    int limit = 20,
    int offset = 0,
    String? creatorId,
  }) async {
    var query = client
        .from('campaigns')
        .select('''
          id,
          organization_id,
          title,
          status,
          compensation_type,
          currency,
          budget_min,
          budget_max,
          barter_value,
          barter_description,
          creator_slots,
          target_city,
          target_state,
          target_country,
          application_deadline,
          content_deadline,
          published_at,
          organizations(name, logo_path),
          campaign_categories(category_id, categories(name)),
          campaign_languages(language_code, languages(name)),
          campaign_deliverables(platform),
          campaign_applications(id, creator_id, status)
        ''')
        .eq('status', 'live');

    if (filters.query.isNotEmpty) {
      final q = '%${filters.query}%';
      query = query.or('title.ilike.$q,description.ilike.$q');
    }

    if (filters.compensationType != null) {
      query = query.eq('compensation_type', filters.compensationType!.wire);
    }
    if (filters.city != null && filters.city!.isNotEmpty) {
      query = query.ilike('target_city', '%${filters.city}%');
    }
    if (filters.state != null && filters.state!.isNotEmpty) {
      query = query.ilike('target_state', '%${filters.state}%');
    }

    final response = await query
        .order('published_at', ascending: false)
        .range(offset, offset + limit);

    final rows = response as List;
    final items = <CampaignOpportunityItem>[];

    for (final row in rows) {
      final org = row['organizations'] as Map<String, dynamic>?;
      final cats = (row['campaign_categories'] as List? ?? []);
      final langs = (row['campaign_languages'] as List? ?? []);
      final deliverables = (row['campaign_deliverables'] as List? ?? []);
      final apps = (row['campaign_applications'] as List? ?? []);

      final catNames = cats
          .map(
            (c) =>
                (c['categories'] as Map<String, dynamic>?)?['name']?.toString(),
          )
          .whereType<String>()
          .toList();

      final langNames = langs
          .map(
            (l) =>
                (l['languages'] as Map<String, dynamic>?)?['name']?.toString(),
          )
          .whereType<String>()
          .toList();

      final platforms = deliverables
          .map((d) => d['platform']?.toString())
          .whereType<String>()
          .toSet()
          .toList();

      String? myAppStatus;
      String? myAppId;
      if (creatorId != null) {
        final myApp = apps.cast<Map<String, dynamic>?>().firstWhere(
          (a) => a != null && a['creator_id'] == creatorId,
          orElse: () => null,
        );
        if (myApp != null) {
          myAppStatus = myApp['status']?.toString();
          myAppId = myApp['id']?.toString();
        }
      }

      items.add(
        CampaignOpportunityItem(
          campaignId: row['id'] as String,
          organizationId: row['organization_id'] as String,
          title: row['title'] as String,
          brandName: org?['name'] as String? ?? 'Brand',
          brandLogoUrl: org?['logo_path'] as String?,
          compensationType: _parseCompensationType(
            row['compensation_type'] as String?,
          ),
          currency: row['currency'] as String? ?? 'INR',
          budgetMin: (row['budget_min'] as num?)?.toDouble(),
          budgetMax: (row['budget_max'] as num?)?.toDouble(),
          barterValue: (row['barter_value'] as num?)?.toDouble(),
          barterDescription: row['barter_description'] as String?,
          creatorSlots: row['creator_slots'] as int? ?? 1,
          categoryNames: catNames,
          languageNames: langNames,
          platforms: platforms,
          deliverableCount: deliverables.length,
          targetCity: row['target_city'] as String?,
          targetState: row['target_state'] as String?,
          targetCountry: row['target_country'] as String? ?? 'IN',
          applicationDeadline: row['application_deadline'] != null
              ? DateTime.parse(row['application_deadline'] as String)
              : null,
          contentDeadline: row['content_deadline'] != null
              ? DateTime.parse(row['content_deadline'] as String)
              : null,
          publishedAt: row['published_at'] != null
              ? DateTime.parse(row['published_at'] as String)
              : null,
          myApplicationStatus: myAppStatus,
          myApplicationId: myAppId,
        ),
      );
    }

    return CampaignOpportunitySearchResult(
      items: items,
      totalCount: items.length,
      hasMore: items.length >= limit,
    );
  }

  Future<CampaignApplication> submitApplication({
    required String campaignId,
    required String creatorId,
    required String pitch,
    double? proposedRate,
    String currency = 'INR',
  }) async {
    final payload = {
      'campaign_id': campaignId,
      'creator_id': creatorId,
      'pitch': pitch,
      'proposed_rate': proposedRate,
      'currency': currency,
      'status': 'submitted',
    };

    final response = await client
        .from('campaign_applications')
        .insert(payload)
        .select()
        .single();

    final appId = response['id'] as String;

    await client.from('campaign_application_status_history').insert({
      'application_id': appId,
      'from_status': null,
      'to_status': 'submitted',
      'changed_by': creatorId,
      'reason': 'Application submitted by creator',
    });

    return getApplication(appId);
  }

  Future<List<CampaignApplication>> getCreatorApplications(
    String creatorId,
  ) async {
    final response = await client
        .from('campaign_applications')
        .select('''
          *,
          campaigns(
            title,
            organizations(name, logo_path)
          ),
          campaign_application_status_history(*)
        ''')
        .eq('creator_id', creatorId)
        .order('created_at', ascending: false);

    return (response as List).map((row) => _mapApplication(row)).toList();
  }

  Future<CampaignApplication> getApplication(String applicationId) async {
    final response = await client
        .from('campaign_applications')
        .select('''
          *,
          campaigns(
            title,
            organizations(name, logo_path)
          ),
          creator_profiles(
            user_id,
            city,
            profiles(display_name, avatar_path),
            creator_categories(categories(name))
          ),
          campaign_application_status_history(*)
        ''')
        .eq('id', applicationId)
        .single();

    return _mapApplication(response);
  }

  Future<List<CampaignApplication>> getCampaignApplicants({
    required String campaignId,
    CampaignApplicationStatus? status,
  }) async {
    var query = client
        .from('campaign_applications')
        .select('''
          *,
          creator_profiles(
            user_id,
            city,
            profiles(display_name, avatar_path),
            creator_categories(categories(name))
          ),
          campaign_application_status_history(*)
        ''')
        .eq('campaign_id', campaignId);

    if (status != null) {
      query = query.eq('status', status.wire);
    }

    final response = await query.order('created_at', ascending: false);
    return (response as List).map((row) => _mapApplication(row)).toList();
  }

  Future<CampaignApplication> transitionApplicationStatus({
    required String applicationId,
    required CampaignApplicationStatus newStatus,
    String? reason,
  }) async {
    await client.rpc(
      'transition_campaign_application_status',
      params: {
        'p_application_id': applicationId,
        'p_new_status': newStatus.wire,
        'p_reason': reason,
      },
    );
    return getApplication(applicationId);
  }

  Future<CampaignApplication> withdrawApplication(String applicationId) async {
    await client.rpc(
      'withdraw_campaign_application',
      params: {'p_application_id': applicationId},
    );
    return getApplication(applicationId);
  }

  Campaign _mapCampaign(Map<String, dynamic> row) {
    final org = row['organizations'] as Map<String, dynamic>?;
    final cats = (row['campaign_categories'] as List? ?? []);
    final langs = (row['campaign_languages'] as List? ?? []);
    final deliverables = (row['campaign_deliverables'] as List? ?? []);
    final apps = (row['campaign_applications'] as List? ?? []);

    final selectedCount = apps.where((a) => a['status'] == 'selected').length;

    return Campaign(
      id: row['id'] as String,
      organizationId: row['organization_id'] as String,
      createdBy: row['created_by'] as String?,
      title: row['title'] as String,
      objective: row['objective'] as String?,
      description: row['description'] as String,
      status: _parseCampaignStatus(row['status'] as String?),
      compensationType: _parseCompensationType(
        row['compensation_type'] as String?,
      ),
      currency: row['currency'] as String? ?? 'INR',
      budgetMin: (row['budget_min'] as num?)?.toDouble(),
      budgetMax: (row['budget_max'] as num?)?.toDouble(),
      barterValue: (row['barter_value'] as num?)?.toDouble(),
      barterDescription: row['barter_description'] as String?,
      creatorSlots: row['creator_slots'] as int? ?? 1,
      targetCity: row['target_city'] as String?,
      targetState: row['target_state'] as String?,
      targetCountry: row['target_country'] as String? ?? 'IN',
      minFollowers: row['min_followers'] as int?,
      maxFollowers: row['max_followers'] as int?,
      categoryIds: cats
          .map((c) => c['category_id']?.toString())
          .whereType<String>()
          .toList(),
      categoryNames: cats
          .map(
            (c) =>
                (c['categories'] as Map<String, dynamic>?)?['name']?.toString(),
          )
          .whereType<String>()
          .toList(),
      languageCodes: langs
          .map((l) => l['language_code']?.toString())
          .whereType<String>()
          .toList(),
      languageNames: langs
          .map(
            (l) =>
                (l['languages'] as Map<String, dynamic>?)?['name']?.toString(),
          )
          .whereType<String>()
          .toList(),
      deliverables: deliverables
          .map(
            (d) => CampaignDeliverable(
              id: d['id'] as String? ?? '',
              campaignId: row['id'] as String,
              deliverableType: _parseDeliverableType(
                d['deliverable_type'] as String?,
              ),
              platform: d['platform'] as String? ?? 'Instagram',
              quantity: d['quantity'] as int? ?? 1,
              description: d['description'] as String?,
            ),
          )
          .toList(),
      usageRights: CampaignUsageRights(
        organicRepostingAllowed:
            row['organic_reposting_allowed'] as bool? ?? true,
        paidUsageRequired: row['paid_usage_required'] as bool? ?? false,
        whitelistingRequired: row['whitelisting_required'] as bool? ?? false,
        usageDurationMonths: row['usage_duration_months'] as int?,
        usageTerritory: row['usage_territory'] as String? ?? 'India',
        exclusivityRequired: row['exclusivity_required'] as bool? ?? false,
        exclusivityDurationDays: row['exclusivity_duration_days'] as int?,
        contentApprovalRequired:
            row['content_approval_required'] as bool? ?? true,
        disclosureRequired: row['disclosure_required'] as bool? ?? true,
      ),
      applicationDeadline: row['application_deadline'] != null
          ? DateTime.parse(row['application_deadline'] as String)
          : null,
      contentDeadline: row['content_deadline'] != null
          ? DateTime.parse(row['content_deadline'] as String)
          : null,
      campaignStartDate: row['campaign_start_date'] != null
          ? DateTime.parse(row['campaign_start_date'] as String)
          : null,
      campaignEndDate: row['campaign_end_date'] != null
          ? DateTime.parse(row['campaign_end_date'] as String)
          : null,
      additionalRequirements: row['additional_requirements'] as String?,
      rejectionReason: row['rejection_reason'] as String?,
      publishedAt: row['published_at'] != null
          ? DateTime.parse(row['published_at'] as String)
          : null,
      closedAt: row['closed_at'] != null
          ? DateTime.parse(row['closed_at'] as String)
          : null,
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : null,
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : null,
      applicantCount: apps.length,
      selectedCount: selectedCount,
      brandName: org?['name'] as String?,
      brandLogoUrl: org?['logo_path'] as String?,
    );
  }

  CampaignApplication _mapApplication(Map<String, dynamic> row) {
    final campaign = row['campaigns'] as Map<String, dynamic>?;
    final org = campaign?['organizations'] as Map<String, dynamic>?;
    final creator = row['creator_profiles'] as Map<String, dynamic>?;
    final profile = creator?['profiles'] as Map<String, dynamic>?;
    final creatorCats = (creator?['creator_categories'] as List? ?? []);
    final historyList =
        (row['campaign_application_status_history'] as List? ?? []);

    final history = historyList
        .map(
          (h) => CampaignApplicationStatusHistory(
            id: h['id'] as String,
            applicationId: row['id'] as String,
            fromStatus: h['from_status'] != null
                ? _parseApplicationStatus(h['from_status'] as String?)
                : null,
            toStatus: _parseApplicationStatus(h['to_status'] as String?),
            changedBy: h['changed_by'] as String?,
            reason: h['reason'] as String?,
            createdAt: DateTime.parse(h['created_at'] as String),
          ),
        )
        .toList();

    history.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return CampaignApplication(
      id: row['id'] as String,
      campaignId: row['campaign_id'] as String,
      creatorId: row['creator_id'] as String,
      status: _parseApplicationStatus(row['status'] as String?),
      pitch: row['pitch'] as String,
      proposedRate: (row['proposed_rate'] as num?)?.toDouble(),
      currency: row['currency'] as String? ?? 'INR',
      reviewedAt: row['reviewed_at'] != null
          ? DateTime.parse(row['reviewed_at'] as String)
          : null,
      withdrawnAt: row['withdrawn_at'] != null
          ? DateTime.parse(row['withdrawn_at'] as String)
          : null,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : null,
      campaignTitle: campaign?['title'] as String?,
      brandName: org?['name'] as String?,
      brandLogoUrl: org?['logo_path'] as String?,
      creatorDisplayName: profile?['display_name'] as String?,
      creatorAvatarPath: profile?['avatar_path'] as String?,
      creatorCity: creator?['city'] as String?,
      creatorPrimaryCategories: creatorCats
          .map(
            (c) =>
                (c['categories'] as Map<String, dynamic>?)?['name']?.toString(),
          )
          .whereType<String>()
          .toList(),
      statusHistory: history,
    );
  }

  CampaignStatus _parseCampaignStatus(String? status) {
    return CampaignStatus.values.firstWhere(
      (s) => s.wire == status,
      orElse: () => CampaignStatus.draft,
    );
  }

  CampaignCompensationType _parseCompensationType(String? type) {
    return CampaignCompensationType.values.firstWhere(
      (t) => t.wire == type,
      orElse: () => CampaignCompensationType.paid,
    );
  }

  CampaignDeliverableType _parseDeliverableType(String? type) {
    return CampaignDeliverableType.values.firstWhere(
      (d) => d.wire == type,
      orElse: () => CampaignDeliverableType.instagramPost,
    );
  }

  CampaignApplicationStatus _parseApplicationStatus(String? status) {
    return CampaignApplicationStatus.values.firstWhere(
      (s) => s.wire == status,
      orElse: () => CampaignApplicationStatus.submitted,
    );
  }
}

class CampaignRepositoryImpl implements CampaignRepository {
  const CampaignRepositoryImpl(this.dataSource);
  final SupabaseCampaignDataSource dataSource;

  @override
  Future<Campaign> createDraft({
    required String organizationId,
    required String title,
    required String description,
    String? objective,
    CampaignCompensationType compensationType = CampaignCompensationType.paid,
    String currency = 'INR',
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    int creatorSlots = 1,
    String? targetCity,
    String? targetState,
    String targetCountry = 'IN',
    int? minFollowers,
    int? maxFollowers,
    List<String> categoryIds = const [],
    List<String> languageCodes = const [],
    List<CampaignDeliverable> deliverables = const [],
    CampaignUsageRights usageRights = const CampaignUsageRights(),
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
    String? additionalRequirements,
  }) => dataSource.createDraft(
    organizationId: organizationId,
    title: title,
    description: description,
    objective: objective,
    compensationType: compensationType,
    currency: currency,
    budgetMin: budgetMin,
    budgetMax: budgetMax,
    barterValue: barterValue,
    barterDescription: barterDescription,
    creatorSlots: creatorSlots,
    targetCity: targetCity,
    targetState: targetState,
    targetCountry: targetCountry,
    minFollowers: minFollowers,
    maxFollowers: maxFollowers,
    categoryIds: categoryIds,
    languageCodes: languageCodes,
    deliverables: deliverables,
    usageRights: usageRights,
    applicationDeadline: applicationDeadline,
    contentDeadline: contentDeadline,
    campaignStartDate: campaignStartDate,
    campaignEndDate: campaignEndDate,
    additionalRequirements: additionalRequirements,
  );

  @override
  Future<Campaign> updateDraft({
    required String campaignId,
    String? title,
    String? description,
    String? objective,
    CampaignCompensationType? compensationType,
    String? currency,
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    int? creatorSlots,
    String? targetCity,
    String? targetState,
    String? targetCountry,
    int? minFollowers,
    int? maxFollowers,
    List<String>? categoryIds,
    List<String>? languageCodes,
    List<CampaignDeliverable>? deliverables,
    CampaignUsageRights? usageRights,
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
    String? additionalRequirements,
  }) => dataSource.updateDraft(
    campaignId: campaignId,
    title: title,
    description: description,
    objective: objective,
    compensationType: compensationType,
    currency: currency,
    budgetMin: budgetMin,
    budgetMax: budgetMax,
    barterValue: barterValue,
    barterDescription: barterDescription,
    creatorSlots: creatorSlots,
    targetCity: targetCity,
    targetState: targetState,
    targetCountry: targetCountry,
    minFollowers: minFollowers,
    maxFollowers: maxFollowers,
    categoryIds: categoryIds,
    languageCodes: languageCodes,
    deliverables: deliverables,
    usageRights: usageRights,
    applicationDeadline: applicationDeadline,
    contentDeadline: contentDeadline,
    campaignStartDate: campaignStartDate,
    campaignEndDate: campaignEndDate,
    additionalRequirements: additionalRequirements,
  );

  @override
  Future<Campaign> getCampaign(String campaignId) =>
      dataSource.getCampaign(campaignId);

  @override
  Future<List<Campaign>> listOrganizationCampaigns({
    required String organizationId,
    CampaignStatus? status,
  }) => dataSource.listOrganizationCampaigns(
    organizationId: organizationId,
    status: status,
  );

  @override
  Future<Campaign> submitForReview(String campaignId) =>
      dataSource.submitForReview(campaignId);

  @override
  Future<Campaign> pauseCampaign(String campaignId) =>
      dataSource.pauseCampaign(campaignId);

  @override
  Future<Campaign> resumeCampaign(String campaignId) =>
      dataSource.resumeCampaign(campaignId);

  @override
  Future<Campaign> closeCampaign(String campaignId) =>
      dataSource.closeCampaign(campaignId);

  @override
  Future<void> deleteDraft(String campaignId) =>
      dataSource.deleteDraft(campaignId);

  @override
  Future<Campaign> moderateCampaign({
    required String campaignId,
    required String action,
    String? reason,
  }) => dataSource.moderateCampaign(
    campaignId: campaignId,
    action: action,
    reason: reason,
  );

  @override
  Future<CampaignOpportunitySearchResult> searchLiveCampaigns({
    required CampaignSearchFilters filters,
    int limit = 20,
    int offset = 0,
    String? creatorId,
  }) => dataSource.searchLiveCampaigns(
    filters: filters,
    limit: limit,
    offset: offset,
    creatorId: creatorId,
  );

  @override
  Future<CampaignApplication> submitApplication({
    required String campaignId,
    required String creatorId,
    required String pitch,
    double? proposedRate,
    String currency = 'INR',
  }) => dataSource.submitApplication(
    campaignId: campaignId,
    creatorId: creatorId,
    pitch: pitch,
    proposedRate: proposedRate,
    currency: currency,
  );

  @override
  Future<List<CampaignApplication>> getCreatorApplications(String creatorId) =>
      dataSource.getCreatorApplications(creatorId);

  @override
  Future<CampaignApplication> getApplication(String applicationId) =>
      dataSource.getApplication(applicationId);

  @override
  Future<List<CampaignApplication>> getCampaignApplicants({
    required String campaignId,
    CampaignApplicationStatus? status,
  }) =>
      dataSource.getCampaignApplicants(campaignId: campaignId, status: status);

  @override
  Future<CampaignApplication> transitionApplicationStatus({
    required String applicationId,
    required CampaignApplicationStatus newStatus,
    String? reason,
  }) => dataSource.transitionApplicationStatus(
    applicationId: applicationId,
    newStatus: newStatus,
    reason: reason,
  );

  @override
  Future<CampaignApplication> withdrawApplication(String applicationId) =>
      dataSource.withdrawApplication(applicationId);
}
