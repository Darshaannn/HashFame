// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creator_discovery_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatorDiscoveryItem {

 String get creatorId; String get displayName; String? get professionalName; String? get avatarPath; String? get city; String? get state; String get country; List<String> get primaryCategoryNames; List<String> get subcategoryNames; List<String> get languageNames; SocialPlatform? get primaryPlatform; int? get totalFollowers; double? get startingRate; DeliverableType? get startingRateDeliverable; AvailabilityStatus get availabilityStatus; bool get isRepresented; VerificationSummary get verificationSummary;
/// Create a copy of CreatorDiscoveryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatorDiscoveryItemCopyWith<CreatorDiscoveryItem> get copyWith => _$CreatorDiscoveryItemCopyWithImpl<CreatorDiscoveryItem>(this as CreatorDiscoveryItem, _$identity);

  /// Serializes this CreatorDiscoveryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreatorDiscoveryItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatorDiscoveryItem&&(identical(other.creatorId, _this.creatorId) || other.creatorId == _this.creatorId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.professionalName, _this.professionalName) || other.professionalName == _this.professionalName)&&(identical(other.avatarPath, _this.avatarPath) || other.avatarPath == _this.avatarPath)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.country, _this.country) || other.country == _this.country)&&const DeepCollectionEquality().equals(other.primaryCategoryNames, _this.primaryCategoryNames)&&const DeepCollectionEquality().equals(other.subcategoryNames, _this.subcategoryNames)&&const DeepCollectionEquality().equals(other.languageNames, _this.languageNames)&&(identical(other.primaryPlatform, _this.primaryPlatform) || other.primaryPlatform == _this.primaryPlatform)&&(identical(other.totalFollowers, _this.totalFollowers) || other.totalFollowers == _this.totalFollowers)&&(identical(other.startingRate, _this.startingRate) || other.startingRate == _this.startingRate)&&(identical(other.startingRateDeliverable, _this.startingRateDeliverable) || other.startingRateDeliverable == _this.startingRateDeliverable)&&(identical(other.availabilityStatus, _this.availabilityStatus) || other.availabilityStatus == _this.availabilityStatus)&&(identical(other.isRepresented, _this.isRepresented) || other.isRepresented == _this.isRepresented)&&(identical(other.verificationSummary, _this.verificationSummary) || other.verificationSummary == _this.verificationSummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreatorDiscoveryItem;
  return Object.hash(runtimeType,_this.creatorId,_this.displayName,_this.professionalName,_this.avatarPath,_this.city,_this.state,_this.country,const DeepCollectionEquality().hash(_this.primaryCategoryNames),const DeepCollectionEquality().hash(_this.subcategoryNames),const DeepCollectionEquality().hash(_this.languageNames),_this.primaryPlatform,_this.totalFollowers,_this.startingRate,_this.startingRateDeliverable,_this.availabilityStatus,_this.isRepresented,_this.verificationSummary);
}

@override
String toString() {
  final _this = this as CreatorDiscoveryItem;
  return 'CreatorDiscoveryItem(creatorId: ${_this.creatorId}, displayName: ${_this.displayName}, professionalName: ${_this.professionalName}, avatarPath: ${_this.avatarPath}, city: ${_this.city}, state: ${_this.state}, country: ${_this.country}, primaryCategoryNames: ${_this.primaryCategoryNames}, subcategoryNames: ${_this.subcategoryNames}, languageNames: ${_this.languageNames}, primaryPlatform: ${_this.primaryPlatform}, totalFollowers: ${_this.totalFollowers}, startingRate: ${_this.startingRate}, startingRateDeliverable: ${_this.startingRateDeliverable}, availabilityStatus: ${_this.availabilityStatus}, isRepresented: ${_this.isRepresented}, verificationSummary: ${_this.verificationSummary})';
}


}

/// @nodoc
abstract mixin class $CreatorDiscoveryItemCopyWith<$Res>  {
  factory $CreatorDiscoveryItemCopyWith(CreatorDiscoveryItem value, $Res Function(CreatorDiscoveryItem) _then) = _$CreatorDiscoveryItemCopyWithImpl;
@useResult
$Res call({
 String creatorId, String displayName, String? professionalName, String? avatarPath, String? city, String? state, String country, List<String> primaryCategoryNames, List<String> subcategoryNames, List<String> languageNames, SocialPlatform? primaryPlatform, int? totalFollowers, double? startingRate, DeliverableType? startingRateDeliverable, AvailabilityStatus availabilityStatus, bool isRepresented, VerificationSummary verificationSummary
});


$VerificationSummaryCopyWith<$Res> get verificationSummary;

}
/// @nodoc
class _$CreatorDiscoveryItemCopyWithImpl<$Res>
    implements $CreatorDiscoveryItemCopyWith<$Res> {
  _$CreatorDiscoveryItemCopyWithImpl(this._self, this._then);

  final CreatorDiscoveryItem _self;
  final $Res Function(CreatorDiscoveryItem) _then;

/// Create a copy of CreatorDiscoveryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? creatorId = null,Object? displayName = null,Object? professionalName = freezed,Object? avatarPath = freezed,Object? city = freezed,Object? state = freezed,Object? country = null,Object? primaryCategoryNames = null,Object? subcategoryNames = null,Object? languageNames = null,Object? primaryPlatform = freezed,Object? totalFollowers = freezed,Object? startingRate = freezed,Object? startingRateDeliverable = freezed,Object? availabilityStatus = null,Object? isRepresented = null,Object? verificationSummary = null,}) {
  return _then(CreatorDiscoveryItem(
creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,professionalName: freezed == professionalName ? _self.professionalName : professionalName // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,primaryCategoryNames: null == primaryCategoryNames ? _self.primaryCategoryNames : primaryCategoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,subcategoryNames: null == subcategoryNames ? _self.subcategoryNames : subcategoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,languageNames: null == languageNames ? _self.languageNames : languageNames // ignore: cast_nullable_to_non_nullable
as List<String>,primaryPlatform: freezed == primaryPlatform ? _self.primaryPlatform : primaryPlatform // ignore: cast_nullable_to_non_nullable
as SocialPlatform?,totalFollowers: freezed == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int?,startingRate: freezed == startingRate ? _self.startingRate : startingRate // ignore: cast_nullable_to_non_nullable
as double?,startingRateDeliverable: freezed == startingRateDeliverable ? _self.startingRateDeliverable : startingRateDeliverable // ignore: cast_nullable_to_non_nullable
as DeliverableType?,availabilityStatus: null == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as AvailabilityStatus,isRepresented: null == isRepresented ? _self.isRepresented : isRepresented // ignore: cast_nullable_to_non_nullable
as bool,verificationSummary: null == verificationSummary ? _self.verificationSummary : verificationSummary // ignore: cast_nullable_to_non_nullable
as VerificationSummary,
  ));
}
/// Create a copy of CreatorDiscoveryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationSummaryCopyWith<$Res> get verificationSummary {
  
  return $VerificationSummaryCopyWith<$Res>(_self.verificationSummary, (value) {
    return _then(_self.copyWith(verificationSummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatorDiscoveryItem].
extension CreatorDiscoveryItemPatterns on CreatorDiscoveryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatorDiscoveryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatorDiscoveryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatorDiscoveryItem value)  $default,){
final _that = this;
switch (_that) {
case _CreatorDiscoveryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatorDiscoveryItem value)?  $default,){
final _that = this;
switch (_that) {
case _CreatorDiscoveryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String creatorId,  String displayName,  String? professionalName,  String? avatarPath,  String? city,  String? state,  String country,  List<String> primaryCategoryNames,  List<String> subcategoryNames,  List<String> languageNames,  SocialPlatform? primaryPlatform,  int? totalFollowers,  double? startingRate,  DeliverableType? startingRateDeliverable,  AvailabilityStatus availabilityStatus,  bool isRepresented,  VerificationSummary verificationSummary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatorDiscoveryItem() when $default != null:
return $default(_that.creatorId,_that.displayName,_that.professionalName,_that.avatarPath,_that.city,_that.state,_that.country,_that.primaryCategoryNames,_that.subcategoryNames,_that.languageNames,_that.primaryPlatform,_that.totalFollowers,_that.startingRate,_that.startingRateDeliverable,_that.availabilityStatus,_that.isRepresented,_that.verificationSummary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String creatorId,  String displayName,  String? professionalName,  String? avatarPath,  String? city,  String? state,  String country,  List<String> primaryCategoryNames,  List<String> subcategoryNames,  List<String> languageNames,  SocialPlatform? primaryPlatform,  int? totalFollowers,  double? startingRate,  DeliverableType? startingRateDeliverable,  AvailabilityStatus availabilityStatus,  bool isRepresented,  VerificationSummary verificationSummary)  $default,) {final _that = this;
switch (_that) {
case _CreatorDiscoveryItem():
return $default(_that.creatorId,_that.displayName,_that.professionalName,_that.avatarPath,_that.city,_that.state,_that.country,_that.primaryCategoryNames,_that.subcategoryNames,_that.languageNames,_that.primaryPlatform,_that.totalFollowers,_that.startingRate,_that.startingRateDeliverable,_that.availabilityStatus,_that.isRepresented,_that.verificationSummary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String creatorId,  String displayName,  String? professionalName,  String? avatarPath,  String? city,  String? state,  String country,  List<String> primaryCategoryNames,  List<String> subcategoryNames,  List<String> languageNames,  SocialPlatform? primaryPlatform,  int? totalFollowers,  double? startingRate,  DeliverableType? startingRateDeliverable,  AvailabilityStatus availabilityStatus,  bool isRepresented,  VerificationSummary verificationSummary)?  $default,) {final _that = this;
switch (_that) {
case _CreatorDiscoveryItem() when $default != null:
return $default(_that.creatorId,_that.displayName,_that.professionalName,_that.avatarPath,_that.city,_that.state,_that.country,_that.primaryCategoryNames,_that.subcategoryNames,_that.languageNames,_that.primaryPlatform,_that.totalFollowers,_that.startingRate,_that.startingRateDeliverable,_that.availabilityStatus,_that.isRepresented,_that.verificationSummary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatorDiscoveryItem implements CreatorDiscoveryItem {
  const _CreatorDiscoveryItem({required this.creatorId, required this.displayName, this.professionalName, this.avatarPath, this.city, this.state, this.country = 'IN',  List<String> primaryCategoryNames = const [],  List<String> subcategoryNames = const [],  List<String> languageNames = const [], this.primaryPlatform, this.totalFollowers, this.startingRate, this.startingRateDeliverable, this.availabilityStatus = AvailabilityStatus.open, this.isRepresented = false, this.verificationSummary = const VerificationSummary()}): _primaryCategoryNames = primaryCategoryNames,_subcategoryNames = subcategoryNames,_languageNames = languageNames;
  factory _CreatorDiscoveryItem.fromJson(Map<String, dynamic> json) => _$CreatorDiscoveryItemFromJson(json);

@override final  String creatorId;
@override final  String displayName;
@override final  String? professionalName;
@override final  String? avatarPath;
@override final  String? city;
@override final  String? state;
@override@JsonKey() final  String country;
 final  List<String> _primaryCategoryNames;
@override@JsonKey() List<String> get primaryCategoryNames {
  if (_primaryCategoryNames is EqualUnmodifiableListView) return _primaryCategoryNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryCategoryNames);
}

 final  List<String> _subcategoryNames;
@override@JsonKey() List<String> get subcategoryNames {
  if (_subcategoryNames is EqualUnmodifiableListView) return _subcategoryNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subcategoryNames);
}

 final  List<String> _languageNames;
@override@JsonKey() List<String> get languageNames {
  if (_languageNames is EqualUnmodifiableListView) return _languageNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageNames);
}

@override final  SocialPlatform? primaryPlatform;
@override final  int? totalFollowers;
@override final  double? startingRate;
@override final  DeliverableType? startingRateDeliverable;
@override@JsonKey() final  AvailabilityStatus availabilityStatus;
@override@JsonKey() final  bool isRepresented;
@override@JsonKey() final  VerificationSummary verificationSummary;

/// Create a copy of CreatorDiscoveryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatorDiscoveryItemCopyWith<_CreatorDiscoveryItem> get copyWith => __$CreatorDiscoveryItemCopyWithImpl<_CreatorDiscoveryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatorDiscoveryItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatorDiscoveryItem&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.professionalName, professionalName) || other.professionalName == professionalName)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&const DeepCollectionEquality().equals(other.primaryCategoryNames, _primaryCategoryNames)&&const DeepCollectionEquality().equals(other.subcategoryNames, _subcategoryNames)&&const DeepCollectionEquality().equals(other.languageNames, _languageNames)&&(identical(other.primaryPlatform, primaryPlatform) || other.primaryPlatform == primaryPlatform)&&(identical(other.totalFollowers, totalFollowers) || other.totalFollowers == totalFollowers)&&(identical(other.startingRate, startingRate) || other.startingRate == startingRate)&&(identical(other.startingRateDeliverable, startingRateDeliverable) || other.startingRateDeliverable == startingRateDeliverable)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&(identical(other.isRepresented, isRepresented) || other.isRepresented == isRepresented)&&(identical(other.verificationSummary, verificationSummary) || other.verificationSummary == verificationSummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,creatorId,displayName,professionalName,avatarPath,city,state,country,const DeepCollectionEquality().hash(_primaryCategoryNames),const DeepCollectionEquality().hash(_subcategoryNames),const DeepCollectionEquality().hash(_languageNames),primaryPlatform,totalFollowers,startingRate,startingRateDeliverable,availabilityStatus,isRepresented,verificationSummary);
}

@override
String toString() {
    return 'CreatorDiscoveryItem(creatorId: $creatorId, displayName: $displayName, professionalName: $professionalName, avatarPath: $avatarPath, city: $city, state: $state, country: $country, primaryCategoryNames: $primaryCategoryNames, subcategoryNames: $subcategoryNames, languageNames: $languageNames, primaryPlatform: $primaryPlatform, totalFollowers: $totalFollowers, startingRate: $startingRate, startingRateDeliverable: $startingRateDeliverable, availabilityStatus: $availabilityStatus, isRepresented: $isRepresented, verificationSummary: $verificationSummary)';
}


}

/// @nodoc
abstract mixin class _$CreatorDiscoveryItemCopyWith<$Res> implements $CreatorDiscoveryItemCopyWith<$Res> {
  factory _$CreatorDiscoveryItemCopyWith(_CreatorDiscoveryItem value, $Res Function(_CreatorDiscoveryItem) _then) = __$CreatorDiscoveryItemCopyWithImpl;
@override @useResult
$Res call({
 String creatorId, String displayName, String? professionalName, String? avatarPath, String? city, String? state, String country, List<String> primaryCategoryNames, List<String> subcategoryNames, List<String> languageNames, SocialPlatform? primaryPlatform, int? totalFollowers, double? startingRate, DeliverableType? startingRateDeliverable, AvailabilityStatus availabilityStatus, bool isRepresented, VerificationSummary verificationSummary
});


@override $VerificationSummaryCopyWith<$Res> get verificationSummary;

}
/// @nodoc
class __$CreatorDiscoveryItemCopyWithImpl<$Res>
    implements _$CreatorDiscoveryItemCopyWith<$Res> {
  __$CreatorDiscoveryItemCopyWithImpl(this._self, this._then);

  final _CreatorDiscoveryItem _self;
  final $Res Function(_CreatorDiscoveryItem) _then;

/// Create a copy of CreatorDiscoveryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? creatorId = null,Object? displayName = null,Object? professionalName = freezed,Object? avatarPath = freezed,Object? city = freezed,Object? state = freezed,Object? country = null,Object? primaryCategoryNames = null,Object? subcategoryNames = null,Object? languageNames = null,Object? primaryPlatform = freezed,Object? totalFollowers = freezed,Object? startingRate = freezed,Object? startingRateDeliverable = freezed,Object? availabilityStatus = null,Object? isRepresented = null,Object? verificationSummary = null,}) {
  return _then(_CreatorDiscoveryItem(
creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,professionalName: freezed == professionalName ? _self.professionalName : professionalName // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,primaryCategoryNames: null == primaryCategoryNames ? _self._primaryCategoryNames : primaryCategoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,subcategoryNames: null == subcategoryNames ? _self._subcategoryNames : subcategoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,languageNames: null == languageNames ? _self._languageNames : languageNames // ignore: cast_nullable_to_non_nullable
as List<String>,primaryPlatform: freezed == primaryPlatform ? _self.primaryPlatform : primaryPlatform // ignore: cast_nullable_to_non_nullable
as SocialPlatform?,totalFollowers: freezed == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int?,startingRate: freezed == startingRate ? _self.startingRate : startingRate // ignore: cast_nullable_to_non_nullable
as double?,startingRateDeliverable: freezed == startingRateDeliverable ? _self.startingRateDeliverable : startingRateDeliverable // ignore: cast_nullable_to_non_nullable
as DeliverableType?,availabilityStatus: null == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as AvailabilityStatus,isRepresented: null == isRepresented ? _self.isRepresented : isRepresented // ignore: cast_nullable_to_non_nullable
as bool,verificationSummary: null == verificationSummary ? _self.verificationSummary : verificationSummary // ignore: cast_nullable_to_non_nullable
as VerificationSummary,
  ));
}

/// Create a copy of CreatorDiscoveryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationSummaryCopyWith<$Res> get verificationSummary {
  
  return $VerificationSummaryCopyWith<$Res>(_self.verificationSummary, (value) {
    return _then(_self.copyWith(verificationSummary: value));
  });
}
}

// dart format on
