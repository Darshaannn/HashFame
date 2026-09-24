// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'talent_manager_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TalentManagerProfile {

 String get userId; String get displayName; String? get bio; String? get companyName; String? get organizationId; int get representedCreatorsCount; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of TalentManagerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TalentManagerProfileCopyWith<TalentManagerProfile> get copyWith => _$TalentManagerProfileCopyWithImpl<TalentManagerProfile>(this as TalentManagerProfile, _$identity);

  /// Serializes this TalentManagerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TalentManagerProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TalentManagerProfile&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.companyName, _this.companyName) || other.companyName == _this.companyName)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.representedCreatorsCount, _this.representedCreatorsCount) || other.representedCreatorsCount == _this.representedCreatorsCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TalentManagerProfile;
  return Object.hash(runtimeType,_this.userId,_this.displayName,_this.bio,_this.companyName,_this.organizationId,_this.representedCreatorsCount,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as TalentManagerProfile;
  return 'TalentManagerProfile(userId: ${_this.userId}, displayName: ${_this.displayName}, bio: ${_this.bio}, companyName: ${_this.companyName}, organizationId: ${_this.organizationId}, representedCreatorsCount: ${_this.representedCreatorsCount}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $TalentManagerProfileCopyWith<$Res>  {
  factory $TalentManagerProfileCopyWith(TalentManagerProfile value, $Res Function(TalentManagerProfile) _then) = _$TalentManagerProfileCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? bio, String? companyName, String? organizationId, int representedCreatorsCount, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$TalentManagerProfileCopyWithImpl<$Res>
    implements $TalentManagerProfileCopyWith<$Res> {
  _$TalentManagerProfileCopyWithImpl(this._self, this._then);

  final TalentManagerProfile _self;
  final $Res Function(TalentManagerProfile) _then;

/// Create a copy of TalentManagerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? bio = freezed,Object? companyName = freezed,Object? organizationId = freezed,Object? representedCreatorsCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(TalentManagerProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,representedCreatorsCount: null == representedCreatorsCount ? _self.representedCreatorsCount : representedCreatorsCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TalentManagerProfile].
extension TalentManagerProfilePatterns on TalentManagerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TalentManagerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TalentManagerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TalentManagerProfile value)  $default,){
final _that = this;
switch (_that) {
case _TalentManagerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TalentManagerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _TalentManagerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? bio,  String? companyName,  String? organizationId,  int representedCreatorsCount,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TalentManagerProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.bio,_that.companyName,_that.organizationId,_that.representedCreatorsCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? bio,  String? companyName,  String? organizationId,  int representedCreatorsCount,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TalentManagerProfile():
return $default(_that.userId,_that.displayName,_that.bio,_that.companyName,_that.organizationId,_that.representedCreatorsCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? bio,  String? companyName,  String? organizationId,  int representedCreatorsCount,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TalentManagerProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.bio,_that.companyName,_that.organizationId,_that.representedCreatorsCount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TalentManagerProfile implements TalentManagerProfile {
  const _TalentManagerProfile({required this.userId, required this.displayName, this.bio, this.companyName, this.organizationId, this.representedCreatorsCount = 0, this.createdAt, this.updatedAt});
  factory _TalentManagerProfile.fromJson(Map<String, dynamic> json) => _$TalentManagerProfileFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? bio;
@override final  String? companyName;
@override final  String? organizationId;
@override@JsonKey() final  int representedCreatorsCount;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of TalentManagerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TalentManagerProfileCopyWith<_TalentManagerProfile> get copyWith => __$TalentManagerProfileCopyWithImpl<_TalentManagerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TalentManagerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TalentManagerProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.representedCreatorsCount, representedCreatorsCount) || other.representedCreatorsCount == representedCreatorsCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,displayName,bio,companyName,organizationId,representedCreatorsCount,createdAt,updatedAt);
}

@override
String toString() {
    return 'TalentManagerProfile(userId: $userId, displayName: $displayName, bio: $bio, companyName: $companyName, organizationId: $organizationId, representedCreatorsCount: $representedCreatorsCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TalentManagerProfileCopyWith<$Res> implements $TalentManagerProfileCopyWith<$Res> {
  factory _$TalentManagerProfileCopyWith(_TalentManagerProfile value, $Res Function(_TalentManagerProfile) _then) = __$TalentManagerProfileCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? bio, String? companyName, String? organizationId, int representedCreatorsCount, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$TalentManagerProfileCopyWithImpl<$Res>
    implements _$TalentManagerProfileCopyWith<$Res> {
  __$TalentManagerProfileCopyWithImpl(this._self, this._then);

  final _TalentManagerProfile _self;
  final $Res Function(_TalentManagerProfile) _then;

/// Create a copy of TalentManagerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? bio = freezed,Object? companyName = freezed,Object? organizationId = freezed,Object? representedCreatorsCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TalentManagerProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,representedCreatorsCount: null == representedCreatorsCount ? _self.representedCreatorsCount : representedCreatorsCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
