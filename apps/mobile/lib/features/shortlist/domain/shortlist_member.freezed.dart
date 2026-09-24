// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shortlist_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShortlistMember {

 String get id; String get shortlistId; String get creatorId; String get addedBy; ShortlistMemberStatus get status; String? get notes; DateTime get createdAt; DateTime get updatedAt; String? get creatorDisplayName; String? get creatorProfessionalName; String? get creatorAvatarPath; String? get creatorCity; String? get creatorPrimaryCategory;
/// Create a copy of ShortlistMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortlistMemberCopyWith<ShortlistMember> get copyWith => _$ShortlistMemberCopyWithImpl<ShortlistMember>(this as ShortlistMember, _$identity);

  /// Serializes this ShortlistMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ShortlistMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortlistMember&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.shortlistId, _this.shortlistId) || other.shortlistId == _this.shortlistId)&&(identical(other.creatorId, _this.creatorId) || other.creatorId == _this.creatorId)&&(identical(other.addedBy, _this.addedBy) || other.addedBy == _this.addedBy)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.creatorDisplayName, _this.creatorDisplayName) || other.creatorDisplayName == _this.creatorDisplayName)&&(identical(other.creatorProfessionalName, _this.creatorProfessionalName) || other.creatorProfessionalName == _this.creatorProfessionalName)&&(identical(other.creatorAvatarPath, _this.creatorAvatarPath) || other.creatorAvatarPath == _this.creatorAvatarPath)&&(identical(other.creatorCity, _this.creatorCity) || other.creatorCity == _this.creatorCity)&&(identical(other.creatorPrimaryCategory, _this.creatorPrimaryCategory) || other.creatorPrimaryCategory == _this.creatorPrimaryCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShortlistMember;
  return Object.hash(runtimeType,_this.id,_this.shortlistId,_this.creatorId,_this.addedBy,_this.status,_this.notes,_this.createdAt,_this.updatedAt,_this.creatorDisplayName,_this.creatorProfessionalName,_this.creatorAvatarPath,_this.creatorCity,_this.creatorPrimaryCategory);
}

@override
String toString() {
  final _this = this as ShortlistMember;
  return 'ShortlistMember(id: ${_this.id}, shortlistId: ${_this.shortlistId}, creatorId: ${_this.creatorId}, addedBy: ${_this.addedBy}, status: ${_this.status}, notes: ${_this.notes}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, creatorDisplayName: ${_this.creatorDisplayName}, creatorProfessionalName: ${_this.creatorProfessionalName}, creatorAvatarPath: ${_this.creatorAvatarPath}, creatorCity: ${_this.creatorCity}, creatorPrimaryCategory: ${_this.creatorPrimaryCategory})';
}


}

/// @nodoc
abstract mixin class $ShortlistMemberCopyWith<$Res>  {
  factory $ShortlistMemberCopyWith(ShortlistMember value, $Res Function(ShortlistMember) _then) = _$ShortlistMemberCopyWithImpl;
@useResult
$Res call({
 String id, String shortlistId, String creatorId, String addedBy, ShortlistMemberStatus status, String? notes, DateTime createdAt, DateTime updatedAt, String? creatorDisplayName, String? creatorProfessionalName, String? creatorAvatarPath, String? creatorCity, String? creatorPrimaryCategory
});




}
/// @nodoc
class _$ShortlistMemberCopyWithImpl<$Res>
    implements $ShortlistMemberCopyWith<$Res> {
  _$ShortlistMemberCopyWithImpl(this._self, this._then);

  final ShortlistMember _self;
  final $Res Function(ShortlistMember) _then;

/// Create a copy of ShortlistMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shortlistId = null,Object? creatorId = null,Object? addedBy = null,Object? status = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? creatorDisplayName = freezed,Object? creatorProfessionalName = freezed,Object? creatorAvatarPath = freezed,Object? creatorCity = freezed,Object? creatorPrimaryCategory = freezed,}) {
  return _then(ShortlistMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shortlistId: null == shortlistId ? _self.shortlistId : shortlistId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,addedBy: null == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShortlistMemberStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,creatorDisplayName: freezed == creatorDisplayName ? _self.creatorDisplayName : creatorDisplayName // ignore: cast_nullable_to_non_nullable
as String?,creatorProfessionalName: freezed == creatorProfessionalName ? _self.creatorProfessionalName : creatorProfessionalName // ignore: cast_nullable_to_non_nullable
as String?,creatorAvatarPath: freezed == creatorAvatarPath ? _self.creatorAvatarPath : creatorAvatarPath // ignore: cast_nullable_to_non_nullable
as String?,creatorCity: freezed == creatorCity ? _self.creatorCity : creatorCity // ignore: cast_nullable_to_non_nullable
as String?,creatorPrimaryCategory: freezed == creatorPrimaryCategory ? _self.creatorPrimaryCategory : creatorPrimaryCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShortlistMember].
extension ShortlistMemberPatterns on ShortlistMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShortlistMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShortlistMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShortlistMember value)  $default,){
final _that = this;
switch (_that) {
case _ShortlistMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShortlistMember value)?  $default,){
final _that = this;
switch (_that) {
case _ShortlistMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String shortlistId,  String creatorId,  String addedBy,  ShortlistMemberStatus status,  String? notes,  DateTime createdAt,  DateTime updatedAt,  String? creatorDisplayName,  String? creatorProfessionalName,  String? creatorAvatarPath,  String? creatorCity,  String? creatorPrimaryCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShortlistMember() when $default != null:
return $default(_that.id,_that.shortlistId,_that.creatorId,_that.addedBy,_that.status,_that.notes,_that.createdAt,_that.updatedAt,_that.creatorDisplayName,_that.creatorProfessionalName,_that.creatorAvatarPath,_that.creatorCity,_that.creatorPrimaryCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String shortlistId,  String creatorId,  String addedBy,  ShortlistMemberStatus status,  String? notes,  DateTime createdAt,  DateTime updatedAt,  String? creatorDisplayName,  String? creatorProfessionalName,  String? creatorAvatarPath,  String? creatorCity,  String? creatorPrimaryCategory)  $default,) {final _that = this;
switch (_that) {
case _ShortlistMember():
return $default(_that.id,_that.shortlistId,_that.creatorId,_that.addedBy,_that.status,_that.notes,_that.createdAt,_that.updatedAt,_that.creatorDisplayName,_that.creatorProfessionalName,_that.creatorAvatarPath,_that.creatorCity,_that.creatorPrimaryCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String shortlistId,  String creatorId,  String addedBy,  ShortlistMemberStatus status,  String? notes,  DateTime createdAt,  DateTime updatedAt,  String? creatorDisplayName,  String? creatorProfessionalName,  String? creatorAvatarPath,  String? creatorCity,  String? creatorPrimaryCategory)?  $default,) {final _that = this;
switch (_that) {
case _ShortlistMember() when $default != null:
return $default(_that.id,_that.shortlistId,_that.creatorId,_that.addedBy,_that.status,_that.notes,_that.createdAt,_that.updatedAt,_that.creatorDisplayName,_that.creatorProfessionalName,_that.creatorAvatarPath,_that.creatorCity,_that.creatorPrimaryCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShortlistMember implements ShortlistMember {
  const _ShortlistMember({required this.id, required this.shortlistId, required this.creatorId, required this.addedBy, this.status = ShortlistMemberStatus.potential, this.notes, required this.createdAt, required this.updatedAt, this.creatorDisplayName, this.creatorProfessionalName, this.creatorAvatarPath, this.creatorCity, this.creatorPrimaryCategory});
  factory _ShortlistMember.fromJson(Map<String, dynamic> json) => _$ShortlistMemberFromJson(json);

@override final  String id;
@override final  String shortlistId;
@override final  String creatorId;
@override final  String addedBy;
@override@JsonKey() final  ShortlistMemberStatus status;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? creatorDisplayName;
@override final  String? creatorProfessionalName;
@override final  String? creatorAvatarPath;
@override final  String? creatorCity;
@override final  String? creatorPrimaryCategory;

/// Create a copy of ShortlistMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShortlistMemberCopyWith<_ShortlistMember> get copyWith => __$ShortlistMemberCopyWithImpl<_ShortlistMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShortlistMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShortlistMember&&(identical(other.id, id) || other.id == id)&&(identical(other.shortlistId, shortlistId) || other.shortlistId == shortlistId)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.addedBy, addedBy) || other.addedBy == addedBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.creatorDisplayName, creatorDisplayName) || other.creatorDisplayName == creatorDisplayName)&&(identical(other.creatorProfessionalName, creatorProfessionalName) || other.creatorProfessionalName == creatorProfessionalName)&&(identical(other.creatorAvatarPath, creatorAvatarPath) || other.creatorAvatarPath == creatorAvatarPath)&&(identical(other.creatorCity, creatorCity) || other.creatorCity == creatorCity)&&(identical(other.creatorPrimaryCategory, creatorPrimaryCategory) || other.creatorPrimaryCategory == creatorPrimaryCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,shortlistId,creatorId,addedBy,status,notes,createdAt,updatedAt,creatorDisplayName,creatorProfessionalName,creatorAvatarPath,creatorCity,creatorPrimaryCategory);
}

@override
String toString() {
    return 'ShortlistMember(id: $id, shortlistId: $shortlistId, creatorId: $creatorId, addedBy: $addedBy, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, creatorDisplayName: $creatorDisplayName, creatorProfessionalName: $creatorProfessionalName, creatorAvatarPath: $creatorAvatarPath, creatorCity: $creatorCity, creatorPrimaryCategory: $creatorPrimaryCategory)';
}


}

/// @nodoc
abstract mixin class _$ShortlistMemberCopyWith<$Res> implements $ShortlistMemberCopyWith<$Res> {
  factory _$ShortlistMemberCopyWith(_ShortlistMember value, $Res Function(_ShortlistMember) _then) = __$ShortlistMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String shortlistId, String creatorId, String addedBy, ShortlistMemberStatus status, String? notes, DateTime createdAt, DateTime updatedAt, String? creatorDisplayName, String? creatorProfessionalName, String? creatorAvatarPath, String? creatorCity, String? creatorPrimaryCategory
});




}
/// @nodoc
class __$ShortlistMemberCopyWithImpl<$Res>
    implements _$ShortlistMemberCopyWith<$Res> {
  __$ShortlistMemberCopyWithImpl(this._self, this._then);

  final _ShortlistMember _self;
  final $Res Function(_ShortlistMember) _then;

/// Create a copy of ShortlistMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shortlistId = null,Object? creatorId = null,Object? addedBy = null,Object? status = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? creatorDisplayName = freezed,Object? creatorProfessionalName = freezed,Object? creatorAvatarPath = freezed,Object? creatorCity = freezed,Object? creatorPrimaryCategory = freezed,}) {
  return _then(_ShortlistMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shortlistId: null == shortlistId ? _self.shortlistId : shortlistId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,addedBy: null == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShortlistMemberStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,creatorDisplayName: freezed == creatorDisplayName ? _self.creatorDisplayName : creatorDisplayName // ignore: cast_nullable_to_non_nullable
as String?,creatorProfessionalName: freezed == creatorProfessionalName ? _self.creatorProfessionalName : creatorProfessionalName // ignore: cast_nullable_to_non_nullable
as String?,creatorAvatarPath: freezed == creatorAvatarPath ? _self.creatorAvatarPath : creatorAvatarPath // ignore: cast_nullable_to_non_nullable
as String?,creatorCity: freezed == creatorCity ? _self.creatorCity : creatorCity // ignore: cast_nullable_to_non_nullable
as String?,creatorPrimaryCategory: freezed == creatorPrimaryCategory ? _self.creatorPrimaryCategory : creatorPrimaryCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
