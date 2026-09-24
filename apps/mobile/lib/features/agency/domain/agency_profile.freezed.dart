// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AgencyProfile {

 String get userId; String get agencyName; String? get website; String? get description; String? get location; List<String> get services; String? get organizationId; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of AgencyProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgencyProfileCopyWith<AgencyProfile> get copyWith => _$AgencyProfileCopyWithImpl<AgencyProfile>(this as AgencyProfile, _$identity);

  /// Serializes this AgencyProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AgencyProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgencyProfile&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.agencyName, _this.agencyName) || other.agencyName == _this.agencyName)&&(identical(other.website, _this.website) || other.website == _this.website)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.location, _this.location) || other.location == _this.location)&&const DeepCollectionEquality().equals(other.services, _this.services)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AgencyProfile;
  return Object.hash(runtimeType,_this.userId,_this.agencyName,_this.website,_this.description,_this.location,const DeepCollectionEquality().hash(_this.services),_this.organizationId,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as AgencyProfile;
  return 'AgencyProfile(userId: ${_this.userId}, agencyName: ${_this.agencyName}, website: ${_this.website}, description: ${_this.description}, location: ${_this.location}, services: ${_this.services}, organizationId: ${_this.organizationId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $AgencyProfileCopyWith<$Res>  {
  factory $AgencyProfileCopyWith(AgencyProfile value, $Res Function(AgencyProfile) _then) = _$AgencyProfileCopyWithImpl;
@useResult
$Res call({
 String userId, String agencyName, String? website, String? description, String? location, List<String> services, String? organizationId, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$AgencyProfileCopyWithImpl<$Res>
    implements $AgencyProfileCopyWith<$Res> {
  _$AgencyProfileCopyWithImpl(this._self, this._then);

  final AgencyProfile _self;
  final $Res Function(AgencyProfile) _then;

/// Create a copy of AgencyProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? agencyName = null,Object? website = freezed,Object? description = freezed,Object? location = freezed,Object? services = null,Object? organizationId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(AgencyProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,agencyName: null == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<String>,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AgencyProfile].
extension AgencyProfilePatterns on AgencyProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgencyProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgencyProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgencyProfile value)  $default,){
final _that = this;
switch (_that) {
case _AgencyProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgencyProfile value)?  $default,){
final _that = this;
switch (_that) {
case _AgencyProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String agencyName,  String? website,  String? description,  String? location,  List<String> services,  String? organizationId,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgencyProfile() when $default != null:
return $default(_that.userId,_that.agencyName,_that.website,_that.description,_that.location,_that.services,_that.organizationId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String agencyName,  String? website,  String? description,  String? location,  List<String> services,  String? organizationId,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AgencyProfile():
return $default(_that.userId,_that.agencyName,_that.website,_that.description,_that.location,_that.services,_that.organizationId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String agencyName,  String? website,  String? description,  String? location,  List<String> services,  String? organizationId,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AgencyProfile() when $default != null:
return $default(_that.userId,_that.agencyName,_that.website,_that.description,_that.location,_that.services,_that.organizationId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgencyProfile implements AgencyProfile {
  const _AgencyProfile({required this.userId, required this.agencyName, this.website, this.description, this.location,  List<String> services = const [], this.organizationId, this.createdAt, this.updatedAt}): _services = services;
  factory _AgencyProfile.fromJson(Map<String, dynamic> json) => _$AgencyProfileFromJson(json);

@override final  String userId;
@override final  String agencyName;
@override final  String? website;
@override final  String? description;
@override final  String? location;
 final  List<String> _services;
@override@JsonKey() List<String> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

@override final  String? organizationId;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of AgencyProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgencyProfileCopyWith<_AgencyProfile> get copyWith => __$AgencyProfileCopyWithImpl<_AgencyProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgencyProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgencyProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.agencyName, agencyName) || other.agencyName == agencyName)&&(identical(other.website, website) || other.website == website)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.services, _services)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,agencyName,website,description,location,const DeepCollectionEquality().hash(_services),organizationId,createdAt,updatedAt);
}

@override
String toString() {
    return 'AgencyProfile(userId: $userId, agencyName: $agencyName, website: $website, description: $description, location: $location, services: $services, organizationId: $organizationId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AgencyProfileCopyWith<$Res> implements $AgencyProfileCopyWith<$Res> {
  factory _$AgencyProfileCopyWith(_AgencyProfile value, $Res Function(_AgencyProfile) _then) = __$AgencyProfileCopyWithImpl;
@override @useResult
$Res call({
 String userId, String agencyName, String? website, String? description, String? location, List<String> services, String? organizationId, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$AgencyProfileCopyWithImpl<$Res>
    implements _$AgencyProfileCopyWith<$Res> {
  __$AgencyProfileCopyWithImpl(this._self, this._then);

  final _AgencyProfile _self;
  final $Res Function(_AgencyProfile) _then;

/// Create a copy of AgencyProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? agencyName = null,Object? website = freezed,Object? description = freezed,Object? location = freezed,Object? services = null,Object? organizationId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_AgencyProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,agencyName: null == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<String>,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
