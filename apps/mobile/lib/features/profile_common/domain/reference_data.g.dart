// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: json['id'] as String,
  parentId: json['parent_id'] as String?,
  name: json['name'] as String,
  slug: json['slug'] as String,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
  subcategories:
      (json['subcategories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'id': instance.id,
  'parent_id': instance.parentId,
  'name': instance.name,
  'slug': instance.slug,
  'sort_order': instance.sortOrder,
  'subcategories': instance.subcategories.map((e) => e.toJson()).toList(),
};

_Language _$LanguageFromJson(Map<String, dynamic> json) => _Language(
  code: json['code'] as String,
  name: json['name'] as String,
  nativeName: json['native_name'] as String,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LanguageToJson(_Language instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'native_name': instance.nativeName,
  'sort_order': instance.sortOrder,
};

_LocationData _$LocationDataFromJson(Map<String, dynamic> json) =>
    _LocationData(
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String? ?? 'IN',
    );

Map<String, dynamic> _$LocationDataToJson(_LocationData instance) =>
    <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
