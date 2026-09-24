import '../domain/reference_data.dart';

abstract interface class ReferenceDataRepository {
  Future<List<Category>> getCategories();
  Future<List<Language>> getLanguages();
}

abstract interface class ReferenceDataSource {
  Future<List<Category>> getCategories();
  Future<List<Language>> getLanguages();
}
