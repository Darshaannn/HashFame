// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampaignApplicationStatusHistory {

 String get id; String get applicationId; CampaignApplicationStatus? get fromStatus; CampaignApplicationStatus get toStatus; String? get changedBy; String? get reason; DateTime get createdAt;
/// Create a copy of CampaignApplicationStatusHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignApplicationStatusHistoryCopyWith<CampaignApplicationStatusHistory> get copyWith => _$CampaignApplicationStatusHistoryCopyWithImpl<CampaignApplicationStatusHistory>(this as CampaignApplicationStatusHistory, _$identity);

  /// Serializes this CampaignApplicationStatusHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CampaignApplicationStatusHistory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignApplicationStatusHistory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.applicationId, _this.applicationId) || other.applicationId == _this.applicationId)&&(identical(other.fromStatus, _this.fromStatus) || other.fromStatus == _this.fromStatus)&&(identical(other.toStatus, _this.toStatus) || other.toStatus == _this.toStatus)&&(identical(other.changedBy, _this.changedBy) || other.changedBy == _this.changedBy)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CampaignApplicationStatusHistory;
  return Object.hash(runtimeType,_this.id,_this.applicationId,_this.fromStatus,_this.toStatus,_this.changedBy,_this.reason,_this.createdAt);
}

@override
String toString() {
  final _this = this as CampaignApplicationStatusHistory;
  return 'CampaignApplicationStatusHistory(id: ${_this.id}, applicationId: ${_this.applicationId}, fromStatus: ${_this.fromStatus}, toStatus: ${_this.toStatus}, changedBy: ${_this.changedBy}, reason: ${_this.reason}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CampaignApplicationStatusHistoryCopyWith<$Res>  {
  factory $CampaignApplicationStatusHistoryCopyWith(CampaignApplicationStatusHistory value, $Res Function(CampaignApplicationStatusHistory) _then) = _$CampaignApplicationStatusHistoryCopyWithImpl;
@useResult
$Res call({
 String id, String applicationId, CampaignApplicationStatus? fromStatus, CampaignApplicationStatus toStatus, String? changedBy, String? reason, DateTime createdAt
});




}
/// @nodoc
class _$CampaignApplicationStatusHistoryCopyWithImpl<$Res>
    implements $CampaignApplicationStatusHistoryCopyWith<$Res> {
  _$CampaignApplicationStatusHistoryCopyWithImpl(this._self, this._then);

  final CampaignApplicationStatusHistory _self;
  final $Res Function(CampaignApplicationStatusHistory) _then;

/// Create a copy of CampaignApplicationStatusHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? applicationId = null,Object? fromStatus = freezed,Object? toStatus = null,Object? changedBy = freezed,Object? reason = freezed,Object? createdAt = null,}) {
  return _then(CampaignApplicationStatusHistory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as CampaignApplicationStatus?,toStatus: null == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as CampaignApplicationStatus,changedBy: freezed == changedBy ? _self.changedBy : changedBy // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignApplicationStatusHistory].
extension CampaignApplicationStatusHistoryPatterns on CampaignApplicationStatusHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignApplicationStatusHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignApplicationStatusHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignApplicationStatusHistory value)  $default,){
final _that = this;
switch (_that) {
case _CampaignApplicationStatusHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignApplicationStatusHistory value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignApplicationStatusHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String applicationId,  CampaignApplicationStatus? fromStatus,  CampaignApplicationStatus toStatus,  String? changedBy,  String? reason,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignApplicationStatusHistory() when $default != null:
return $default(_that.id,_that.applicationId,_that.fromStatus,_that.toStatus,_that.changedBy,_that.reason,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String applicationId,  CampaignApplicationStatus? fromStatus,  CampaignApplicationStatus toStatus,  String? changedBy,  String? reason,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CampaignApplicationStatusHistory():
return $default(_that.id,_that.applicationId,_that.fromStatus,_that.toStatus,_that.changedBy,_that.reason,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String applicationId,  CampaignApplicationStatus? fromStatus,  CampaignApplicationStatus toStatus,  String? changedBy,  String? reason,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CampaignApplicationStatusHistory() when $default != null:
return $default(_that.id,_that.applicationId,_that.fromStatus,_that.toStatus,_that.changedBy,_that.reason,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignApplicationStatusHistory implements CampaignApplicationStatusHistory {
  const _CampaignApplicationStatusHistory({required this.id, required this.applicationId, this.fromStatus, required this.toStatus, this.changedBy, this.reason, required this.createdAt});
  factory _CampaignApplicationStatusHistory.fromJson(Map<String, dynamic> json) => _$CampaignApplicationStatusHistoryFromJson(json);

@override final  String id;
@override final  String applicationId;
@override final  CampaignApplicationStatus? fromStatus;
@override final  CampaignApplicationStatus toStatus;
@override final  String? changedBy;
@override final  String? reason;
@override final  DateTime createdAt;

/// Create a copy of CampaignApplicationStatusHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignApplicationStatusHistoryCopyWith<_CampaignApplicationStatusHistory> get copyWith => __$CampaignApplicationStatusHistoryCopyWithImpl<_CampaignApplicationStatusHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignApplicationStatusHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignApplicationStatusHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.fromStatus, fromStatus) || other.fromStatus == fromStatus)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.changedBy, changedBy) || other.changedBy == changedBy)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,applicationId,fromStatus,toStatus,changedBy,reason,createdAt);
}

@override
String toString() {
    return 'CampaignApplicationStatusHistory(id: $id, applicationId: $applicationId, fromStatus: $fromStatus, toStatus: $toStatus, changedBy: $changedBy, reason: $reason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CampaignApplicationStatusHistoryCopyWith<$Res> implements $CampaignApplicationStatusHistoryCopyWith<$Res> {
  factory _$CampaignApplicationStatusHistoryCopyWith(_CampaignApplicationStatusHistory value, $Res Function(_CampaignApplicationStatusHistory) _then) = __$CampaignApplicationStatusHistoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String applicationId, CampaignApplicationStatus? fromStatus, CampaignApplicationStatus toStatus, String? changedBy, String? reason, DateTime createdAt
});




}
/// @nodoc
class __$CampaignApplicationStatusHistoryCopyWithImpl<$Res>
    implements _$CampaignApplicationStatusHistoryCopyWith<$Res> {
  __$CampaignApplicationStatusHistoryCopyWithImpl(this._self, this._then);

  final _CampaignApplicationStatusHistory _self;
  final $Res Function(_CampaignApplicationStatusHistory) _then;

/// Create a copy of CampaignApplicationStatusHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? applicationId = null,Object? fromStatus = freezed,Object? toStatus = null,Object? changedBy = freezed,Object? reason = freezed,Object? createdAt = null,}) {
  return _then(_CampaignApplicationStatusHistory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as CampaignApplicationStatus?,toStatus: null == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as CampaignApplicationStatus,changedBy: freezed == changedBy ? _self.changedBy : changedBy // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CampaignApplication {

 String get id; String get campaignId; String get creatorId; CampaignApplicationStatus get status; String get pitch; double? get proposedRate; String get currency; DateTime? get reviewedAt; DateTime? get withdrawnAt; DateTime get createdAt; DateTime? get updatedAt; String? get campaignTitle; String? get brandName; String? get brandLogoUrl; String? get creatorDisplayName; String? get creatorAvatarPath; String? get creatorCity; int? get creatorFollowers; List<String> get creatorPrimaryCategories; List<CampaignApplicationStatusHistory> get statusHistory;
/// Create a copy of CampaignApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignApplicationCopyWith<CampaignApplication> get copyWith => _$CampaignApplicationCopyWithImpl<CampaignApplication>(this as CampaignApplication, _$identity);

  /// Serializes this CampaignApplication to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CampaignApplication;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignApplication&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.campaignId, _this.campaignId) || other.campaignId == _this.campaignId)&&(identical(other.creatorId, _this.creatorId) || other.creatorId == _this.creatorId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.pitch, _this.pitch) || other.pitch == _this.pitch)&&(identical(other.proposedRate, _this.proposedRate) || other.proposedRate == _this.proposedRate)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.reviewedAt, _this.reviewedAt) || other.reviewedAt == _this.reviewedAt)&&(identical(other.withdrawnAt, _this.withdrawnAt) || other.withdrawnAt == _this.withdrawnAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.campaignTitle, _this.campaignTitle) || other.campaignTitle == _this.campaignTitle)&&(identical(other.brandName, _this.brandName) || other.brandName == _this.brandName)&&(identical(other.brandLogoUrl, _this.brandLogoUrl) || other.brandLogoUrl == _this.brandLogoUrl)&&(identical(other.creatorDisplayName, _this.creatorDisplayName) || other.creatorDisplayName == _this.creatorDisplayName)&&(identical(other.creatorAvatarPath, _this.creatorAvatarPath) || other.creatorAvatarPath == _this.creatorAvatarPath)&&(identical(other.creatorCity, _this.creatorCity) || other.creatorCity == _this.creatorCity)&&(identical(other.creatorFollowers, _this.creatorFollowers) || other.creatorFollowers == _this.creatorFollowers)&&const DeepCollectionEquality().equals(other.creatorPrimaryCategories, _this.creatorPrimaryCategories)&&const DeepCollectionEquality().equals(other.statusHistory, _this.statusHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CampaignApplication;
  return Object.hashAll([runtimeType,_this.id,_this.campaignId,_this.creatorId,_this.status,_this.pitch,_this.proposedRate,_this.currency,_this.reviewedAt,_this.withdrawnAt,_this.createdAt,_this.updatedAt,_this.campaignTitle,_this.brandName,_this.brandLogoUrl,_this.creatorDisplayName,_this.creatorAvatarPath,_this.creatorCity,_this.creatorFollowers,const DeepCollectionEquality().hash(_this.creatorPrimaryCategories),const DeepCollectionEquality().hash(_this.statusHistory)]);
}

@override
String toString() {
  final _this = this as CampaignApplication;
  return 'CampaignApplication(id: ${_this.id}, campaignId: ${_this.campaignId}, creatorId: ${_this.creatorId}, status: ${_this.status}, pitch: ${_this.pitch}, proposedRate: ${_this.proposedRate}, currency: ${_this.currency}, reviewedAt: ${_this.reviewedAt}, withdrawnAt: ${_this.withdrawnAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, campaignTitle: ${_this.campaignTitle}, brandName: ${_this.brandName}, brandLogoUrl: ${_this.brandLogoUrl}, creatorDisplayName: ${_this.creatorDisplayName}, creatorAvatarPath: ${_this.creatorAvatarPath}, creatorCity: ${_this.creatorCity}, creatorFollowers: ${_this.creatorFollowers}, creatorPrimaryCategories: ${_this.creatorPrimaryCategories}, statusHistory: ${_this.statusHistory})';
}


}

/// @nodoc
abstract mixin class $CampaignApplicationCopyWith<$Res>  {
  factory $CampaignApplicationCopyWith(CampaignApplication value, $Res Function(CampaignApplication) _then) = _$CampaignApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, String creatorId, CampaignApplicationStatus status, String pitch, double? proposedRate, String currency, DateTime? reviewedAt, DateTime? withdrawnAt, DateTime createdAt, DateTime? updatedAt, String? campaignTitle, String? brandName, String? brandLogoUrl, String? creatorDisplayName, String? creatorAvatarPath, String? creatorCity, int? creatorFollowers, List<String> creatorPrimaryCategories, List<CampaignApplicationStatusHistory> statusHistory
});




}
/// @nodoc
class _$CampaignApplicationCopyWithImpl<$Res>
    implements $CampaignApplicationCopyWith<$Res> {
  _$CampaignApplicationCopyWithImpl(this._self, this._then);

  final CampaignApplication _self;
  final $Res Function(CampaignApplication) _then;

/// Create a copy of CampaignApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? creatorId = null,Object? status = null,Object? pitch = null,Object? proposedRate = freezed,Object? currency = null,Object? reviewedAt = freezed,Object? withdrawnAt = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? campaignTitle = freezed,Object? brandName = freezed,Object? brandLogoUrl = freezed,Object? creatorDisplayName = freezed,Object? creatorAvatarPath = freezed,Object? creatorCity = freezed,Object? creatorFollowers = freezed,Object? creatorPrimaryCategories = null,Object? statusHistory = null,}) {
  return _then(CampaignApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignApplicationStatus,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as String,proposedRate: freezed == proposedRate ? _self.proposedRate : proposedRate // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,withdrawnAt: freezed == withdrawnAt ? _self.withdrawnAt : withdrawnAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,creatorDisplayName: freezed == creatorDisplayName ? _self.creatorDisplayName : creatorDisplayName // ignore: cast_nullable_to_non_nullable
as String?,creatorAvatarPath: freezed == creatorAvatarPath ? _self.creatorAvatarPath : creatorAvatarPath // ignore: cast_nullable_to_non_nullable
as String?,creatorCity: freezed == creatorCity ? _self.creatorCity : creatorCity // ignore: cast_nullable_to_non_nullable
as String?,creatorFollowers: freezed == creatorFollowers ? _self.creatorFollowers : creatorFollowers // ignore: cast_nullable_to_non_nullable
as int?,creatorPrimaryCategories: null == creatorPrimaryCategories ? _self.creatorPrimaryCategories : creatorPrimaryCategories // ignore: cast_nullable_to_non_nullable
as List<String>,statusHistory: null == statusHistory ? _self.statusHistory : statusHistory // ignore: cast_nullable_to_non_nullable
as List<CampaignApplicationStatusHistory>,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignApplication].
extension CampaignApplicationPatterns on CampaignApplication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignApplication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignApplication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignApplication value)  $default,){
final _that = this;
switch (_that) {
case _CampaignApplication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignApplication value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignApplication() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  String creatorId,  CampaignApplicationStatus status,  String pitch,  double? proposedRate,  String currency,  DateTime? reviewedAt,  DateTime? withdrawnAt,  DateTime createdAt,  DateTime? updatedAt,  String? campaignTitle,  String? brandName,  String? brandLogoUrl,  String? creatorDisplayName,  String? creatorAvatarPath,  String? creatorCity,  int? creatorFollowers,  List<String> creatorPrimaryCategories,  List<CampaignApplicationStatusHistory> statusHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignApplication() when $default != null:
return $default(_that.id,_that.campaignId,_that.creatorId,_that.status,_that.pitch,_that.proposedRate,_that.currency,_that.reviewedAt,_that.withdrawnAt,_that.createdAt,_that.updatedAt,_that.campaignTitle,_that.brandName,_that.brandLogoUrl,_that.creatorDisplayName,_that.creatorAvatarPath,_that.creatorCity,_that.creatorFollowers,_that.creatorPrimaryCategories,_that.statusHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  String creatorId,  CampaignApplicationStatus status,  String pitch,  double? proposedRate,  String currency,  DateTime? reviewedAt,  DateTime? withdrawnAt,  DateTime createdAt,  DateTime? updatedAt,  String? campaignTitle,  String? brandName,  String? brandLogoUrl,  String? creatorDisplayName,  String? creatorAvatarPath,  String? creatorCity,  int? creatorFollowers,  List<String> creatorPrimaryCategories,  List<CampaignApplicationStatusHistory> statusHistory)  $default,) {final _that = this;
switch (_that) {
case _CampaignApplication():
return $default(_that.id,_that.campaignId,_that.creatorId,_that.status,_that.pitch,_that.proposedRate,_that.currency,_that.reviewedAt,_that.withdrawnAt,_that.createdAt,_that.updatedAt,_that.campaignTitle,_that.brandName,_that.brandLogoUrl,_that.creatorDisplayName,_that.creatorAvatarPath,_that.creatorCity,_that.creatorFollowers,_that.creatorPrimaryCategories,_that.statusHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  String creatorId,  CampaignApplicationStatus status,  String pitch,  double? proposedRate,  String currency,  DateTime? reviewedAt,  DateTime? withdrawnAt,  DateTime createdAt,  DateTime? updatedAt,  String? campaignTitle,  String? brandName,  String? brandLogoUrl,  String? creatorDisplayName,  String? creatorAvatarPath,  String? creatorCity,  int? creatorFollowers,  List<String> creatorPrimaryCategories,  List<CampaignApplicationStatusHistory> statusHistory)?  $default,) {final _that = this;
switch (_that) {
case _CampaignApplication() when $default != null:
return $default(_that.id,_that.campaignId,_that.creatorId,_that.status,_that.pitch,_that.proposedRate,_that.currency,_that.reviewedAt,_that.withdrawnAt,_that.createdAt,_that.updatedAt,_that.campaignTitle,_that.brandName,_that.brandLogoUrl,_that.creatorDisplayName,_that.creatorAvatarPath,_that.creatorCity,_that.creatorFollowers,_that.creatorPrimaryCategories,_that.statusHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignApplication implements CampaignApplication {
  const _CampaignApplication({required this.id, required this.campaignId, required this.creatorId, this.status = CampaignApplicationStatus.submitted, required this.pitch, this.proposedRate, this.currency = 'INR', this.reviewedAt, this.withdrawnAt, required this.createdAt, this.updatedAt, this.campaignTitle, this.brandName, this.brandLogoUrl, this.creatorDisplayName, this.creatorAvatarPath, this.creatorCity, this.creatorFollowers,  List<String> creatorPrimaryCategories = const [],  List<CampaignApplicationStatusHistory> statusHistory = const []}): _creatorPrimaryCategories = creatorPrimaryCategories,_statusHistory = statusHistory;
  factory _CampaignApplication.fromJson(Map<String, dynamic> json) => _$CampaignApplicationFromJson(json);

@override final  String id;
@override final  String campaignId;
@override final  String creatorId;
@override@JsonKey() final  CampaignApplicationStatus status;
@override final  String pitch;
@override final  double? proposedRate;
@override@JsonKey() final  String currency;
@override final  DateTime? reviewedAt;
@override final  DateTime? withdrawnAt;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override final  String? campaignTitle;
@override final  String? brandName;
@override final  String? brandLogoUrl;
@override final  String? creatorDisplayName;
@override final  String? creatorAvatarPath;
@override final  String? creatorCity;
@override final  int? creatorFollowers;
 final  List<String> _creatorPrimaryCategories;
@override@JsonKey() List<String> get creatorPrimaryCategories {
  if (_creatorPrimaryCategories is EqualUnmodifiableListView) return _creatorPrimaryCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_creatorPrimaryCategories);
}

 final  List<CampaignApplicationStatusHistory> _statusHistory;
@override@JsonKey() List<CampaignApplicationStatusHistory> get statusHistory {
  if (_statusHistory is EqualUnmodifiableListView) return _statusHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statusHistory);
}


/// Create a copy of CampaignApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignApplicationCopyWith<_CampaignApplication> get copyWith => __$CampaignApplicationCopyWithImpl<_CampaignApplication>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignApplicationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.pitch, pitch) || other.pitch == pitch)&&(identical(other.proposedRate, proposedRate) || other.proposedRate == proposedRate)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.withdrawnAt, withdrawnAt) || other.withdrawnAt == withdrawnAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignTitle, campaignTitle) || other.campaignTitle == campaignTitle)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.creatorDisplayName, creatorDisplayName) || other.creatorDisplayName == creatorDisplayName)&&(identical(other.creatorAvatarPath, creatorAvatarPath) || other.creatorAvatarPath == creatorAvatarPath)&&(identical(other.creatorCity, creatorCity) || other.creatorCity == creatorCity)&&(identical(other.creatorFollowers, creatorFollowers) || other.creatorFollowers == creatorFollowers)&&const DeepCollectionEquality().equals(other.creatorPrimaryCategories, _creatorPrimaryCategories)&&const DeepCollectionEquality().equals(other.statusHistory, _statusHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,campaignId,creatorId,status,pitch,proposedRate,currency,reviewedAt,withdrawnAt,createdAt,updatedAt,campaignTitle,brandName,brandLogoUrl,creatorDisplayName,creatorAvatarPath,creatorCity,creatorFollowers,const DeepCollectionEquality().hash(_creatorPrimaryCategories),const DeepCollectionEquality().hash(_statusHistory)]);
}

@override
String toString() {
    return 'CampaignApplication(id: $id, campaignId: $campaignId, creatorId: $creatorId, status: $status, pitch: $pitch, proposedRate: $proposedRate, currency: $currency, reviewedAt: $reviewedAt, withdrawnAt: $withdrawnAt, createdAt: $createdAt, updatedAt: $updatedAt, campaignTitle: $campaignTitle, brandName: $brandName, brandLogoUrl: $brandLogoUrl, creatorDisplayName: $creatorDisplayName, creatorAvatarPath: $creatorAvatarPath, creatorCity: $creatorCity, creatorFollowers: $creatorFollowers, creatorPrimaryCategories: $creatorPrimaryCategories, statusHistory: $statusHistory)';
}


}

/// @nodoc
abstract mixin class _$CampaignApplicationCopyWith<$Res> implements $CampaignApplicationCopyWith<$Res> {
  factory _$CampaignApplicationCopyWith(_CampaignApplication value, $Res Function(_CampaignApplication) _then) = __$CampaignApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, String creatorId, CampaignApplicationStatus status, String pitch, double? proposedRate, String currency, DateTime? reviewedAt, DateTime? withdrawnAt, DateTime createdAt, DateTime? updatedAt, String? campaignTitle, String? brandName, String? brandLogoUrl, String? creatorDisplayName, String? creatorAvatarPath, String? creatorCity, int? creatorFollowers, List<String> creatorPrimaryCategories, List<CampaignApplicationStatusHistory> statusHistory
});




}
/// @nodoc
class __$CampaignApplicationCopyWithImpl<$Res>
    implements _$CampaignApplicationCopyWith<$Res> {
  __$CampaignApplicationCopyWithImpl(this._self, this._then);

  final _CampaignApplication _self;
  final $Res Function(_CampaignApplication) _then;

/// Create a copy of CampaignApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? creatorId = null,Object? status = null,Object? pitch = null,Object? proposedRate = freezed,Object? currency = null,Object? reviewedAt = freezed,Object? withdrawnAt = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? campaignTitle = freezed,Object? brandName = freezed,Object? brandLogoUrl = freezed,Object? creatorDisplayName = freezed,Object? creatorAvatarPath = freezed,Object? creatorCity = freezed,Object? creatorFollowers = freezed,Object? creatorPrimaryCategories = null,Object? statusHistory = null,}) {
  return _then(_CampaignApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignApplicationStatus,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as String,proposedRate: freezed == proposedRate ? _self.proposedRate : proposedRate // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,withdrawnAt: freezed == withdrawnAt ? _self.withdrawnAt : withdrawnAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,creatorDisplayName: freezed == creatorDisplayName ? _self.creatorDisplayName : creatorDisplayName // ignore: cast_nullable_to_non_nullable
as String?,creatorAvatarPath: freezed == creatorAvatarPath ? _self.creatorAvatarPath : creatorAvatarPath // ignore: cast_nullable_to_non_nullable
as String?,creatorCity: freezed == creatorCity ? _self.creatorCity : creatorCity // ignore: cast_nullable_to_non_nullable
as String?,creatorFollowers: freezed == creatorFollowers ? _self.creatorFollowers : creatorFollowers // ignore: cast_nullable_to_non_nullable
as int?,creatorPrimaryCategories: null == creatorPrimaryCategories ? _self._creatorPrimaryCategories : creatorPrimaryCategories // ignore: cast_nullable_to_non_nullable
as List<String>,statusHistory: null == statusHistory ? _self._statusHistory : statusHistory // ignore: cast_nullable_to_non_nullable
as List<CampaignApplicationStatusHistory>,
  ));
}


}

// dart format on
