import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference_data.freezed.dart';
part 'reference_data.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class Category with _$Category {
  const factory Category({
    required String id,
    String? parentId,
    required String name,
    required String slug,
    @Default(0) int sortOrder,
    @Default([]) List<Category> subcategories,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class Language with _$Language {
  const factory Language({
    required String code,
    required String name,
    required String nativeName,
    @Default(0) int sortOrder,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class LocationData with _$LocationData {
  const factory LocationData({
    String? city,
    String? state,
    @Default('IN') String country,
  }) = _LocationData;

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);
}
