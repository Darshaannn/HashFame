// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creator_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatorManagerRelationship {

 String get id; String get creatorId; String get managerId; String? get managerName; String? get managerCompany; ManagerRelationshipStatus get status; String? get notes; DateTime? get createdAt;
/// Create a copy of CreatorManagerRelationship
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatorManagerRelationshipCopyWith<CreatorManagerRelationship> get copyWith => _$CreatorManagerRelationshipCopyWithImpl<CreatorManagerRelationship>(this as CreatorManagerRelationship, _$identity);

  /// Serializes this CreatorManagerRelationship to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreatorManagerRelationship;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatorManagerRelationship&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.creatorId, _this.creatorId) || other.creatorId == _this.creatorId)&&(identical(other.managerId, _this.managerId) || other.managerId == _this.managerId)&&(identical(other.managerName, _this.managerName) || other.managerName == _this.managerName)&&(identical(other.managerCompany, _this.managerCompany) || other.managerCompany == _this.managerCompany)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreatorManagerRelationship;
  return Object.hash(runtimeType,_this.id,_this.creatorId,_this.managerId,_this.managerName,_this.managerCompany,_this.status,_this.notes,_this.createdAt);
}

@override
String toString() {
  final _this = this as CreatorManagerRelationship;
  return 'CreatorManagerRelationship(id: ${_this.id}, creatorId: ${_this.creatorId}, managerId: ${_this.managerId}, managerName: ${_this.managerName}, managerCompany: ${_this.managerCompany}, status: ${_this.status}, notes: ${_this.notes}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CreatorManagerRelationshipCopyWith<$Res>  {
  factory $CreatorManagerRelationshipCopyWith(CreatorManagerRelationship value, $Res Function(CreatorManagerRelationship) _then) = _$CreatorManagerRelationshipCopyWithImpl;
@useResult
$Res call({
 String id, String creatorId, String managerId, String? managerName, String? managerCompany, ManagerRelationshipStatus status, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$CreatorManagerRelationshipCopyWithImpl<$Res>
    implements $CreatorManagerRelationshipCopyWith<$Res> {
  _$CreatorManagerRelationshipCopyWithImpl(this._self, this._then);

  final CreatorManagerRelationship _self;
  final $Res Function(CreatorManagerRelationship) _then;

/// Create a copy of CreatorManagerRelationship
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? creatorId = null,Object? managerId = null,Object? managerName = freezed,Object? managerCompany = freezed,Object? status = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(CreatorManagerRelationship(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,managerId: null == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String,managerName: freezed == managerName ? _self.managerName : managerName // ignore: cast_nullable_to_non_nullable
as String?,managerCompany: freezed == managerCompany ? _self.managerCompany : managerCompany // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ManagerRelationshipStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatorManagerRelationship].
extension CreatorManagerRelationshipPatterns on CreatorManagerRelationship {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatorManagerRelationship value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatorManagerRelationship() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatorManagerRelationship value)  $default,){
final _that = this;
switch (_that) {
case _CreatorManagerRelationship():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatorManagerRelationship value)?  $default,){
final _that = this;
switch (_that) {
case _CreatorManagerRelationship() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String creatorId,  String managerId,  String? managerName,  String? managerCompany,  ManagerRelationshipStatus status,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatorManagerRelationship() when $default != null:
return $default(_that.id,_that.creatorId,_that.managerId,_that.managerName,_that.managerCompany,_that.status,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String creatorId,  String managerId,  String? managerName,  String? managerCompany,  ManagerRelationshipStatus status,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CreatorManagerRelationship():
return $default(_that.id,_that.creatorId,_that.managerId,_that.managerName,_that.managerCompany,_that.status,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String creatorId,  String managerId,  String? managerName,  String? managerCompany,  ManagerRelationshipStatus status,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CreatorManagerRelationship() when $default != null:
return $default(_that.id,_that.creatorId,_that.managerId,_that.managerName,_that.managerCompany,_that.status,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatorManagerRelationship implements CreatorManagerRelationship {
  const _CreatorManagerRelationship({required this.id, required this.creatorId, required this.managerId, this.managerName, this.managerCompany, this.status = ManagerRelationshipStatus.pending, this.notes, this.createdAt});
  factory _CreatorManagerRelationship.fromJson(Map<String, dynamic> json) => _$CreatorManagerRelationshipFromJson(json);

@override final  String id;
@override final  String creatorId;
@override final  String managerId;
@override final  String? managerName;
@override final  String? managerCompany;
@override@JsonKey() final  ManagerRelationshipStatus status;
@override final  String? notes;
@override final  DateTime? createdAt;

/// Create a copy of CreatorManagerRelationship
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatorManagerRelationshipCopyWith<_CreatorManagerRelationship> get copyWith => __$CreatorManagerRelationshipCopyWithImpl<_CreatorManagerRelationship>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatorManagerRelationshipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatorManagerRelationship&&(identical(other.id, id) || other.id == id)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.managerName, managerName) || other.managerName == managerName)&&(identical(other.managerCompany, managerCompany) || other.managerCompany == managerCompany)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,creatorId,managerId,managerName,managerCompany,status,notes,createdAt);
}

@override
String toString() {
    return 'CreatorManagerRelationship(id: $id, creatorId: $creatorId, managerId: $managerId, managerName: $managerName, managerCompany: $managerCompany, status: $status, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CreatorManagerRelationshipCopyWith<$Res> implements $CreatorManagerRelationshipCopyWith<$Res> {
  factory _$CreatorManagerRelationshipCopyWith(_CreatorManagerRelationship value, $Res Function(_CreatorManagerRelationship) _then) = __$CreatorManagerRelationshipCopyWithImpl;
@override @useResult
$Res call({
 String id, String creatorId, String managerId, String? managerName, String? managerCompany, ManagerRelationshipStatus status, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$CreatorManagerRelationshipCopyWithImpl<$Res>
    implements _$CreatorManagerRelationshipCopyWith<$Res> {
  __$CreatorManagerRelationshipCopyWithImpl(this._self, this._then);

  final _CreatorManagerRelationship _self;
  final $Res Function(_CreatorManagerRelationship) _then;

/// Create a copy of CreatorManagerRelationship
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? creatorId = null,Object? managerId = null,Object? managerName = freezed,Object? managerCompany = freezed,Object? status = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_CreatorManagerRelationship(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,managerId: null == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String,managerName: freezed == managerName ? _self.managerName : managerName // ignore: cast_nullable_to_non_nullable
as String?,managerCompany: freezed == managerCompany ? _self.managerCompany : managerCompany // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ManagerRelationshipStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
