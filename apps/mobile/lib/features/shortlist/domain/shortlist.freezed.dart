// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shortlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Shortlist {

 String get id; String get organizationId; String get createdBy; String get name; String? get description; bool get isArchived; DateTime get createdAt; DateTime get updatedAt; int get memberCount; List<ShortlistMember> get members;
/// Create a copy of Shortlist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortlistCopyWith<Shortlist> get copyWith => _$ShortlistCopyWithImpl<Shortlist>(this as Shortlist, _$identity);

  /// Serializes this Shortlist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Shortlist;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Shortlist&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.isArchived, _this.isArchived) || other.isArchived == _this.isArchived)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&const DeepCollectionEquality().equals(other.members, _this.members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Shortlist;
  return Object.hash(runtimeType,_this.id,_this.organizationId,_this.createdBy,_this.name,_this.description,_this.isArchived,_this.createdAt,_this.updatedAt,_this.memberCount,const DeepCollectionEquality().hash(_this.members));
}

@override
String toString() {
  final _this = this as Shortlist;
  return 'Shortlist(id: ${_this.id}, organizationId: ${_this.organizationId}, createdBy: ${_this.createdBy}, name: ${_this.name}, description: ${_this.description}, isArchived: ${_this.isArchived}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, memberCount: ${_this.memberCount}, members: ${_this.members})';
}


}

/// @nodoc
abstract mixin class $ShortlistCopyWith<$Res>  {
  factory $ShortlistCopyWith(Shortlist value, $Res Function(Shortlist) _then) = _$ShortlistCopyWithImpl;
@useResult
$Res call({
 String id, String organizationId, String createdBy, String name, String? description, bool isArchived, DateTime createdAt, DateTime updatedAt, int memberCount, List<ShortlistMember> members
});




}
/// @nodoc
class _$ShortlistCopyWithImpl<$Res>
    implements $ShortlistCopyWith<$Res> {
  _$ShortlistCopyWithImpl(this._self, this._then);

  final Shortlist _self;
  final $Res Function(Shortlist) _then;

/// Create a copy of Shortlist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organizationId = null,Object? createdBy = null,Object? name = null,Object? description = freezed,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = null,Object? memberCount = null,Object? members = null,}) {
  return _then(Shortlist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<ShortlistMember>,
  ));
}

}


/// Adds pattern-matching-related methods to [Shortlist].
extension ShortlistPatterns on Shortlist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Shortlist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Shortlist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Shortlist value)  $default,){
final _that = this;
switch (_that) {
case _Shortlist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Shortlist value)?  $default,){
final _that = this;
switch (_that) {
case _Shortlist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String organizationId,  String createdBy,  String name,  String? description,  bool isArchived,  DateTime createdAt,  DateTime updatedAt,  int memberCount,  List<ShortlistMember> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Shortlist() when $default != null:
return $default(_that.id,_that.organizationId,_that.createdBy,_that.name,_that.description,_that.isArchived,_that.createdAt,_that.updatedAt,_that.memberCount,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String organizationId,  String createdBy,  String name,  String? description,  bool isArchived,  DateTime createdAt,  DateTime updatedAt,  int memberCount,  List<ShortlistMember> members)  $default,) {final _that = this;
switch (_that) {
case _Shortlist():
return $default(_that.id,_that.organizationId,_that.createdBy,_that.name,_that.description,_that.isArchived,_that.createdAt,_that.updatedAt,_that.memberCount,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String organizationId,  String createdBy,  String name,  String? description,  bool isArchived,  DateTime createdAt,  DateTime updatedAt,  int memberCount,  List<ShortlistMember> members)?  $default,) {final _that = this;
switch (_that) {
case _Shortlist() when $default != null:
return $default(_that.id,_that.organizationId,_that.createdBy,_that.name,_that.description,_that.isArchived,_that.createdAt,_that.updatedAt,_that.memberCount,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Shortlist implements Shortlist {
  const _Shortlist({required this.id, required this.organizationId, required this.createdBy, required this.name, this.description, this.isArchived = false, required this.createdAt, required this.updatedAt, this.memberCount = 0,  List<ShortlistMember> members = const []}): _members = members;
  factory _Shortlist.fromJson(Map<String, dynamic> json) => _$ShortlistFromJson(json);

@override final  String id;
@override final  String organizationId;
@override final  String createdBy;
@override final  String name;
@override final  String? description;
@override@JsonKey() final  bool isArchived;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  int memberCount;
 final  List<ShortlistMember> _members;
@override@JsonKey() List<ShortlistMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of Shortlist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShortlistCopyWith<_Shortlist> get copyWith => __$ShortlistCopyWithImpl<_Shortlist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShortlistToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Shortlist&&(identical(other.id, id) || other.id == id)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other.members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,organizationId,createdBy,name,description,isArchived,createdAt,updatedAt,memberCount,const DeepCollectionEquality().hash(_members));
}

@override
String toString() {
    return 'Shortlist(id: $id, organizationId: $organizationId, createdBy: $createdBy, name: $name, description: $description, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, memberCount: $memberCount, members: $members)';
}


}

/// @nodoc
abstract mixin class _$ShortlistCopyWith<$Res> implements $ShortlistCopyWith<$Res> {
  factory _$ShortlistCopyWith(_Shortlist value, $Res Function(_Shortlist) _then) = __$ShortlistCopyWithImpl;
@override @useResult
$Res call({
 String id, String organizationId, String createdBy, String name, String? description, bool isArchived, DateTime createdAt, DateTime updatedAt, int memberCount, List<ShortlistMember> members
});




}
/// @nodoc
class __$ShortlistCopyWithImpl<$Res>
    implements _$ShortlistCopyWith<$Res> {
  __$ShortlistCopyWithImpl(this._self, this._then);

  final _Shortlist _self;
  final $Res Function(_Shortlist) _then;

/// Create a copy of Shortlist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organizationId = null,Object? createdBy = null,Object? name = null,Object? description = freezed,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = null,Object? memberCount = null,Object? members = null,}) {
  return _then(_Shortlist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<ShortlistMember>,
  ));
}


}

// dart format on
