import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/reference_data.dart';
import '../domain/reference_data_repository.dart';

class SupabaseReferenceDataSource implements ReferenceDataSource {
  SupabaseReferenceDataSource(this.client);
  final SupabaseClient client;

  @override
  Future<List<Category>> getCategories() async {
    final response = await client
        .from('categories')
        .select('id,parent_id,name,slug,sort_order')
        .order('sort_order');
    final rawList = List<Map<String, dynamic>>.from(response as List);
    
    // Group subcategories under parents
    final rootCategories = rawList.where((c) => c['parent_id'] == null).map((c) {
      final subList = rawList
          .where((sub) => sub['parent_id'] == c['id'])
          .map((sub) => Category.fromJson(sub))
          .toList();
      return Category.fromJson(c).copyWith(subcategories: subList);
    }).toList();

    return rootCategories;
  }

  @override
  Future<List<Language>> getLanguages() async {
    final response = await client
        .from('languages')
        .select('code,name,native_name,sort_order')
        .order('sort_order');
    return (response as List)
        .map((l) => Language.fromJson(Map<String, dynamic>.from(l as Map)))
        .toList();
  }
}

class ReferenceDataRepositoryImpl implements ReferenceDataRepository {
  ReferenceDataRepositoryImpl(this.dataSource);
  final ReferenceDataSource dataSource;

  List<Category>? _cachedCategories;
  List<Language>? _cachedLanguages;

  @override
  Future<List<Category>> getCategories() async {
    if (_cachedCategories != null && _cachedCategories!.isNotEmpty) {
      return _cachedCategories!;
    }
    final list = await dataSource.getCategories();
    _cachedCategories = list;
    return list;
  }

  @override
  Future<List<Language>> getLanguages() async {
    if (_cachedLanguages != null && _cachedLanguages!.isNotEmpty) {
      return _cachedLanguages!;
    }
    final list = await dataSource.getLanguages();
    _cachedLanguages = list;
    return list;
  }
}
