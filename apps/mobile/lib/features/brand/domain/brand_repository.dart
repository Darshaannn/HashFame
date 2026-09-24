import '../domain/brand_profile.dart';

abstract interface class BrandRepository {
  Future<BrandMarketerProfile> getProfile({String? userId});
  Future<BrandMarketerProfile> updateProfile(BrandMarketerProfile profile);
  Future<CompanyBrand> createBrand(CompanyBrand brand);
  Future<void> updateBrand(CompanyBrand brand);
  Future<List<CompanyBrand>> getBrands({String? organizationId});
}

abstract interface class BrandDataSource {
  String? get userId;
  Future<BrandMarketerProfile> getProfile({String? userId});
  Future<BrandMarketerProfile> updateProfile(BrandMarketerProfile profile);
  Future<CompanyBrand> createBrand(CompanyBrand brand);
  Future<void> updateBrand(CompanyBrand brand);
  Future<List<CompanyBrand>> getBrands({String? organizationId});
}
