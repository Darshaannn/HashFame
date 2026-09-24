// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creator_search_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatorSearchFilters {

 String get query; List<String> get categoryIds; List<String> get languageCodes; String? get city; String? get state; List<SocialPlatform> get platforms; int? get minFollowers; int? get maxFollowers; double? get minRate; double? get maxRate; AvailabilityStatus? get availability; bool? get isRepresented; FieldVerificationStatus? get verificationStatus;
/// Create a copy of CreatorSearchFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatorSearchFiltersCopyWith<CreatorSearchFilters> get copyWith => _$CreatorSearchFiltersCopyWithImpl<CreatorSearchFilters>(this as CreatorSearchFilters, _$identity);

  /// Serializes this CreatorSearchFilters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreatorSearchFilters;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatorSearchFilters&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.categoryIds, _this.categoryIds)&&const DeepCollectionEquality().equals(other.languageCodes, _this.languageCodes)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.state, _this.state) || other.state == _this.state)&&const DeepCollectionEquality().equals(other.platforms, _this.platforms)&&(identical(other.minFollowers, _this.minFollowers) || other.minFollowers == _this.minFollowers)&&(identical(other.maxFollowers, _this.maxFollowers) || other.maxFollowers == _this.maxFollowers)&&(identical(other.minRate, _this.minRate) || other.minRate == _this.minRate)&&(identical(other.maxRate, _this.maxRate) || other.maxRate == _this.maxRate)&&(identical(other.availability, _this.availability) || other.availability == _this.availability)&&(identical(other.isRepresented, _this.isRepresented) || other.isRepresented == _this.isRepresented)&&(identical(other.verificationStatus, _this.verificationStatus) || other.verificationStatus == _this.verificationStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreatorSearchFilters;
  return Object.hash(runtimeType,_this.query,const DeepCollectionEquality().hash(_this.categoryIds),const DeepCollectionEquality().hash(_this.languageCodes),_this.city,_this.state,const DeepCollectionEquality().hash(_this.platforms),_this.minFollowers,_this.maxFollowers,_this.minRate,_this.maxRate,_this.availability,_this.isRepresented,_this.verificationStatus);
}

@override
String toString() {
  final _this = this as CreatorSearchFilters;
  return 'CreatorSearchFilters(query: ${_this.query}, categoryIds: ${_this.categoryIds}, languageCodes: ${_this.languageCodes}, city: ${_this.city}, state: ${_this.state}, platforms: ${_this.platforms}, minFollowers: ${_this.minFollowers}, maxFollowers: ${_this.maxFollowers}, minRate: ${_this.minRate}, maxRate: ${_this.maxRate}, availability: ${_this.availability}, isRepresented: ${_this.isRepresented}, verificationStatus: ${_this.verificationStatus})';
}


}

/// @nodoc
abstract mixin class $CreatorSearchFiltersCopyWith<$Res>  {
  factory $CreatorSearchFiltersCopyWith(CreatorSearchFilters value, $Res Function(CreatorSearchFilters) _then) = _$CreatorSearchFiltersCopyWithImpl;
@useResult
$Res call({
 String query, List<String> categoryIds, List<String> languageCodes, String? city, String? state, List<SocialPlatform> platforms, int? minFollowers, int? maxFollowers, double? minRate, double? maxRate, AvailabilityStatus? availability, bool? isRepresented, FieldVerificationStatus? verificationStatus
});




}
/// @nodoc
class _$CreatorSearchFiltersCopyWithImpl<$Res>
    implements $CreatorSearchFiltersCopyWith<$Res> {
  _$CreatorSearchFiltersCopyWithImpl(this._self, this._then);

  final CreatorSearchFilters _self;
  final $Res Function(CreatorSearchFilters) _then;

/// Create a copy of CreatorSearchFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? categoryIds = null,Object? languageCodes = null,Object? city = freezed,Object? state = freezed,Object? platforms = null,Object? minFollowers = freezed,Object? maxFollowers = freezed,Object? minRate = freezed,Object? maxRate = freezed,Object? availability = freezed,Object? isRepresented = freezed,Object? verificationStatus = freezed,}) {
  return _then(CreatorSearchFilters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<SocialPlatform>,minFollowers: freezed == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int?,maxFollowers: freezed == maxFollowers ? _self.maxFollowers : maxFollowers // ignore: cast_nullable_to_non_nullable
as int?,minRate: freezed == minRate ? _self.minRate : minRate // ignore: cast_nullable_to_non_nullable
as double?,maxRate: freezed == maxRate ? _self.maxRate : maxRate // ignore: cast_nullable_to_non_nullable
as double?,availability: freezed == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as AvailabilityStatus?,isRepresented: freezed == isRepresented ? _self.isRepresented : isRepresented // ignore: cast_nullable_to_non_nullable
as bool?,verificationStatus: freezed == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatorSearchFilters].
extension CreatorSearchFiltersPatterns on CreatorSearchFilters {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatorSearchFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatorSearchFilters() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatorSearchFilters value)  $default,){
final _that = this;
switch (_that) {
case _CreatorSearchFilters():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatorSearchFilters value)?  $default,){
final _that = this;
switch (_that) {
case _CreatorSearchFilters() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<String> categoryIds,  List<String> languageCodes,  String? city,  String? state,  List<SocialPlatform> platforms,  int? minFollowers,  int? maxFollowers,  double? minRate,  double? maxRate,  AvailabilityStatus? availability,  bool? isRepresented,  FieldVerificationStatus? verificationStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatorSearchFilters() when $default != null:
return $default(_that.query,_that.categoryIds,_that.languageCodes,_that.city,_that.state,_that.platforms,_that.minFollowers,_that.maxFollowers,_that.minRate,_that.maxRate,_that.availability,_that.isRepresented,_that.verificationStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<String> categoryIds,  List<String> languageCodes,  String? city,  String? state,  List<SocialPlatform> platforms,  int? minFollowers,  int? maxFollowers,  double? minRate,  double? maxRate,  AvailabilityStatus? availability,  bool? isRepresented,  FieldVerificationStatus? verificationStatus)  $default,) {final _that = this;
switch (_that) {
case _CreatorSearchFilters():
return $default(_that.query,_that.categoryIds,_that.languageCodes,_that.city,_that.state,_that.platforms,_that.minFollowers,_that.maxFollowers,_that.minRate,_that.maxRate,_that.availability,_that.isRepresented,_that.verificationStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<String> categoryIds,  List<String> languageCodes,  String? city,  String? state,  List<SocialPlatform> platforms,  int? minFollowers,  int? maxFollowers,  double? minRate,  double? maxRate,  AvailabilityStatus? availability,  bool? isRepresented,  FieldVerificationStatus? verificationStatus)?  $default,) {final _that = this;
switch (_that) {
case _CreatorSearchFilters() when $default != null:
return $default(_that.query,_that.categoryIds,_that.languageCodes,_that.city,_that.state,_that.platforms,_that.minFollowers,_that.maxFollowers,_that.minRate,_that.maxRate,_that.availability,_that.isRepresented,_that.verificationStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatorSearchFilters extends CreatorSearchFilters {
  const _CreatorSearchFilters({this.query = '',  List<String> categoryIds = const [],  List<String> languageCodes = const [], this.city, this.state,  List<SocialPlatform> platforms = const [], this.minFollowers, this.maxFollowers, this.minRate, this.maxRate, this.availability, this.isRepresented, this.verificationStatus}): _categoryIds = categoryIds,_languageCodes = languageCodes,_platforms = platforms,super._();
  factory _CreatorSearchFilters.fromJson(Map<String, dynamic> json) => _$CreatorSearchFiltersFromJson(json);

@override@JsonKey() final  String query;
 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

 final  List<String> _languageCodes;
@override@JsonKey() List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

@override final  String? city;
@override final  String? state;
 final  List<SocialPlatform> _platforms;
@override@JsonKey() List<SocialPlatform> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

@override final  int? minFollowers;
@override final  int? maxFollowers;
@override final  double? minRate;
@override final  double? maxRate;
@override final  AvailabilityStatus? availability;
@override final  bool? isRepresented;
@override final  FieldVerificationStatus? verificationStatus;

/// Create a copy of CreatorSearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatorSearchFiltersCopyWith<_CreatorSearchFilters> get copyWith => __$CreatorSearchFiltersCopyWithImpl<_CreatorSearchFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatorSearchFiltersToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatorSearchFilters&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.categoryIds, _categoryIds)&&const DeepCollectionEquality().equals(other.languageCodes, _languageCodes)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.platforms, _platforms)&&(identical(other.minFollowers, minFollowers) || other.minFollowers == minFollowers)&&(identical(other.maxFollowers, maxFollowers) || other.maxFollowers == maxFollowers)&&(identical(other.minRate, minRate) || other.minRate == minRate)&&(identical(other.maxRate, maxRate) || other.maxRate == maxRate)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.isRepresented, isRepresented) || other.isRepresented == isRepresented)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_categoryIds),const DeepCollectionEquality().hash(_languageCodes),city,state,const DeepCollectionEquality().hash(_platforms),minFollowers,maxFollowers,minRate,maxRate,availability,isRepresented,verificationStatus);
}

@override
String toString() {
    return 'CreatorSearchFilters(query: $query, categoryIds: $categoryIds, languageCodes: $languageCodes, city: $city, state: $state, platforms: $platforms, minFollowers: $minFollowers, maxFollowers: $maxFollowers, minRate: $minRate, maxRate: $maxRate, availability: $availability, isRepresented: $isRepresented, verificationStatus: $verificationStatus)';
}


}

/// @nodoc
abstract mixin class _$CreatorSearchFiltersCopyWith<$Res> implements $CreatorSearchFiltersCopyWith<$Res> {
  factory _$CreatorSearchFiltersCopyWith(_CreatorSearchFilters value, $Res Function(_CreatorSearchFilters) _then) = __$CreatorSearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 String query, List<String> categoryIds, List<String> languageCodes, String? city, String? state, List<SocialPlatform> platforms, int? minFollowers, int? maxFollowers, double? minRate, double? maxRate, AvailabilityStatus? availability, bool? isRepresented, FieldVerificationStatus? verificationStatus
});




}
/// @nodoc
class __$CreatorSearchFiltersCopyWithImpl<$Res>
    implements _$CreatorSearchFiltersCopyWith<$Res> {
  __$CreatorSearchFiltersCopyWithImpl(this._self, this._then);

  final _CreatorSearchFilters _self;
  final $Res Function(_CreatorSearchFilters) _then;

/// Create a copy of CreatorSearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? categoryIds = null,Object? languageCodes = null,Object? city = freezed,Object? state = freezed,Object? platforms = null,Object? minFollowers = freezed,Object? maxFollowers = freezed,Object? minRate = freezed,Object? maxRate = freezed,Object? availability = freezed,Object? isRepresented = freezed,Object? verificationStatus = freezed,}) {
  return _then(_CreatorSearchFilters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<SocialPlatform>,minFollowers: freezed == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int?,maxFollowers: freezed == maxFollowers ? _self.maxFollowers : maxFollowers // ignore: cast_nullable_to_non_nullable
as int?,minRate: freezed == minRate ? _self.minRate : minRate // ignore: cast_nullable_to_non_nullable
as double?,maxRate: freezed == maxRate ? _self.maxRate : maxRate // ignore: cast_nullable_to_non_nullable
as double?,availability: freezed == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as AvailabilityStatus?,isRepresented: freezed == isRepresented ? _self.isRepresented : isRepresented // ignore: cast_nullable_to_non_nullable
as bool?,verificationStatus: freezed == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus?,
  ));
}


}

// dart format on
