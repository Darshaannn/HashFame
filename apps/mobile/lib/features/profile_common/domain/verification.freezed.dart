// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldVerification {

 String get id; String get userId; VerificationSubject get subject; String get subjectId; FieldVerificationStatus get status; DateTime? get verifiedAt; DateTime? get expiresAt; String? get notes;
/// Create a copy of FieldVerification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldVerificationCopyWith<FieldVerification> get copyWith => _$FieldVerificationCopyWithImpl<FieldVerification>(this as FieldVerification, _$identity);

  /// Serializes this FieldVerification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FieldVerification;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldVerification&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.verifiedAt, _this.verifiedAt) || other.verifiedAt == _this.verifiedAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FieldVerification;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.subject,_this.subjectId,_this.status,_this.verifiedAt,_this.expiresAt,_this.notes);
}

@override
String toString() {
  final _this = this as FieldVerification;
  return 'FieldVerification(id: ${_this.id}, userId: ${_this.userId}, subject: ${_this.subject}, subjectId: ${_this.subjectId}, status: ${_this.status}, verifiedAt: ${_this.verifiedAt}, expiresAt: ${_this.expiresAt}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $FieldVerificationCopyWith<$Res>  {
  factory $FieldVerificationCopyWith(FieldVerification value, $Res Function(FieldVerification) _then) = _$FieldVerificationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, VerificationSubject subject, String subjectId, FieldVerificationStatus status, DateTime? verifiedAt, DateTime? expiresAt, String? notes
});




}
/// @nodoc
class _$FieldVerificationCopyWithImpl<$Res>
    implements $FieldVerificationCopyWith<$Res> {
  _$FieldVerificationCopyWithImpl(this._self, this._then);

  final FieldVerification _self;
  final $Res Function(FieldVerification) _then;

/// Create a copy of FieldVerification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? subject = null,Object? subjectId = null,Object? status = null,Object? verifiedAt = freezed,Object? expiresAt = freezed,Object? notes = freezed,}) {
  return _then(FieldVerification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as VerificationSubject,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldVerification].
extension FieldVerificationPatterns on FieldVerification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldVerification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldVerification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldVerification value)  $default,){
final _that = this;
switch (_that) {
case _FieldVerification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldVerification value)?  $default,){
final _that = this;
switch (_that) {
case _FieldVerification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  VerificationSubject subject,  String subjectId,  FieldVerificationStatus status,  DateTime? verifiedAt,  DateTime? expiresAt,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldVerification() when $default != null:
return $default(_that.id,_that.userId,_that.subject,_that.subjectId,_that.status,_that.verifiedAt,_that.expiresAt,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  VerificationSubject subject,  String subjectId,  FieldVerificationStatus status,  DateTime? verifiedAt,  DateTime? expiresAt,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _FieldVerification():
return $default(_that.id,_that.userId,_that.subject,_that.subjectId,_that.status,_that.verifiedAt,_that.expiresAt,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  VerificationSubject subject,  String subjectId,  FieldVerificationStatus status,  DateTime? verifiedAt,  DateTime? expiresAt,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _FieldVerification() when $default != null:
return $default(_that.id,_that.userId,_that.subject,_that.subjectId,_that.status,_that.verifiedAt,_that.expiresAt,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FieldVerification implements FieldVerification {
  const _FieldVerification({required this.id, required this.userId, required this.subject, this.subjectId = '', required this.status, this.verifiedAt, this.expiresAt, this.notes});
  factory _FieldVerification.fromJson(Map<String, dynamic> json) => _$FieldVerificationFromJson(json);

@override final  String id;
@override final  String userId;
@override final  VerificationSubject subject;
@override@JsonKey() final  String subjectId;
@override final  FieldVerificationStatus status;
@override final  DateTime? verifiedAt;
@override final  DateTime? expiresAt;
@override final  String? notes;

/// Create a copy of FieldVerification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldVerificationCopyWith<_FieldVerification> get copyWith => __$FieldVerificationCopyWithImpl<_FieldVerification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldVerificationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldVerification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.status, status) || other.status == status)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,subject,subjectId,status,verifiedAt,expiresAt,notes);
}

@override
String toString() {
    return 'FieldVerification(id: $id, userId: $userId, subject: $subject, subjectId: $subjectId, status: $status, verifiedAt: $verifiedAt, expiresAt: $expiresAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$FieldVerificationCopyWith<$Res> implements $FieldVerificationCopyWith<$Res> {
  factory _$FieldVerificationCopyWith(_FieldVerification value, $Res Function(_FieldVerification) _then) = __$FieldVerificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, VerificationSubject subject, String subjectId, FieldVerificationStatus status, DateTime? verifiedAt, DateTime? expiresAt, String? notes
});




}
/// @nodoc
class __$FieldVerificationCopyWithImpl<$Res>
    implements _$FieldVerificationCopyWith<$Res> {
  __$FieldVerificationCopyWithImpl(this._self, this._then);

  final _FieldVerification _self;
  final $Res Function(_FieldVerification) _then;

/// Create a copy of FieldVerification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? subject = null,Object? subjectId = null,Object? status = null,Object? verifiedAt = freezed,Object? expiresAt = freezed,Object? notes = freezed,}) {
  return _then(_FieldVerification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as VerificationSubject,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VerificationSummary {

 FieldVerificationStatus get identityStatus; FieldVerificationStatus get emailStatus; FieldVerificationStatus get phoneStatus; FieldVerificationStatus get socialStatus; FieldVerificationStatus get managerStatus; FieldVerificationStatus get companyStatus; List<FieldVerification> get items;
/// Create a copy of VerificationSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationSummaryCopyWith<VerificationSummary> get copyWith => _$VerificationSummaryCopyWithImpl<VerificationSummary>(this as VerificationSummary, _$identity);

  /// Serializes this VerificationSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VerificationSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationSummary&&(identical(other.identityStatus, _this.identityStatus) || other.identityStatus == _this.identityStatus)&&(identical(other.emailStatus, _this.emailStatus) || other.emailStatus == _this.emailStatus)&&(identical(other.phoneStatus, _this.phoneStatus) || other.phoneStatus == _this.phoneStatus)&&(identical(other.socialStatus, _this.socialStatus) || other.socialStatus == _this.socialStatus)&&(identical(other.managerStatus, _this.managerStatus) || other.managerStatus == _this.managerStatus)&&(identical(other.companyStatus, _this.companyStatus) || other.companyStatus == _this.companyStatus)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VerificationSummary;
  return Object.hash(runtimeType,_this.identityStatus,_this.emailStatus,_this.phoneStatus,_this.socialStatus,_this.managerStatus,_this.companyStatus,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as VerificationSummary;
  return 'VerificationSummary(identityStatus: ${_this.identityStatus}, emailStatus: ${_this.emailStatus}, phoneStatus: ${_this.phoneStatus}, socialStatus: ${_this.socialStatus}, managerStatus: ${_this.managerStatus}, companyStatus: ${_this.companyStatus}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $VerificationSummaryCopyWith<$Res>  {
  factory $VerificationSummaryCopyWith(VerificationSummary value, $Res Function(VerificationSummary) _then) = _$VerificationSummaryCopyWithImpl;
@useResult
$Res call({
 FieldVerificationStatus identityStatus, FieldVerificationStatus emailStatus, FieldVerificationStatus phoneStatus, FieldVerificationStatus socialStatus, FieldVerificationStatus managerStatus, FieldVerificationStatus companyStatus, List<FieldVerification> items
});




}
/// @nodoc
class _$VerificationSummaryCopyWithImpl<$Res>
    implements $VerificationSummaryCopyWith<$Res> {
  _$VerificationSummaryCopyWithImpl(this._self, this._then);

  final VerificationSummary _self;
  final $Res Function(VerificationSummary) _then;

/// Create a copy of VerificationSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identityStatus = null,Object? emailStatus = null,Object? phoneStatus = null,Object? socialStatus = null,Object? managerStatus = null,Object? companyStatus = null,Object? items = null,}) {
  return _then(VerificationSummary(
identityStatus: null == identityStatus ? _self.identityStatus : identityStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,emailStatus: null == emailStatus ? _self.emailStatus : emailStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,phoneStatus: null == phoneStatus ? _self.phoneStatus : phoneStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,socialStatus: null == socialStatus ? _self.socialStatus : socialStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,managerStatus: null == managerStatus ? _self.managerStatus : managerStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,companyStatus: null == companyStatus ? _self.companyStatus : companyStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FieldVerification>,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationSummary].
extension VerificationSummaryPatterns on VerificationSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationSummary value)  $default,){
final _that = this;
switch (_that) {
case _VerificationSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationSummary value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FieldVerificationStatus identityStatus,  FieldVerificationStatus emailStatus,  FieldVerificationStatus phoneStatus,  FieldVerificationStatus socialStatus,  FieldVerificationStatus managerStatus,  FieldVerificationStatus companyStatus,  List<FieldVerification> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationSummary() when $default != null:
return $default(_that.identityStatus,_that.emailStatus,_that.phoneStatus,_that.socialStatus,_that.managerStatus,_that.companyStatus,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FieldVerificationStatus identityStatus,  FieldVerificationStatus emailStatus,  FieldVerificationStatus phoneStatus,  FieldVerificationStatus socialStatus,  FieldVerificationStatus managerStatus,  FieldVerificationStatus companyStatus,  List<FieldVerification> items)  $default,) {final _that = this;
switch (_that) {
case _VerificationSummary():
return $default(_that.identityStatus,_that.emailStatus,_that.phoneStatus,_that.socialStatus,_that.managerStatus,_that.companyStatus,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FieldVerificationStatus identityStatus,  FieldVerificationStatus emailStatus,  FieldVerificationStatus phoneStatus,  FieldVerificationStatus socialStatus,  FieldVerificationStatus managerStatus,  FieldVerificationStatus companyStatus,  List<FieldVerification> items)?  $default,) {final _that = this;
switch (_that) {
case _VerificationSummary() when $default != null:
return $default(_that.identityStatus,_that.emailStatus,_that.phoneStatus,_that.socialStatus,_that.managerStatus,_that.companyStatus,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerificationSummary implements VerificationSummary {
  const _VerificationSummary({this.identityStatus = FieldVerificationStatus.notStarted, this.emailStatus = FieldVerificationStatus.notStarted, this.phoneStatus = FieldVerificationStatus.notStarted, this.socialStatus = FieldVerificationStatus.notStarted, this.managerStatus = FieldVerificationStatus.notStarted, this.companyStatus = FieldVerificationStatus.notStarted,  List<FieldVerification> items = const []}): _items = items;
  factory _VerificationSummary.fromJson(Map<String, dynamic> json) => _$VerificationSummaryFromJson(json);

@override@JsonKey() final  FieldVerificationStatus identityStatus;
@override@JsonKey() final  FieldVerificationStatus emailStatus;
@override@JsonKey() final  FieldVerificationStatus phoneStatus;
@override@JsonKey() final  FieldVerificationStatus socialStatus;
@override@JsonKey() final  FieldVerificationStatus managerStatus;
@override@JsonKey() final  FieldVerificationStatus companyStatus;
 final  List<FieldVerification> _items;
@override@JsonKey() List<FieldVerification> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of VerificationSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationSummaryCopyWith<_VerificationSummary> get copyWith => __$VerificationSummaryCopyWithImpl<_VerificationSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerificationSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationSummary&&(identical(other.identityStatus, identityStatus) || other.identityStatus == identityStatus)&&(identical(other.emailStatus, emailStatus) || other.emailStatus == emailStatus)&&(identical(other.phoneStatus, phoneStatus) || other.phoneStatus == phoneStatus)&&(identical(other.socialStatus, socialStatus) || other.socialStatus == socialStatus)&&(identical(other.managerStatus, managerStatus) || other.managerStatus == managerStatus)&&(identical(other.companyStatus, companyStatus) || other.companyStatus == companyStatus)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,identityStatus,emailStatus,phoneStatus,socialStatus,managerStatus,companyStatus,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'VerificationSummary(identityStatus: $identityStatus, emailStatus: $emailStatus, phoneStatus: $phoneStatus, socialStatus: $socialStatus, managerStatus: $managerStatus, companyStatus: $companyStatus, items: $items)';
}


}

/// @nodoc
abstract mixin class _$VerificationSummaryCopyWith<$Res> implements $VerificationSummaryCopyWith<$Res> {
  factory _$VerificationSummaryCopyWith(_VerificationSummary value, $Res Function(_VerificationSummary) _then) = __$VerificationSummaryCopyWithImpl;
@override @useResult
$Res call({
 FieldVerificationStatus identityStatus, FieldVerificationStatus emailStatus, FieldVerificationStatus phoneStatus, FieldVerificationStatus socialStatus, FieldVerificationStatus managerStatus, FieldVerificationStatus companyStatus, List<FieldVerification> items
});




}
/// @nodoc
class __$VerificationSummaryCopyWithImpl<$Res>
    implements _$VerificationSummaryCopyWith<$Res> {
  __$VerificationSummaryCopyWithImpl(this._self, this._then);

  final _VerificationSummary _self;
  final $Res Function(_VerificationSummary) _then;

/// Create a copy of VerificationSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identityStatus = null,Object? emailStatus = null,Object? phoneStatus = null,Object? socialStatus = null,Object? managerStatus = null,Object? companyStatus = null,Object? items = null,}) {
  return _then(_VerificationSummary(
identityStatus: null == identityStatus ? _self.identityStatus : identityStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,emailStatus: null == emailStatus ? _self.emailStatus : emailStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,phoneStatus: null == phoneStatus ? _self.phoneStatus : phoneStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,socialStatus: null == socialStatus ? _self.socialStatus : socialStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,managerStatus: null == managerStatus ? _self.managerStatus : managerStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,companyStatus: null == companyStatus ? _self.companyStatus : companyStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<FieldVerification>,
  ));
}


}

// dart format on
