// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collaboration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PastCollaboration {

 String get id; String get userId; String get brandName; String? get campaignName; int? get collaborationYear; DeliverableType get deliverableType; String? get proofUrl; CollaborationProofType get proofType;
/// Create a copy of PastCollaboration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PastCollaborationCopyWith<PastCollaboration> get copyWith => _$PastCollaborationCopyWithImpl<PastCollaboration>(this as PastCollaboration, _$identity);

  /// Serializes this PastCollaboration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PastCollaboration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PastCollaboration&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.brandName, _this.brandName) || other.brandName == _this.brandName)&&(identical(other.campaignName, _this.campaignName) || other.campaignName == _this.campaignName)&&(identical(other.collaborationYear, _this.collaborationYear) || other.collaborationYear == _this.collaborationYear)&&(identical(other.deliverableType, _this.deliverableType) || other.deliverableType == _this.deliverableType)&&(identical(other.proofUrl, _this.proofUrl) || other.proofUrl == _this.proofUrl)&&(identical(other.proofType, _this.proofType) || other.proofType == _this.proofType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PastCollaboration;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.brandName,_this.campaignName,_this.collaborationYear,_this.deliverableType,_this.proofUrl,_this.proofType);
}

@override
String toString() {
  final _this = this as PastCollaboration;
  return 'PastCollaboration(id: ${_this.id}, userId: ${_this.userId}, brandName: ${_this.brandName}, campaignName: ${_this.campaignName}, collaborationYear: ${_this.collaborationYear}, deliverableType: ${_this.deliverableType}, proofUrl: ${_this.proofUrl}, proofType: ${_this.proofType})';
}


}

/// @nodoc
abstract mixin class $PastCollaborationCopyWith<$Res>  {
  factory $PastCollaborationCopyWith(PastCollaboration value, $Res Function(PastCollaboration) _then) = _$PastCollaborationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String brandName, String? campaignName, int? collaborationYear, DeliverableType deliverableType, String? proofUrl, CollaborationProofType proofType
});




}
/// @nodoc
class _$PastCollaborationCopyWithImpl<$Res>
    implements $PastCollaborationCopyWith<$Res> {
  _$PastCollaborationCopyWithImpl(this._self, this._then);

  final PastCollaboration _self;
  final $Res Function(PastCollaboration) _then;

/// Create a copy of PastCollaboration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? brandName = null,Object? campaignName = freezed,Object? collaborationYear = freezed,Object? deliverableType = null,Object? proofUrl = freezed,Object? proofType = null,}) {
  return _then(PastCollaboration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,campaignName: freezed == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String?,collaborationYear: freezed == collaborationYear ? _self.collaborationYear : collaborationYear // ignore: cast_nullable_to_non_nullable
as int?,deliverableType: null == deliverableType ? _self.deliverableType : deliverableType // ignore: cast_nullable_to_non_nullable
as DeliverableType,proofUrl: freezed == proofUrl ? _self.proofUrl : proofUrl // ignore: cast_nullable_to_non_nullable
as String?,proofType: null == proofType ? _self.proofType : proofType // ignore: cast_nullable_to_non_nullable
as CollaborationProofType,
  ));
}

}


/// Adds pattern-matching-related methods to [PastCollaboration].
extension PastCollaborationPatterns on PastCollaboration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PastCollaboration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PastCollaboration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PastCollaboration value)  $default,){
final _that = this;
switch (_that) {
case _PastCollaboration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PastCollaboration value)?  $default,){
final _that = this;
switch (_that) {
case _PastCollaboration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String brandName,  String? campaignName,  int? collaborationYear,  DeliverableType deliverableType,  String? proofUrl,  CollaborationProofType proofType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PastCollaboration() when $default != null:
return $default(_that.id,_that.userId,_that.brandName,_that.campaignName,_that.collaborationYear,_that.deliverableType,_that.proofUrl,_that.proofType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String brandName,  String? campaignName,  int? collaborationYear,  DeliverableType deliverableType,  String? proofUrl,  CollaborationProofType proofType)  $default,) {final _that = this;
switch (_that) {
case _PastCollaboration():
return $default(_that.id,_that.userId,_that.brandName,_that.campaignName,_that.collaborationYear,_that.deliverableType,_that.proofUrl,_that.proofType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String brandName,  String? campaignName,  int? collaborationYear,  DeliverableType deliverableType,  String? proofUrl,  CollaborationProofType proofType)?  $default,) {final _that = this;
switch (_that) {
case _PastCollaboration() when $default != null:
return $default(_that.id,_that.userId,_that.brandName,_that.campaignName,_that.collaborationYear,_that.deliverableType,_that.proofUrl,_that.proofType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PastCollaboration implements PastCollaboration {
  const _PastCollaboration({required this.id, required this.userId, required this.brandName, this.campaignName, this.collaborationYear, this.deliverableType = DeliverableType.instagramReel, this.proofUrl, this.proofType = CollaborationProofType.selfReported});
  factory _PastCollaboration.fromJson(Map<String, dynamic> json) => _$PastCollaborationFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String brandName;
@override final  String? campaignName;
@override final  int? collaborationYear;
@override@JsonKey() final  DeliverableType deliverableType;
@override final  String? proofUrl;
@override@JsonKey() final  CollaborationProofType proofType;

/// Create a copy of PastCollaboration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PastCollaborationCopyWith<_PastCollaboration> get copyWith => __$PastCollaborationCopyWithImpl<_PastCollaboration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PastCollaborationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PastCollaboration&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.collaborationYear, collaborationYear) || other.collaborationYear == collaborationYear)&&(identical(other.deliverableType, deliverableType) || other.deliverableType == deliverableType)&&(identical(other.proofUrl, proofUrl) || other.proofUrl == proofUrl)&&(identical(other.proofType, proofType) || other.proofType == proofType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,brandName,campaignName,collaborationYear,deliverableType,proofUrl,proofType);
}

@override
String toString() {
    return 'PastCollaboration(id: $id, userId: $userId, brandName: $brandName, campaignName: $campaignName, collaborationYear: $collaborationYear, deliverableType: $deliverableType, proofUrl: $proofUrl, proofType: $proofType)';
}


}

/// @nodoc
abstract mixin class _$PastCollaborationCopyWith<$Res> implements $PastCollaborationCopyWith<$Res> {
  factory _$PastCollaborationCopyWith(_PastCollaboration value, $Res Function(_PastCollaboration) _then) = __$PastCollaborationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String brandName, String? campaignName, int? collaborationYear, DeliverableType deliverableType, String? proofUrl, CollaborationProofType proofType
});




}
/// @nodoc
class __$PastCollaborationCopyWithImpl<$Res>
    implements _$PastCollaborationCopyWith<$Res> {
  __$PastCollaborationCopyWithImpl(this._self, this._then);

  final _PastCollaboration _self;
  final $Res Function(_PastCollaboration) _then;

/// Create a copy of PastCollaboration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? brandName = null,Object? campaignName = freezed,Object? collaborationYear = freezed,Object? deliverableType = null,Object? proofUrl = freezed,Object? proofType = null,}) {
  return _then(_PastCollaboration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,campaignName: freezed == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String?,collaborationYear: freezed == collaborationYear ? _self.collaborationYear : collaborationYear // ignore: cast_nullable_to_non_nullable
as int?,deliverableType: null == deliverableType ? _self.deliverableType : deliverableType // ignore: cast_nullable_to_non_nullable
as DeliverableType,proofUrl: freezed == proofUrl ? _self.proofUrl : proofUrl // ignore: cast_nullable_to_non_nullable
as String?,proofType: null == proofType ? _self.proofType : proofType // ignore: cast_nullable_to_non_nullable
as CollaborationProofType,
  ));
}


}

// dart format on
