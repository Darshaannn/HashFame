// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampaignDeliverable {

 String get id; String get campaignId; CampaignDeliverableType get deliverableType; String get platform; int get quantity; String? get description;
/// Create a copy of CampaignDeliverable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignDeliverableCopyWith<CampaignDeliverable> get copyWith => _$CampaignDeliverableCopyWithImpl<CampaignDeliverable>(this as CampaignDeliverable, _$identity);

  /// Serializes this CampaignDeliverable to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CampaignDeliverable;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignDeliverable&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.campaignId, _this.campaignId) || other.campaignId == _this.campaignId)&&(identical(other.deliverableType, _this.deliverableType) || other.deliverableType == _this.deliverableType)&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CampaignDeliverable;
  return Object.hash(runtimeType,_this.id,_this.campaignId,_this.deliverableType,_this.platform,_this.quantity,_this.description);
}

@override
String toString() {
  final _this = this as CampaignDeliverable;
  return 'CampaignDeliverable(id: ${_this.id}, campaignId: ${_this.campaignId}, deliverableType: ${_this.deliverableType}, platform: ${_this.platform}, quantity: ${_this.quantity}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $CampaignDeliverableCopyWith<$Res>  {
  factory $CampaignDeliverableCopyWith(CampaignDeliverable value, $Res Function(CampaignDeliverable) _then) = _$CampaignDeliverableCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, CampaignDeliverableType deliverableType, String platform, int quantity, String? description
});




}
/// @nodoc
class _$CampaignDeliverableCopyWithImpl<$Res>
    implements $CampaignDeliverableCopyWith<$Res> {
  _$CampaignDeliverableCopyWithImpl(this._self, this._then);

  final CampaignDeliverable _self;
  final $Res Function(CampaignDeliverable) _then;

/// Create a copy of CampaignDeliverable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? deliverableType = null,Object? platform = null,Object? quantity = null,Object? description = freezed,}) {
  return _then(CampaignDeliverable(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,deliverableType: null == deliverableType ? _self.deliverableType : deliverableType // ignore: cast_nullable_to_non_nullable
as CampaignDeliverableType,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignDeliverable].
extension CampaignDeliverablePatterns on CampaignDeliverable {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignDeliverable value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignDeliverable() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignDeliverable value)  $default,){
final _that = this;
switch (_that) {
case _CampaignDeliverable():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignDeliverable value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignDeliverable() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  CampaignDeliverableType deliverableType,  String platform,  int quantity,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignDeliverable() when $default != null:
return $default(_that.id,_that.campaignId,_that.deliverableType,_that.platform,_that.quantity,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  CampaignDeliverableType deliverableType,  String platform,  int quantity,  String? description)  $default,) {final _that = this;
switch (_that) {
case _CampaignDeliverable():
return $default(_that.id,_that.campaignId,_that.deliverableType,_that.platform,_that.quantity,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  CampaignDeliverableType deliverableType,  String platform,  int quantity,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _CampaignDeliverable() when $default != null:
return $default(_that.id,_that.campaignId,_that.deliverableType,_that.platform,_that.quantity,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignDeliverable implements CampaignDeliverable {
  const _CampaignDeliverable({required this.id, required this.campaignId, required this.deliverableType, required this.platform, this.quantity = 1, this.description});
  factory _CampaignDeliverable.fromJson(Map<String, dynamic> json) => _$CampaignDeliverableFromJson(json);

@override final  String id;
@override final  String campaignId;
@override final  CampaignDeliverableType deliverableType;
@override final  String platform;
@override@JsonKey() final  int quantity;
@override final  String? description;

/// Create a copy of CampaignDeliverable
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignDeliverableCopyWith<_CampaignDeliverable> get copyWith => __$CampaignDeliverableCopyWithImpl<_CampaignDeliverable>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignDeliverableToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignDeliverable&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.deliverableType, deliverableType) || other.deliverableType == deliverableType)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,campaignId,deliverableType,platform,quantity,description);
}

@override
String toString() {
    return 'CampaignDeliverable(id: $id, campaignId: $campaignId, deliverableType: $deliverableType, platform: $platform, quantity: $quantity, description: $description)';
}


}

/// @nodoc
abstract mixin class _$CampaignDeliverableCopyWith<$Res> implements $CampaignDeliverableCopyWith<$Res> {
  factory _$CampaignDeliverableCopyWith(_CampaignDeliverable value, $Res Function(_CampaignDeliverable) _then) = __$CampaignDeliverableCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, CampaignDeliverableType deliverableType, String platform, int quantity, String? description
});




}
/// @nodoc
class __$CampaignDeliverableCopyWithImpl<$Res>
    implements _$CampaignDeliverableCopyWith<$Res> {
  __$CampaignDeliverableCopyWithImpl(this._self, this._then);

  final _CampaignDeliverable _self;
  final $Res Function(_CampaignDeliverable) _then;

/// Create a copy of CampaignDeliverable
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? deliverableType = null,Object? platform = null,Object? quantity = null,Object? description = freezed,}) {
  return _then(_CampaignDeliverable(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,deliverableType: null == deliverableType ? _self.deliverableType : deliverableType // ignore: cast_nullable_to_non_nullable
as CampaignDeliverableType,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CampaignUsageRights {

 bool get organicRepostingAllowed; bool get paidUsageRequired; bool get whitelistingRequired; int? get usageDurationMonths; String get usageTerritory; bool get exclusivityRequired; int? get exclusivityDurationDays; bool get contentApprovalRequired; bool get disclosureRequired;
/// Create a copy of CampaignUsageRights
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignUsageRightsCopyWith<CampaignUsageRights> get copyWith => _$CampaignUsageRightsCopyWithImpl<CampaignUsageRights>(this as CampaignUsageRights, _$identity);

  /// Serializes this CampaignUsageRights to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CampaignUsageRights;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignUsageRights&&(identical(other.organicRepostingAllowed, _this.organicRepostingAllowed) || other.organicRepostingAllowed == _this.organicRepostingAllowed)&&(identical(other.paidUsageRequired, _this.paidUsageRequired) || other.paidUsageRequired == _this.paidUsageRequired)&&(identical(other.whitelistingRequired, _this.whitelistingRequired) || other.whitelistingRequired == _this.whitelistingRequired)&&(identical(other.usageDurationMonths, _this.usageDurationMonths) || other.usageDurationMonths == _this.usageDurationMonths)&&(identical(other.usageTerritory, _this.usageTerritory) || other.usageTerritory == _this.usageTerritory)&&(identical(other.exclusivityRequired, _this.exclusivityRequired) || other.exclusivityRequired == _this.exclusivityRequired)&&(identical(other.exclusivityDurationDays, _this.exclusivityDurationDays) || other.exclusivityDurationDays == _this.exclusivityDurationDays)&&(identical(other.contentApprovalRequired, _this.contentApprovalRequired) || other.contentApprovalRequired == _this.contentApprovalRequired)&&(identical(other.disclosureRequired, _this.disclosureRequired) || other.disclosureRequired == _this.disclosureRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CampaignUsageRights;
  return Object.hash(runtimeType,_this.organicRepostingAllowed,_this.paidUsageRequired,_this.whitelistingRequired,_this.usageDurationMonths,_this.usageTerritory,_this.exclusivityRequired,_this.exclusivityDurationDays,_this.contentApprovalRequired,_this.disclosureRequired);
}

@override
String toString() {
  final _this = this as CampaignUsageRights;
  return 'CampaignUsageRights(organicRepostingAllowed: ${_this.organicRepostingAllowed}, paidUsageRequired: ${_this.paidUsageRequired}, whitelistingRequired: ${_this.whitelistingRequired}, usageDurationMonths: ${_this.usageDurationMonths}, usageTerritory: ${_this.usageTerritory}, exclusivityRequired: ${_this.exclusivityRequired}, exclusivityDurationDays: ${_this.exclusivityDurationDays}, contentApprovalRequired: ${_this.contentApprovalRequired}, disclosureRequired: ${_this.disclosureRequired})';
}


}

/// @nodoc
abstract mixin class $CampaignUsageRightsCopyWith<$Res>  {
  factory $CampaignUsageRightsCopyWith(CampaignUsageRights value, $Res Function(CampaignUsageRights) _then) = _$CampaignUsageRightsCopyWithImpl;
@useResult
$Res call({
 bool organicRepostingAllowed, bool paidUsageRequired, bool whitelistingRequired, int? usageDurationMonths, String usageTerritory, bool exclusivityRequired, int? exclusivityDurationDays, bool contentApprovalRequired, bool disclosureRequired
});




}
/// @nodoc
class _$CampaignUsageRightsCopyWithImpl<$Res>
    implements $CampaignUsageRightsCopyWith<$Res> {
  _$CampaignUsageRightsCopyWithImpl(this._self, this._then);

  final CampaignUsageRights _self;
  final $Res Function(CampaignUsageRights) _then;

/// Create a copy of CampaignUsageRights
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organicRepostingAllowed = null,Object? paidUsageRequired = null,Object? whitelistingRequired = null,Object? usageDurationMonths = freezed,Object? usageTerritory = null,Object? exclusivityRequired = null,Object? exclusivityDurationDays = freezed,Object? contentApprovalRequired = null,Object? disclosureRequired = null,}) {
  return _then(CampaignUsageRights(
organicRepostingAllowed: null == organicRepostingAllowed ? _self.organicRepostingAllowed : organicRepostingAllowed // ignore: cast_nullable_to_non_nullable
as bool,paidUsageRequired: null == paidUsageRequired ? _self.paidUsageRequired : paidUsageRequired // ignore: cast_nullable_to_non_nullable
as bool,whitelistingRequired: null == whitelistingRequired ? _self.whitelistingRequired : whitelistingRequired // ignore: cast_nullable_to_non_nullable
as bool,usageDurationMonths: freezed == usageDurationMonths ? _self.usageDurationMonths : usageDurationMonths // ignore: cast_nullable_to_non_nullable
as int?,usageTerritory: null == usageTerritory ? _self.usageTerritory : usageTerritory // ignore: cast_nullable_to_non_nullable
as String,exclusivityRequired: null == exclusivityRequired ? _self.exclusivityRequired : exclusivityRequired // ignore: cast_nullable_to_non_nullable
as bool,exclusivityDurationDays: freezed == exclusivityDurationDays ? _self.exclusivityDurationDays : exclusivityDurationDays // ignore: cast_nullable_to_non_nullable
as int?,contentApprovalRequired: null == contentApprovalRequired ? _self.contentApprovalRequired : contentApprovalRequired // ignore: cast_nullable_to_non_nullable
as bool,disclosureRequired: null == disclosureRequired ? _self.disclosureRequired : disclosureRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignUsageRights].
extension CampaignUsageRightsPatterns on CampaignUsageRights {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignUsageRights value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignUsageRights() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignUsageRights value)  $default,){
final _that = this;
switch (_that) {
case _CampaignUsageRights():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignUsageRights value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignUsageRights() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool organicRepostingAllowed,  bool paidUsageRequired,  bool whitelistingRequired,  int? usageDurationMonths,  String usageTerritory,  bool exclusivityRequired,  int? exclusivityDurationDays,  bool contentApprovalRequired,  bool disclosureRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignUsageRights() when $default != null:
return $default(_that.organicRepostingAllowed,_that.paidUsageRequired,_that.whitelistingRequired,_that.usageDurationMonths,_that.usageTerritory,_that.exclusivityRequired,_that.exclusivityDurationDays,_that.contentApprovalRequired,_that.disclosureRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool organicRepostingAllowed,  bool paidUsageRequired,  bool whitelistingRequired,  int? usageDurationMonths,  String usageTerritory,  bool exclusivityRequired,  int? exclusivityDurationDays,  bool contentApprovalRequired,  bool disclosureRequired)  $default,) {final _that = this;
switch (_that) {
case _CampaignUsageRights():
return $default(_that.organicRepostingAllowed,_that.paidUsageRequired,_that.whitelistingRequired,_that.usageDurationMonths,_that.usageTerritory,_that.exclusivityRequired,_that.exclusivityDurationDays,_that.contentApprovalRequired,_that.disclosureRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool organicRepostingAllowed,  bool paidUsageRequired,  bool whitelistingRequired,  int? usageDurationMonths,  String usageTerritory,  bool exclusivityRequired,  int? exclusivityDurationDays,  bool contentApprovalRequired,  bool disclosureRequired)?  $default,) {final _that = this;
switch (_that) {
case _CampaignUsageRights() when $default != null:
return $default(_that.organicRepostingAllowed,_that.paidUsageRequired,_that.whitelistingRequired,_that.usageDurationMonths,_that.usageTerritory,_that.exclusivityRequired,_that.exclusivityDurationDays,_that.contentApprovalRequired,_that.disclosureRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignUsageRights implements CampaignUsageRights {
  const _CampaignUsageRights({this.organicRepostingAllowed = true, this.paidUsageRequired = false, this.whitelistingRequired = false, this.usageDurationMonths, this.usageTerritory = 'India', this.exclusivityRequired = false, this.exclusivityDurationDays, this.contentApprovalRequired = true, this.disclosureRequired = true});
  factory _CampaignUsageRights.fromJson(Map<String, dynamic> json) => _$CampaignUsageRightsFromJson(json);

@override@JsonKey() final  bool organicRepostingAllowed;
@override@JsonKey() final  bool paidUsageRequired;
@override@JsonKey() final  bool whitelistingRequired;
@override final  int? usageDurationMonths;
@override@JsonKey() final  String usageTerritory;
@override@JsonKey() final  bool exclusivityRequired;
@override final  int? exclusivityDurationDays;
@override@JsonKey() final  bool contentApprovalRequired;
@override@JsonKey() final  bool disclosureRequired;

/// Create a copy of CampaignUsageRights
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignUsageRightsCopyWith<_CampaignUsageRights> get copyWith => __$CampaignUsageRightsCopyWithImpl<_CampaignUsageRights>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignUsageRightsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignUsageRights&&(identical(other.organicRepostingAllowed, organicRepostingAllowed) || other.organicRepostingAllowed == organicRepostingAllowed)&&(identical(other.paidUsageRequired, paidUsageRequired) || other.paidUsageRequired == paidUsageRequired)&&(identical(other.whitelistingRequired, whitelistingRequired) || other.whitelistingRequired == whitelistingRequired)&&(identical(other.usageDurationMonths, usageDurationMonths) || other.usageDurationMonths == usageDurationMonths)&&(identical(other.usageTerritory, usageTerritory) || other.usageTerritory == usageTerritory)&&(identical(other.exclusivityRequired, exclusivityRequired) || other.exclusivityRequired == exclusivityRequired)&&(identical(other.exclusivityDurationDays, exclusivityDurationDays) || other.exclusivityDurationDays == exclusivityDurationDays)&&(identical(other.contentApprovalRequired, contentApprovalRequired) || other.contentApprovalRequired == contentApprovalRequired)&&(identical(other.disclosureRequired, disclosureRequired) || other.disclosureRequired == disclosureRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,organicRepostingAllowed,paidUsageRequired,whitelistingRequired,usageDurationMonths,usageTerritory,exclusivityRequired,exclusivityDurationDays,contentApprovalRequired,disclosureRequired);
}

@override
String toString() {
    return 'CampaignUsageRights(organicRepostingAllowed: $organicRepostingAllowed, paidUsageRequired: $paidUsageRequired, whitelistingRequired: $whitelistingRequired, usageDurationMonths: $usageDurationMonths, usageTerritory: $usageTerritory, exclusivityRequired: $exclusivityRequired, exclusivityDurationDays: $exclusivityDurationDays, contentApprovalRequired: $contentApprovalRequired, disclosureRequired: $disclosureRequired)';
}


}

/// @nodoc
abstract mixin class _$CampaignUsageRightsCopyWith<$Res> implements $CampaignUsageRightsCopyWith<$Res> {
  factory _$CampaignUsageRightsCopyWith(_CampaignUsageRights value, $Res Function(_CampaignUsageRights) _then) = __$CampaignUsageRightsCopyWithImpl;
@override @useResult
$Res call({
 bool organicRepostingAllowed, bool paidUsageRequired, bool whitelistingRequired, int? usageDurationMonths, String usageTerritory, bool exclusivityRequired, int? exclusivityDurationDays, bool contentApprovalRequired, bool disclosureRequired
});




}
/// @nodoc
class __$CampaignUsageRightsCopyWithImpl<$Res>
    implements _$CampaignUsageRightsCopyWith<$Res> {
  __$CampaignUsageRightsCopyWithImpl(this._self, this._then);

  final _CampaignUsageRights _self;
  final $Res Function(_CampaignUsageRights) _then;

/// Create a copy of CampaignUsageRights
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organicRepostingAllowed = null,Object? paidUsageRequired = null,Object? whitelistingRequired = null,Object? usageDurationMonths = freezed,Object? usageTerritory = null,Object? exclusivityRequired = null,Object? exclusivityDurationDays = freezed,Object? contentApprovalRequired = null,Object? disclosureRequired = null,}) {
  return _then(_CampaignUsageRights(
organicRepostingAllowed: null == organicRepostingAllowed ? _self.organicRepostingAllowed : organicRepostingAllowed // ignore: cast_nullable_to_non_nullable
as bool,paidUsageRequired: null == paidUsageRequired ? _self.paidUsageRequired : paidUsageRequired // ignore: cast_nullable_to_non_nullable
as bool,whitelistingRequired: null == whitelistingRequired ? _self.whitelistingRequired : whitelistingRequired // ignore: cast_nullable_to_non_nullable
as bool,usageDurationMonths: freezed == usageDurationMonths ? _self.usageDurationMonths : usageDurationMonths // ignore: cast_nullable_to_non_nullable
as int?,usageTerritory: null == usageTerritory ? _self.usageTerritory : usageTerritory // ignore: cast_nullable_to_non_nullable
as String,exclusivityRequired: null == exclusivityRequired ? _self.exclusivityRequired : exclusivityRequired // ignore: cast_nullable_to_non_nullable
as bool,exclusivityDurationDays: freezed == exclusivityDurationDays ? _self.exclusivityDurationDays : exclusivityDurationDays // ignore: cast_nullable_to_non_nullable
as int?,contentApprovalRequired: null == contentApprovalRequired ? _self.contentApprovalRequired : contentApprovalRequired // ignore: cast_nullable_to_non_nullable
as bool,disclosureRequired: null == disclosureRequired ? _self.disclosureRequired : disclosureRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Campaign {

 String get id; String get organizationId; String? get createdBy; String get title; String? get objective; String get description; CampaignStatus get status; CampaignCompensationType get compensationType; String get currency; double? get budgetMin; double? get budgetMax; double? get barterValue; String? get barterDescription; int get creatorSlots; String? get targetCity; String? get targetState; String get targetCountry; int? get minFollowers; int? get maxFollowers; List<String> get categoryIds; List<String> get categoryNames; List<String> get languageCodes; List<String> get languageNames; List<CampaignDeliverable> get deliverables; CampaignUsageRights get usageRights; DateTime? get applicationDeadline; DateTime? get contentDeadline; DateTime? get campaignStartDate; DateTime? get campaignEndDate; String? get additionalRequirements; String? get rejectionReason; DateTime? get publishedAt; DateTime? get closedAt; DateTime? get createdAt; DateTime? get updatedAt; int get applicantCount; int get selectedCount; String? get brandName; String? get brandLogoUrl;
/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignCopyWith<Campaign> get copyWith => _$CampaignCopyWithImpl<Campaign>(this as Campaign, _$identity);

  /// Serializes this Campaign to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Campaign;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Campaign&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.objective, _this.objective) || other.objective == _this.objective)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.compensationType, _this.compensationType) || other.compensationType == _this.compensationType)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.budgetMin, _this.budgetMin) || other.budgetMin == _this.budgetMin)&&(identical(other.budgetMax, _this.budgetMax) || other.budgetMax == _this.budgetMax)&&(identical(other.barterValue, _this.barterValue) || other.barterValue == _this.barterValue)&&(identical(other.barterDescription, _this.barterDescription) || other.barterDescription == _this.barterDescription)&&(identical(other.creatorSlots, _this.creatorSlots) || other.creatorSlots == _this.creatorSlots)&&(identical(other.targetCity, _this.targetCity) || other.targetCity == _this.targetCity)&&(identical(other.targetState, _this.targetState) || other.targetState == _this.targetState)&&(identical(other.targetCountry, _this.targetCountry) || other.targetCountry == _this.targetCountry)&&(identical(other.minFollowers, _this.minFollowers) || other.minFollowers == _this.minFollowers)&&(identical(other.maxFollowers, _this.maxFollowers) || other.maxFollowers == _this.maxFollowers)&&const DeepCollectionEquality().equals(other.categoryIds, _this.categoryIds)&&const DeepCollectionEquality().equals(other.categoryNames, _this.categoryNames)&&const DeepCollectionEquality().equals(other.languageCodes, _this.languageCodes)&&const DeepCollectionEquality().equals(other.languageNames, _this.languageNames)&&const DeepCollectionEquality().equals(other.deliverables, _this.deliverables)&&(identical(other.usageRights, _this.usageRights) || other.usageRights == _this.usageRights)&&(identical(other.applicationDeadline, _this.applicationDeadline) || other.applicationDeadline == _this.applicationDeadline)&&(identical(other.contentDeadline, _this.contentDeadline) || other.contentDeadline == _this.contentDeadline)&&(identical(other.campaignStartDate, _this.campaignStartDate) || other.campaignStartDate == _this.campaignStartDate)&&(identical(other.campaignEndDate, _this.campaignEndDate) || other.campaignEndDate == _this.campaignEndDate)&&(identical(other.additionalRequirements, _this.additionalRequirements) || other.additionalRequirements == _this.additionalRequirements)&&(identical(other.rejectionReason, _this.rejectionReason) || other.rejectionReason == _this.rejectionReason)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.closedAt, _this.closedAt) || other.closedAt == _this.closedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.applicantCount, _this.applicantCount) || other.applicantCount == _this.applicantCount)&&(identical(other.selectedCount, _this.selectedCount) || other.selectedCount == _this.selectedCount)&&(identical(other.brandName, _this.brandName) || other.brandName == _this.brandName)&&(identical(other.brandLogoUrl, _this.brandLogoUrl) || other.brandLogoUrl == _this.brandLogoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Campaign;
  return Object.hashAll([runtimeType,_this.id,_this.organizationId,_this.createdBy,_this.title,_this.objective,_this.description,_this.status,_this.compensationType,_this.currency,_this.budgetMin,_this.budgetMax,_this.barterValue,_this.barterDescription,_this.creatorSlots,_this.targetCity,_this.targetState,_this.targetCountry,_this.minFollowers,_this.maxFollowers,const DeepCollectionEquality().hash(_this.categoryIds),const DeepCollectionEquality().hash(_this.categoryNames),const DeepCollectionEquality().hash(_this.languageCodes),const DeepCollectionEquality().hash(_this.languageNames),const DeepCollectionEquality().hash(_this.deliverables),_this.usageRights,_this.applicationDeadline,_this.contentDeadline,_this.campaignStartDate,_this.campaignEndDate,_this.additionalRequirements,_this.rejectionReason,_this.publishedAt,_this.closedAt,_this.createdAt,_this.updatedAt,_this.applicantCount,_this.selectedCount,_this.brandName,_this.brandLogoUrl]);
}

@override
String toString() {
  final _this = this as Campaign;
  return 'Campaign(id: ${_this.id}, organizationId: ${_this.organizationId}, createdBy: ${_this.createdBy}, title: ${_this.title}, objective: ${_this.objective}, description: ${_this.description}, status: ${_this.status}, compensationType: ${_this.compensationType}, currency: ${_this.currency}, budgetMin: ${_this.budgetMin}, budgetMax: ${_this.budgetMax}, barterValue: ${_this.barterValue}, barterDescription: ${_this.barterDescription}, creatorSlots: ${_this.creatorSlots}, targetCity: ${_this.targetCity}, targetState: ${_this.targetState}, targetCountry: ${_this.targetCountry}, minFollowers: ${_this.minFollowers}, maxFollowers: ${_this.maxFollowers}, categoryIds: ${_this.categoryIds}, categoryNames: ${_this.categoryNames}, languageCodes: ${_this.languageCodes}, languageNames: ${_this.languageNames}, deliverables: ${_this.deliverables}, usageRights: ${_this.usageRights}, applicationDeadline: ${_this.applicationDeadline}, contentDeadline: ${_this.contentDeadline}, campaignStartDate: ${_this.campaignStartDate}, campaignEndDate: ${_this.campaignEndDate}, additionalRequirements: ${_this.additionalRequirements}, rejectionReason: ${_this.rejectionReason}, publishedAt: ${_this.publishedAt}, closedAt: ${_this.closedAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, applicantCount: ${_this.applicantCount}, selectedCount: ${_this.selectedCount}, brandName: ${_this.brandName}, brandLogoUrl: ${_this.brandLogoUrl})';
}


}

/// @nodoc
abstract mixin class $CampaignCopyWith<$Res>  {
  factory $CampaignCopyWith(Campaign value, $Res Function(Campaign) _then) = _$CampaignCopyWithImpl;
@useResult
$Res call({
 String id, String organizationId, String? createdBy, String title, String? objective, String description, CampaignStatus status, CampaignCompensationType compensationType, String currency, double? budgetMin, double? budgetMax, double? barterValue, String? barterDescription, int creatorSlots, String? targetCity, String? targetState, String targetCountry, int? minFollowers, int? maxFollowers, List<String> categoryIds, List<String> categoryNames, List<String> languageCodes, List<String> languageNames, List<CampaignDeliverable> deliverables, CampaignUsageRights usageRights, DateTime? applicationDeadline, DateTime? contentDeadline, DateTime? campaignStartDate, DateTime? campaignEndDate, String? additionalRequirements, String? rejectionReason, DateTime? publishedAt, DateTime? closedAt, DateTime? createdAt, DateTime? updatedAt, int applicantCount, int selectedCount, String? brandName, String? brandLogoUrl
});


$CampaignUsageRightsCopyWith<$Res> get usageRights;

}
/// @nodoc
class _$CampaignCopyWithImpl<$Res>
    implements $CampaignCopyWith<$Res> {
  _$CampaignCopyWithImpl(this._self, this._then);

  final Campaign _self;
  final $Res Function(Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organizationId = null,Object? createdBy = freezed,Object? title = null,Object? objective = freezed,Object? description = null,Object? status = null,Object? compensationType = null,Object? currency = null,Object? budgetMin = freezed,Object? budgetMax = freezed,Object? barterValue = freezed,Object? barterDescription = freezed,Object? creatorSlots = null,Object? targetCity = freezed,Object? targetState = freezed,Object? targetCountry = null,Object? minFollowers = freezed,Object? maxFollowers = freezed,Object? categoryIds = null,Object? categoryNames = null,Object? languageCodes = null,Object? languageNames = null,Object? deliverables = null,Object? usageRights = null,Object? applicationDeadline = freezed,Object? contentDeadline = freezed,Object? campaignStartDate = freezed,Object? campaignEndDate = freezed,Object? additionalRequirements = freezed,Object? rejectionReason = freezed,Object? publishedAt = freezed,Object? closedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? applicantCount = null,Object? selectedCount = null,Object? brandName = freezed,Object? brandLogoUrl = freezed,}) {
  return _then(Campaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,objective: freezed == objective ? _self.objective : objective // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,compensationType: null == compensationType ? _self.compensationType : compensationType // ignore: cast_nullable_to_non_nullable
as CampaignCompensationType,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budgetMin: freezed == budgetMin ? _self.budgetMin : budgetMin // ignore: cast_nullable_to_non_nullable
as double?,budgetMax: freezed == budgetMax ? _self.budgetMax : budgetMax // ignore: cast_nullable_to_non_nullable
as double?,barterValue: freezed == barterValue ? _self.barterValue : barterValue // ignore: cast_nullable_to_non_nullable
as double?,barterDescription: freezed == barterDescription ? _self.barterDescription : barterDescription // ignore: cast_nullable_to_non_nullable
as String?,creatorSlots: null == creatorSlots ? _self.creatorSlots : creatorSlots // ignore: cast_nullable_to_non_nullable
as int,targetCity: freezed == targetCity ? _self.targetCity : targetCity // ignore: cast_nullable_to_non_nullable
as String?,targetState: freezed == targetState ? _self.targetState : targetState // ignore: cast_nullable_to_non_nullable
as String?,targetCountry: null == targetCountry ? _self.targetCountry : targetCountry // ignore: cast_nullable_to_non_nullable
as String,minFollowers: freezed == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int?,maxFollowers: freezed == maxFollowers ? _self.maxFollowers : maxFollowers // ignore: cast_nullable_to_non_nullable
as int?,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,categoryNames: null == categoryNames ? _self.categoryNames : categoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,languageNames: null == languageNames ? _self.languageNames : languageNames // ignore: cast_nullable_to_non_nullable
as List<String>,deliverables: null == deliverables ? _self.deliverables : deliverables // ignore: cast_nullable_to_non_nullable
as List<CampaignDeliverable>,usageRights: null == usageRights ? _self.usageRights : usageRights // ignore: cast_nullable_to_non_nullable
as CampaignUsageRights,applicationDeadline: freezed == applicationDeadline ? _self.applicationDeadline : applicationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,contentDeadline: freezed == contentDeadline ? _self.contentDeadline : contentDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignStartDate: freezed == campaignStartDate ? _self.campaignStartDate : campaignStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignEndDate: freezed == campaignEndDate ? _self.campaignEndDate : campaignEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,additionalRequirements: freezed == additionalRequirements ? _self.additionalRequirements : additionalRequirements // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,applicantCount: null == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int,selectedCount: null == selectedCount ? _self.selectedCount : selectedCount // ignore: cast_nullable_to_non_nullable
as int,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CampaignUsageRightsCopyWith<$Res> get usageRights {
  
  return $CampaignUsageRightsCopyWith<$Res>(_self.usageRights, (value) {
    return _then(_self.copyWith(usageRights: value));
  });
}
}


/// Adds pattern-matching-related methods to [Campaign].
extension CampaignPatterns on Campaign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Campaign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Campaign value)  $default,){
final _that = this;
switch (_that) {
case _Campaign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Campaign value)?  $default,){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String organizationId,  String? createdBy,  String title,  String? objective,  String description,  CampaignStatus status,  CampaignCompensationType compensationType,  String currency,  double? budgetMin,  double? budgetMax,  double? barterValue,  String? barterDescription,  int creatorSlots,  String? targetCity,  String? targetState,  String targetCountry,  int? minFollowers,  int? maxFollowers,  List<String> categoryIds,  List<String> categoryNames,  List<String> languageCodes,  List<String> languageNames,  List<CampaignDeliverable> deliverables,  CampaignUsageRights usageRights,  DateTime? applicationDeadline,  DateTime? contentDeadline,  DateTime? campaignStartDate,  DateTime? campaignEndDate,  String? additionalRequirements,  String? rejectionReason,  DateTime? publishedAt,  DateTime? closedAt,  DateTime? createdAt,  DateTime? updatedAt,  int applicantCount,  int selectedCount,  String? brandName,  String? brandLogoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.organizationId,_that.createdBy,_that.title,_that.objective,_that.description,_that.status,_that.compensationType,_that.currency,_that.budgetMin,_that.budgetMax,_that.barterValue,_that.barterDescription,_that.creatorSlots,_that.targetCity,_that.targetState,_that.targetCountry,_that.minFollowers,_that.maxFollowers,_that.categoryIds,_that.categoryNames,_that.languageCodes,_that.languageNames,_that.deliverables,_that.usageRights,_that.applicationDeadline,_that.contentDeadline,_that.campaignStartDate,_that.campaignEndDate,_that.additionalRequirements,_that.rejectionReason,_that.publishedAt,_that.closedAt,_that.createdAt,_that.updatedAt,_that.applicantCount,_that.selectedCount,_that.brandName,_that.brandLogoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String organizationId,  String? createdBy,  String title,  String? objective,  String description,  CampaignStatus status,  CampaignCompensationType compensationType,  String currency,  double? budgetMin,  double? budgetMax,  double? barterValue,  String? barterDescription,  int creatorSlots,  String? targetCity,  String? targetState,  String targetCountry,  int? minFollowers,  int? maxFollowers,  List<String> categoryIds,  List<String> categoryNames,  List<String> languageCodes,  List<String> languageNames,  List<CampaignDeliverable> deliverables,  CampaignUsageRights usageRights,  DateTime? applicationDeadline,  DateTime? contentDeadline,  DateTime? campaignStartDate,  DateTime? campaignEndDate,  String? additionalRequirements,  String? rejectionReason,  DateTime? publishedAt,  DateTime? closedAt,  DateTime? createdAt,  DateTime? updatedAt,  int applicantCount,  int selectedCount,  String? brandName,  String? brandLogoUrl)  $default,) {final _that = this;
switch (_that) {
case _Campaign():
return $default(_that.id,_that.organizationId,_that.createdBy,_that.title,_that.objective,_that.description,_that.status,_that.compensationType,_that.currency,_that.budgetMin,_that.budgetMax,_that.barterValue,_that.barterDescription,_that.creatorSlots,_that.targetCity,_that.targetState,_that.targetCountry,_that.minFollowers,_that.maxFollowers,_that.categoryIds,_that.categoryNames,_that.languageCodes,_that.languageNames,_that.deliverables,_that.usageRights,_that.applicationDeadline,_that.contentDeadline,_that.campaignStartDate,_that.campaignEndDate,_that.additionalRequirements,_that.rejectionReason,_that.publishedAt,_that.closedAt,_that.createdAt,_that.updatedAt,_that.applicantCount,_that.selectedCount,_that.brandName,_that.brandLogoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String organizationId,  String? createdBy,  String title,  String? objective,  String description,  CampaignStatus status,  CampaignCompensationType compensationType,  String currency,  double? budgetMin,  double? budgetMax,  double? barterValue,  String? barterDescription,  int creatorSlots,  String? targetCity,  String? targetState,  String targetCountry,  int? minFollowers,  int? maxFollowers,  List<String> categoryIds,  List<String> categoryNames,  List<String> languageCodes,  List<String> languageNames,  List<CampaignDeliverable> deliverables,  CampaignUsageRights usageRights,  DateTime? applicationDeadline,  DateTime? contentDeadline,  DateTime? campaignStartDate,  DateTime? campaignEndDate,  String? additionalRequirements,  String? rejectionReason,  DateTime? publishedAt,  DateTime? closedAt,  DateTime? createdAt,  DateTime? updatedAt,  int applicantCount,  int selectedCount,  String? brandName,  String? brandLogoUrl)?  $default,) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.organizationId,_that.createdBy,_that.title,_that.objective,_that.description,_that.status,_that.compensationType,_that.currency,_that.budgetMin,_that.budgetMax,_that.barterValue,_that.barterDescription,_that.creatorSlots,_that.targetCity,_that.targetState,_that.targetCountry,_that.minFollowers,_that.maxFollowers,_that.categoryIds,_that.categoryNames,_that.languageCodes,_that.languageNames,_that.deliverables,_that.usageRights,_that.applicationDeadline,_that.contentDeadline,_that.campaignStartDate,_that.campaignEndDate,_that.additionalRequirements,_that.rejectionReason,_that.publishedAt,_that.closedAt,_that.createdAt,_that.updatedAt,_that.applicantCount,_that.selectedCount,_that.brandName,_that.brandLogoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Campaign implements Campaign {
  const _Campaign({required this.id, required this.organizationId, this.createdBy, required this.title, this.objective, required this.description, this.status = CampaignStatus.draft, this.compensationType = CampaignCompensationType.paid, this.currency = 'INR', this.budgetMin, this.budgetMax, this.barterValue, this.barterDescription, this.creatorSlots = 1, this.targetCity, this.targetState, this.targetCountry = 'IN', this.minFollowers, this.maxFollowers,  List<String> categoryIds = const [],  List<String> categoryNames = const [],  List<String> languageCodes = const [],  List<String> languageNames = const [],  List<CampaignDeliverable> deliverables = const [], this.usageRights = const CampaignUsageRights(), this.applicationDeadline, this.contentDeadline, this.campaignStartDate, this.campaignEndDate, this.additionalRequirements, this.rejectionReason, this.publishedAt, this.closedAt, this.createdAt, this.updatedAt, this.applicantCount = 0, this.selectedCount = 0, this.brandName, this.brandLogoUrl}): _categoryIds = categoryIds,_categoryNames = categoryNames,_languageCodes = languageCodes,_languageNames = languageNames,_deliverables = deliverables;
  factory _Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);

@override final  String id;
@override final  String organizationId;
@override final  String? createdBy;
@override final  String title;
@override final  String? objective;
@override final  String description;
@override@JsonKey() final  CampaignStatus status;
@override@JsonKey() final  CampaignCompensationType compensationType;
@override@JsonKey() final  String currency;
@override final  double? budgetMin;
@override final  double? budgetMax;
@override final  double? barterValue;
@override final  String? barterDescription;
@override@JsonKey() final  int creatorSlots;
@override final  String? targetCity;
@override final  String? targetState;
@override@JsonKey() final  String targetCountry;
@override final  int? minFollowers;
@override final  int? maxFollowers;
 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

 final  List<String> _categoryNames;
@override@JsonKey() List<String> get categoryNames {
  if (_categoryNames is EqualUnmodifiableListView) return _categoryNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryNames);
}

 final  List<String> _languageCodes;
@override@JsonKey() List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

 final  List<String> _languageNames;
@override@JsonKey() List<String> get languageNames {
  if (_languageNames is EqualUnmodifiableListView) return _languageNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageNames);
}

 final  List<CampaignDeliverable> _deliverables;
@override@JsonKey() List<CampaignDeliverable> get deliverables {
  if (_deliverables is EqualUnmodifiableListView) return _deliverables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deliverables);
}

@override@JsonKey() final  CampaignUsageRights usageRights;
@override final  DateTime? applicationDeadline;
@override final  DateTime? contentDeadline;
@override final  DateTime? campaignStartDate;
@override final  DateTime? campaignEndDate;
@override final  String? additionalRequirements;
@override final  String? rejectionReason;
@override final  DateTime? publishedAt;
@override final  DateTime? closedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  int applicantCount;
@override@JsonKey() final  int selectedCount;
@override final  String? brandName;
@override final  String? brandLogoUrl;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignCopyWith<_Campaign> get copyWith => __$CampaignCopyWithImpl<_Campaign>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Campaign&&(identical(other.id, id) || other.id == id)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.title, title) || other.title == title)&&(identical(other.objective, objective) || other.objective == objective)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.compensationType, compensationType) || other.compensationType == compensationType)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.budgetMin, budgetMin) || other.budgetMin == budgetMin)&&(identical(other.budgetMax, budgetMax) || other.budgetMax == budgetMax)&&(identical(other.barterValue, barterValue) || other.barterValue == barterValue)&&(identical(other.barterDescription, barterDescription) || other.barterDescription == barterDescription)&&(identical(other.creatorSlots, creatorSlots) || other.creatorSlots == creatorSlots)&&(identical(other.targetCity, targetCity) || other.targetCity == targetCity)&&(identical(other.targetState, targetState) || other.targetState == targetState)&&(identical(other.targetCountry, targetCountry) || other.targetCountry == targetCountry)&&(identical(other.minFollowers, minFollowers) || other.minFollowers == minFollowers)&&(identical(other.maxFollowers, maxFollowers) || other.maxFollowers == maxFollowers)&&const DeepCollectionEquality().equals(other.categoryIds, _categoryIds)&&const DeepCollectionEquality().equals(other.categoryNames, _categoryNames)&&const DeepCollectionEquality().equals(other.languageCodes, _languageCodes)&&const DeepCollectionEquality().equals(other.languageNames, _languageNames)&&const DeepCollectionEquality().equals(other.deliverables, _deliverables)&&(identical(other.usageRights, usageRights) || other.usageRights == usageRights)&&(identical(other.applicationDeadline, applicationDeadline) || other.applicationDeadline == applicationDeadline)&&(identical(other.contentDeadline, contentDeadline) || other.contentDeadline == contentDeadline)&&(identical(other.campaignStartDate, campaignStartDate) || other.campaignStartDate == campaignStartDate)&&(identical(other.campaignEndDate, campaignEndDate) || other.campaignEndDate == campaignEndDate)&&(identical(other.additionalRequirements, additionalRequirements) || other.additionalRequirements == additionalRequirements)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.selectedCount, selectedCount) || other.selectedCount == selectedCount)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,organizationId,createdBy,title,objective,description,status,compensationType,currency,budgetMin,budgetMax,barterValue,barterDescription,creatorSlots,targetCity,targetState,targetCountry,minFollowers,maxFollowers,const DeepCollectionEquality().hash(_categoryIds),const DeepCollectionEquality().hash(_categoryNames),const DeepCollectionEquality().hash(_languageCodes),const DeepCollectionEquality().hash(_languageNames),const DeepCollectionEquality().hash(_deliverables),usageRights,applicationDeadline,contentDeadline,campaignStartDate,campaignEndDate,additionalRequirements,rejectionReason,publishedAt,closedAt,createdAt,updatedAt,applicantCount,selectedCount,brandName,brandLogoUrl]);
}

@override
String toString() {
    return 'Campaign(id: $id, organizationId: $organizationId, createdBy: $createdBy, title: $title, objective: $objective, description: $description, status: $status, compensationType: $compensationType, currency: $currency, budgetMin: $budgetMin, budgetMax: $budgetMax, barterValue: $barterValue, barterDescription: $barterDescription, creatorSlots: $creatorSlots, targetCity: $targetCity, targetState: $targetState, targetCountry: $targetCountry, minFollowers: $minFollowers, maxFollowers: $maxFollowers, categoryIds: $categoryIds, categoryNames: $categoryNames, languageCodes: $languageCodes, languageNames: $languageNames, deliverables: $deliverables, usageRights: $usageRights, applicationDeadline: $applicationDeadline, contentDeadline: $contentDeadline, campaignStartDate: $campaignStartDate, campaignEndDate: $campaignEndDate, additionalRequirements: $additionalRequirements, rejectionReason: $rejectionReason, publishedAt: $publishedAt, closedAt: $closedAt, createdAt: $createdAt, updatedAt: $updatedAt, applicantCount: $applicantCount, selectedCount: $selectedCount, brandName: $brandName, brandLogoUrl: $brandLogoUrl)';
}


}

/// @nodoc
abstract mixin class _$CampaignCopyWith<$Res> implements $CampaignCopyWith<$Res> {
  factory _$CampaignCopyWith(_Campaign value, $Res Function(_Campaign) _then) = __$CampaignCopyWithImpl;
@override @useResult
$Res call({
 String id, String organizationId, String? createdBy, String title, String? objective, String description, CampaignStatus status, CampaignCompensationType compensationType, String currency, double? budgetMin, double? budgetMax, double? barterValue, String? barterDescription, int creatorSlots, String? targetCity, String? targetState, String targetCountry, int? minFollowers, int? maxFollowers, List<String> categoryIds, List<String> categoryNames, List<String> languageCodes, List<String> languageNames, List<CampaignDeliverable> deliverables, CampaignUsageRights usageRights, DateTime? applicationDeadline, DateTime? contentDeadline, DateTime? campaignStartDate, DateTime? campaignEndDate, String? additionalRequirements, String? rejectionReason, DateTime? publishedAt, DateTime? closedAt, DateTime? createdAt, DateTime? updatedAt, int applicantCount, int selectedCount, String? brandName, String? brandLogoUrl
});


@override $CampaignUsageRightsCopyWith<$Res> get usageRights;

}
/// @nodoc
class __$CampaignCopyWithImpl<$Res>
    implements _$CampaignCopyWith<$Res> {
  __$CampaignCopyWithImpl(this._self, this._then);

  final _Campaign _self;
  final $Res Function(_Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organizationId = null,Object? createdBy = freezed,Object? title = null,Object? objective = freezed,Object? description = null,Object? status = null,Object? compensationType = null,Object? currency = null,Object? budgetMin = freezed,Object? budgetMax = freezed,Object? barterValue = freezed,Object? barterDescription = freezed,Object? creatorSlots = null,Object? targetCity = freezed,Object? targetState = freezed,Object? targetCountry = null,Object? minFollowers = freezed,Object? maxFollowers = freezed,Object? categoryIds = null,Object? categoryNames = null,Object? languageCodes = null,Object? languageNames = null,Object? deliverables = null,Object? usageRights = null,Object? applicationDeadline = freezed,Object? contentDeadline = freezed,Object? campaignStartDate = freezed,Object? campaignEndDate = freezed,Object? additionalRequirements = freezed,Object? rejectionReason = freezed,Object? publishedAt = freezed,Object? closedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? applicantCount = null,Object? selectedCount = null,Object? brandName = freezed,Object? brandLogoUrl = freezed,}) {
  return _then(_Campaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,objective: freezed == objective ? _self.objective : objective // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,compensationType: null == compensationType ? _self.compensationType : compensationType // ignore: cast_nullable_to_non_nullable
as CampaignCompensationType,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budgetMin: freezed == budgetMin ? _self.budgetMin : budgetMin // ignore: cast_nullable_to_non_nullable
as double?,budgetMax: freezed == budgetMax ? _self.budgetMax : budgetMax // ignore: cast_nullable_to_non_nullable
as double?,barterValue: freezed == barterValue ? _self.barterValue : barterValue // ignore: cast_nullable_to_non_nullable
as double?,barterDescription: freezed == barterDescription ? _self.barterDescription : barterDescription // ignore: cast_nullable_to_non_nullable
as String?,creatorSlots: null == creatorSlots ? _self.creatorSlots : creatorSlots // ignore: cast_nullable_to_non_nullable
as int,targetCity: freezed == targetCity ? _self.targetCity : targetCity // ignore: cast_nullable_to_non_nullable
as String?,targetState: freezed == targetState ? _self.targetState : targetState // ignore: cast_nullable_to_non_nullable
as String?,targetCountry: null == targetCountry ? _self.targetCountry : targetCountry // ignore: cast_nullable_to_non_nullable
as String,minFollowers: freezed == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int?,maxFollowers: freezed == maxFollowers ? _self.maxFollowers : maxFollowers // ignore: cast_nullable_to_non_nullable
as int?,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,categoryNames: null == categoryNames ? _self._categoryNames : categoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,languageNames: null == languageNames ? _self._languageNames : languageNames // ignore: cast_nullable_to_non_nullable
as List<String>,deliverables: null == deliverables ? _self._deliverables : deliverables // ignore: cast_nullable_to_non_nullable
as List<CampaignDeliverable>,usageRights: null == usageRights ? _self.usageRights : usageRights // ignore: cast_nullable_to_non_nullable
as CampaignUsageRights,applicationDeadline: freezed == applicationDeadline ? _self.applicationDeadline : applicationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,contentDeadline: freezed == contentDeadline ? _self.contentDeadline : contentDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignStartDate: freezed == campaignStartDate ? _self.campaignStartDate : campaignStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignEndDate: freezed == campaignEndDate ? _self.campaignEndDate : campaignEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,additionalRequirements: freezed == additionalRequirements ? _self.additionalRequirements : additionalRequirements // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,applicantCount: null == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int,selectedCount: null == selectedCount ? _self.selectedCount : selectedCount // ignore: cast_nullable_to_non_nullable
as int,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CampaignUsageRightsCopyWith<$Res> get usageRights {
  
  return $CampaignUsageRightsCopyWith<$Res>(_self.usageRights, (value) {
    return _then(_self.copyWith(usageRights: value));
  });
}
}

// dart format on
