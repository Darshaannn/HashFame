import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/brand_profile.dart';
import '../domain/brand_repository.dart';

class SupabaseBrandDataSource implements BrandDataSource {
  SupabaseBrandDataSource(this.client);
  final SupabaseClient client;

  @override
  String? get userId => client.auth.currentUser?.id;
  String get _actor => userId ?? (throw const AuthException('Session missing'));

  @override
  Future<BrandMarketerProfile> getProfile({String? userId}) async {
    final targetId = userId ?? _actor;

    final profileRow = await client
        .from('profiles')
        .select('display_name')
        .eq('id', targetId)
        .maybeSingle();

    final brandRow = await client
        .from('brand_marketer_profiles')
        .select('*, organizations(id, name)')
        .eq('user_id', targetId)
        .maybeSingle();

    final displayName = profileRow?['display_name'] as String? ?? '';

    if (brandRow == null) {
      return BrandMarketerProfile(userId: targetId, displayName: displayName);
    }

    final org = brandRow['organizations'];
    final orgId = brandRow['organization_id'] as String?;
    final orgName = org?['name'] as String?;

    List<CompanyBrand> brands = [];
    if (orgId != null) {
      brands = await getBrands(organizationId: orgId);
    }

    return BrandMarketerProfile(
      userId: targetId,
      displayName: displayName,
      jobTitle: brandRow['job_title'] as String?,
      workEmail: brandRow['work_email'] as String?,
      phone: brandRow['phone'] as String?,
      bio: brandRow['bio'] as String?,
      organizationId: orgId,
      organizationName: orgName,
      managedBrands: brands,
      createdAt: brandRow['created_at'] != null
          ? DateTime.tryParse(brandRow['created_at'] as String)
          : null,
      updatedAt: brandRow['updated_at'] != null
          ? DateTime.tryParse(brandRow['updated_at'] as String)
          : null,
    );
  }

  @override
  Future<BrandMarketerProfile> updateProfile(BrandMarketerProfile profile) async {
    await client.from('brand_marketer_profiles').upsert({
      'user_id': _actor,
      'job_title': profile.jobTitle,
      'work_email': profile.workEmail,
      'phone': profile.phone,
      'bio': profile.bio,
      'organization_id': profile.organizationId,
    });
    return getProfile();
  }

  @override
  Future<CompanyBrand> createBrand(CompanyBrand brand) async {
    final res = await client.from('company_brands').insert({
      'organization_id': brand.organizationId,
      'name': brand.name,
      'logo_path': brand.logoPath,
      'industry': brand.industry,
      'website': brand.website,
      'description': brand.description,
      'headquarters': brand.headquarters,
    }).select().single();
    return CompanyBrand.fromJson(Map<String, dynamic>.from(res));
  }

  @override
  Future<void> updateBrand(CompanyBrand brand) async {
    await client.from('company_brands').update({
      'name': brand.name,
      'logo_path': brand.logoPath,
      'industry': brand.industry,
      'website': brand.website,
      'description': brand.description,
      'headquarters': brand.headquarters,
      'status': brand.status,
    }).eq('id', brand.id);
  }

  @override
  Future<List<CompanyBrand>> getBrands({String? organizationId}) async {
    var query = client.from('company_brands').select();
    if (organizationId != null) {
      query = query.eq('organization_id', organizationId);
    }
    final rows = await query;
    return (rows as List)
        .map((b) => CompanyBrand.fromJson(Map<String, dynamic>.from(b as Map)))
        .toList();
  }
}

class BrandRepositoryImpl implements BrandRepository {
  BrandRepositoryImpl(this.dataSource);
  final BrandDataSource dataSource;

  @override
  Future<BrandMarketerProfile> getProfile({String? userId}) =>
      dataSource.getProfile(userId: userId);

  @override
  Future<BrandMarketerProfile> updateProfile(BrandMarketerProfile profile) =>
      dataSource.updateProfile(profile);

  @override
  Future<CompanyBrand> createBrand(CompanyBrand brand) =>
      dataSource.createBrand(brand);

  @override
  Future<void> updateBrand(CompanyBrand brand) =>
      dataSource.updateBrand(brand);

  @override
  Future<List<CompanyBrand>> getBrands({String? organizationId}) =>
      dataSource.getBrands(organizationId: organizationId);
}
