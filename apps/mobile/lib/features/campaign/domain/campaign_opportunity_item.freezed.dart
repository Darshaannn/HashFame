// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_opportunity_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampaignOpportunityItem {

 String get campaignId; String get organizationId; String get title; String get brandName; String? get brandLogoUrl; CampaignCompensationType get compensationType; String get currency; double? get budgetMin; double? get budgetMax; double? get barterValue; String? get barterDescription; int get creatorSlots; List<String> get categoryNames; List<String> get languageNames; List<String> get platforms; int get deliverableCount; String? get targetCity; String? get targetState; String get targetCountry; DateTime? get applicationDeadline; DateTime? get contentDeadline; DateTime? get publishedAt; String? get myApplicationStatus; String? get myApplicationId;
/// Create a copy of CampaignOpportunityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignOpportunityItemCopyWith<CampaignOpportunityItem> get copyWith => _$CampaignOpportunityItemCopyWithImpl<CampaignOpportunityItem>(this as CampaignOpportunityItem, _$identity);

  /// Serializes this CampaignOpportunityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CampaignOpportunityItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignOpportunityItem&&(identical(other.campaignId, _this.campaignId) || other.campaignId == _this.campaignId)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.brandName, _this.brandName) || other.brandName == _this.brandName)&&(identical(other.brandLogoUrl, _this.brandLogoUrl) || other.brandLogoUrl == _this.brandLogoUrl)&&(identical(other.compensationType, _this.compensationType) || other.compensationType == _this.compensationType)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.budgetMin, _this.budgetMin) || other.budgetMin == _this.budgetMin)&&(identical(other.budgetMax, _this.budgetMax) || other.budgetMax == _this.budgetMax)&&(identical(other.barterValue, _this.barterValue) || other.barterValue == _this.barterValue)&&(identical(other.barterDescription, _this.barterDescription) || other.barterDescription == _this.barterDescription)&&(identical(other.creatorSlots, _this.creatorSlots) || other.creatorSlots == _this.creatorSlots)&&const DeepCollectionEquality().equals(other.categoryNames, _this.categoryNames)&&const DeepCollectionEquality().equals(other.languageNames, _this.languageNames)&&const DeepCollectionEquality().equals(other.platforms, _this.platforms)&&(identical(other.deliverableCount, _this.deliverableCount) || other.deliverableCount == _this.deliverableCount)&&(identical(other.targetCity, _this.targetCity) || other.targetCity == _this.targetCity)&&(identical(other.targetState, _this.targetState) || other.targetState == _this.targetState)&&(identical(other.targetCountry, _this.targetCountry) || other.targetCountry == _this.targetCountry)&&(identical(other.applicationDeadline, _this.applicationDeadline) || other.applicationDeadline == _this.applicationDeadline)&&(identical(other.contentDeadline, _this.contentDeadline) || other.contentDeadline == _this.contentDeadline)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.myApplicationStatus, _this.myApplicationStatus) || other.myApplicationStatus == _this.myApplicationStatus)&&(identical(other.myApplicationId, _this.myApplicationId) || other.myApplicationId == _this.myApplicationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CampaignOpportunityItem;
  return Object.hashAll([runtimeType,_this.campaignId,_this.organizationId,_this.title,_this.brandName,_this.brandLogoUrl,_this.compensationType,_this.currency,_this.budgetMin,_this.budgetMax,_this.barterValue,_this.barterDescription,_this.creatorSlots,const DeepCollectionEquality().hash(_this.categoryNames),const DeepCollectionEquality().hash(_this.languageNames),const DeepCollectionEquality().hash(_this.platforms),_this.deliverableCount,_this.targetCity,_this.targetState,_this.targetCountry,_this.applicationDeadline,_this.contentDeadline,_this.publishedAt,_this.myApplicationStatus,_this.myApplicationId]);
}

@override
String toString() {
  final _this = this as CampaignOpportunityItem;
  return 'CampaignOpportunityItem(campaignId: ${_this.campaignId}, organizationId: ${_this.organizationId}, title: ${_this.title}, brandName: ${_this.brandName}, brandLogoUrl: ${_this.brandLogoUrl}, compensationType: ${_this.compensationType}, currency: ${_this.currency}, budgetMin: ${_this.budgetMin}, budgetMax: ${_this.budgetMax}, barterValue: ${_this.barterValue}, barterDescription: ${_this.barterDescription}, creatorSlots: ${_this.creatorSlots}, categoryNames: ${_this.categoryNames}, languageNames: ${_this.languageNames}, platforms: ${_this.platforms}, deliverableCount: ${_this.deliverableCount}, targetCity: ${_this.targetCity}, targetState: ${_this.targetState}, targetCountry: ${_this.targetCountry}, applicationDeadline: ${_this.applicationDeadline}, contentDeadline: ${_this.contentDeadline}, publishedAt: ${_this.publishedAt}, myApplicationStatus: ${_this.myApplicationStatus}, myApplicationId: ${_this.myApplicationId})';
}


}

/// @nodoc
abstract mixin class $CampaignOpportunityItemCopyWith<$Res>  {
  factory $CampaignOpportunityItemCopyWith(CampaignOpportunityItem value, $Res Function(CampaignOpportunityItem) _then) = _$CampaignOpportunityItemCopyWithImpl;
@useResult
$Res call({
 String campaignId, String organizationId, String title, String brandName, String? brandLogoUrl, CampaignCompensationType compensationType, String currency, double? budgetMin, double? budgetMax, double? barterValue, String? barterDescription, int creatorSlots, List<String> categoryNames, List<String> languageNames, List<String> platforms, int deliverableCount, String? targetCity, String? targetState, String targetCountry, DateTime? applicationDeadline, DateTime? contentDeadline, DateTime? publishedAt, String? myApplicationStatus, String? myApplicationId
});




}
/// @nodoc
class _$CampaignOpportunityItemCopyWithImpl<$Res>
    implements $CampaignOpportunityItemCopyWith<$Res> {
  _$CampaignOpportunityItemCopyWithImpl(this._self, this._then);

  final CampaignOpportunityItem _self;
  final $Res Function(CampaignOpportunityItem) _then;

/// Create a copy of CampaignOpportunityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? campaignId = null,Object? organizationId = null,Object? title = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? compensationType = null,Object? currency = null,Object? budgetMin = freezed,Object? budgetMax = freezed,Object? barterValue = freezed,Object? barterDescription = freezed,Object? creatorSlots = null,Object? categoryNames = null,Object? languageNames = null,Object? platforms = null,Object? deliverableCount = null,Object? targetCity = freezed,Object? targetState = freezed,Object? targetCountry = null,Object? applicationDeadline = freezed,Object? contentDeadline = freezed,Object? publishedAt = freezed,Object? myApplicationStatus = freezed,Object? myApplicationId = freezed,}) {
  return _then(CampaignOpportunityItem(
campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,compensationType: null == compensationType ? _self.compensationType : compensationType // ignore: cast_nullable_to_non_nullable
as CampaignCompensationType,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budgetMin: freezed == budgetMin ? _self.budgetMin : budgetMin // ignore: cast_nullable_to_non_nullable
as double?,budgetMax: freezed == budgetMax ? _self.budgetMax : budgetMax // ignore: cast_nullable_to_non_nullable
as double?,barterValue: freezed == barterValue ? _self.barterValue : barterValue // ignore: cast_nullable_to_non_nullable
as double?,barterDescription: freezed == barterDescription ? _self.barterDescription : barterDescription // ignore: cast_nullable_to_non_nullable
as String?,creatorSlots: null == creatorSlots ? _self.creatorSlots : creatorSlots // ignore: cast_nullable_to_non_nullable
as int,categoryNames: null == categoryNames ? _self.categoryNames : categoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,languageNames: null == languageNames ? _self.languageNames : languageNames // ignore: cast_nullable_to_non_nullable
as List<String>,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,deliverableCount: null == deliverableCount ? _self.deliverableCount : deliverableCount // ignore: cast_nullable_to_non_nullable
as int,targetCity: freezed == targetCity ? _self.targetCity : targetCity // ignore: cast_nullable_to_non_nullable
as String?,targetState: freezed == targetState ? _self.targetState : targetState // ignore: cast_nullable_to_non_nullable
as String?,targetCountry: null == targetCountry ? _self.targetCountry : targetCountry // ignore: cast_nullable_to_non_nullable
as String,applicationDeadline: freezed == applicationDeadline ? _self.applicationDeadline : applicationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,contentDeadline: freezed == contentDeadline ? _self.contentDeadline : contentDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,myApplicationStatus: freezed == myApplicationStatus ? _self.myApplicationStatus : myApplicationStatus // ignore: cast_nullable_to_non_nullable
as String?,myApplicationId: freezed == myApplicationId ? _self.myApplicationId : myApplicationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignOpportunityItem].
extension CampaignOpportunityItemPatterns on CampaignOpportunityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignOpportunityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignOpportunityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignOpportunityItem value)  $default,){
final _that = this;
switch (_that) {
case _CampaignOpportunityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignOpportunityItem value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignOpportunityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String campaignId,  String organizationId,  String title,  String brandName,  String? brandLogoUrl,  CampaignCompensationType compensationType,  String currency,  double? budgetMin,  double? budgetMax,  double? barterValue,  String? barterDescription,  int creatorSlots,  List<String> categoryNames,  List<String> languageNames,  List<String> platforms,  int deliverableCount,  String? targetCity,  String? targetState,  String targetCountry,  DateTime? applicationDeadline,  DateTime? contentDeadline,  DateTime? publishedAt,  String? myApplicationStatus,  String? myApplicationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignOpportunityItem() when $default != null:
return $default(_that.campaignId,_that.organizationId,_that.title,_that.brandName,_that.brandLogoUrl,_that.compensationType,_that.currency,_that.budgetMin,_that.budgetMax,_that.barterValue,_that.barterDescription,_that.creatorSlots,_that.categoryNames,_that.languageNames,_that.platforms,_that.deliverableCount,_that.targetCity,_that.targetState,_that.targetCountry,_that.applicationDeadline,_that.contentDeadline,_that.publishedAt,_that.myApplicationStatus,_that.myApplicationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String campaignId,  String organizationId,  String title,  String brandName,  String? brandLogoUrl,  CampaignCompensationType compensationType,  String currency,  double? budgetMin,  double? budgetMax,  double? barterValue,  String? barterDescription,  int creatorSlots,  List<String> categoryNames,  List<String> languageNames,  List<String> platforms,  int deliverableCount,  String? targetCity,  String? targetState,  String targetCountry,  DateTime? applicationDeadline,  DateTime? contentDeadline,  DateTime? publishedAt,  String? myApplicationStatus,  String? myApplicationId)  $default,) {final _that = this;
switch (_that) {
case _CampaignOpportunityItem():
return $default(_that.campaignId,_that.organizationId,_that.title,_that.brandName,_that.brandLogoUrl,_that.compensationType,_that.currency,_that.budgetMin,_that.budgetMax,_that.barterValue,_that.barterDescription,_that.creatorSlots,_that.categoryNames,_that.languageNames,_that.platforms,_that.deliverableCount,_that.targetCity,_that.targetState,_that.targetCountry,_that.applicationDeadline,_that.contentDeadline,_that.publishedAt,_that.myApplicationStatus,_that.myApplicationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String campaignId,  String organizationId,  String title,  String brandName,  String? brandLogoUrl,  CampaignCompensationType compensationType,  String currency,  double? budgetMin,  double? budgetMax,  double? barterValue,  String? barterDescription,  int creatorSlots,  List<String> categoryNames,  List<String> languageNames,  List<String> platforms,  int deliverableCount,  String? targetCity,  String? targetState,  String targetCountry,  DateTime? applicationDeadline,  DateTime? contentDeadline,  DateTime? publishedAt,  String? myApplicationStatus,  String? myApplicationId)?  $default,) {final _that = this;
switch (_that) {
case _CampaignOpportunityItem() when $default != null:
return $default(_that.campaignId,_that.organizationId,_that.title,_that.brandName,_that.brandLogoUrl,_that.compensationType,_that.currency,_that.budgetMin,_that.budgetMax,_that.barterValue,_that.barterDescription,_that.creatorSlots,_that.categoryNames,_that.languageNames,_that.platforms,_that.deliverableCount,_that.targetCity,_that.targetState,_that.targetCountry,_that.applicationDeadline,_that.contentDeadline,_that.publishedAt,_that.myApplicationStatus,_that.myApplicationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignOpportunityItem implements CampaignOpportunityItem {
  const _CampaignOpportunityItem({required this.campaignId, required this.organizationId, required this.title, required this.brandName, this.brandLogoUrl, required this.compensationType, this.currency = 'INR', this.budgetMin, this.budgetMax, this.barterValue, this.barterDescription, this.creatorSlots = 1,  List<String> categoryNames = const [],  List<String> languageNames = const [],  List<String> platforms = const [], this.deliverableCount = 0, this.targetCity, this.targetState, this.targetCountry = 'IN', this.applicationDeadline, this.contentDeadline, this.publishedAt, this.myApplicationStatus, this.myApplicationId}): _categoryNames = categoryNames,_languageNames = languageNames,_platforms = platforms;
  factory _CampaignOpportunityItem.fromJson(Map<String, dynamic> json) => _$CampaignOpportunityItemFromJson(json);

@override final  String campaignId;
@override final  String organizationId;
@override final  String title;
@override final  String brandName;
@override final  String? brandLogoUrl;
@override final  CampaignCompensationType compensationType;
@override@JsonKey() final  String currency;
@override final  double? budgetMin;
@override final  double? budgetMax;
@override final  double? barterValue;
@override final  String? barterDescription;
@override@JsonKey() final  int creatorSlots;
 final  List<String> _categoryNames;
@override@JsonKey() List<String> get categoryNames {
  if (_categoryNames is EqualUnmodifiableListView) return _categoryNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryNames);
}

 final  List<String> _languageNames;
@override@JsonKey() List<String> get languageNames {
  if (_languageNames is EqualUnmodifiableListView) return _languageNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageNames);
}

 final  List<String> _platforms;
@override@JsonKey() List<String> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

@override@JsonKey() final  int deliverableCount;
@override final  String? targetCity;
@override final  String? targetState;
@override@JsonKey() final  String targetCountry;
@override final  DateTime? applicationDeadline;
@override final  DateTime? contentDeadline;
@override final  DateTime? publishedAt;
@override final  String? myApplicationStatus;
@override final  String? myApplicationId;

/// Create a copy of CampaignOpportunityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignOpportunityItemCopyWith<_CampaignOpportunityItem> get copyWith => __$CampaignOpportunityItemCopyWithImpl<_CampaignOpportunityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignOpportunityItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignOpportunityItem&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.compensationType, compensationType) || other.compensationType == compensationType)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.budgetMin, budgetMin) || other.budgetMin == budgetMin)&&(identical(other.budgetMax, budgetMax) || other.budgetMax == budgetMax)&&(identical(other.barterValue, barterValue) || other.barterValue == barterValue)&&(identical(other.barterDescription, barterDescription) || other.barterDescription == barterDescription)&&(identical(other.creatorSlots, creatorSlots) || other.creatorSlots == creatorSlots)&&const DeepCollectionEquality().equals(other.categoryNames, _categoryNames)&&const DeepCollectionEquality().equals(other.languageNames, _languageNames)&&const DeepCollectionEquality().equals(other.platforms, _platforms)&&(identical(other.deliverableCount, deliverableCount) || other.deliverableCount == deliverableCount)&&(identical(other.targetCity, targetCity) || other.targetCity == targetCity)&&(identical(other.targetState, targetState) || other.targetState == targetState)&&(identical(other.targetCountry, targetCountry) || other.targetCountry == targetCountry)&&(identical(other.applicationDeadline, applicationDeadline) || other.applicationDeadline == applicationDeadline)&&(identical(other.contentDeadline, contentDeadline) || other.contentDeadline == contentDeadline)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.myApplicationStatus, myApplicationStatus) || other.myApplicationStatus == myApplicationStatus)&&(identical(other.myApplicationId, myApplicationId) || other.myApplicationId == myApplicationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,campaignId,organizationId,title,brandName,brandLogoUrl,compensationType,currency,budgetMin,budgetMax,barterValue,barterDescription,creatorSlots,const DeepCollectionEquality().hash(_categoryNames),const DeepCollectionEquality().hash(_languageNames),const DeepCollectionEquality().hash(_platforms),deliverableCount,targetCity,targetState,targetCountry,applicationDeadline,contentDeadline,publishedAt,myApplicationStatus,myApplicationId]);
}

@override
String toString() {
    return 'CampaignOpportunityItem(campaignId: $campaignId, organizationId: $organizationId, title: $title, brandName: $brandName, brandLogoUrl: $brandLogoUrl, compensationType: $compensationType, currency: $currency, budgetMin: $budgetMin, budgetMax: $budgetMax, barterValue: $barterValue, barterDescription: $barterDescription, creatorSlots: $creatorSlots, categoryNames: $categoryNames, languageNames: $languageNames, platforms: $platforms, deliverableCount: $deliverableCount, targetCity: $targetCity, targetState: $targetState, targetCountry: $targetCountry, applicationDeadline: $applicationDeadline, contentDeadline: $contentDeadline, publishedAt: $publishedAt, myApplicationStatus: $myApplicationStatus, myApplicationId: $myApplicationId)';
}


}

/// @nodoc
abstract mixin class _$CampaignOpportunityItemCopyWith<$Res> implements $CampaignOpportunityItemCopyWith<$Res> {
  factory _$CampaignOpportunityItemCopyWith(_CampaignOpportunityItem value, $Res Function(_CampaignOpportunityItem) _then) = __$CampaignOpportunityItemCopyWithImpl;
@override @useResult
$Res call({
 String campaignId, String organizationId, String title, String brandName, String? brandLogoUrl, CampaignCompensationType compensationType, String currency, double? budgetMin, double? budgetMax, double? barterValue, String? barterDescription, int creatorSlots, List<String> categoryNames, List<String> languageNames, List<String> platforms, int deliverableCount, String? targetCity, String? targetState, String targetCountry, DateTime? applicationDeadline, DateTime? contentDeadline, DateTime? publishedAt, String? myApplicationStatus, String? myApplicationId
});




}
/// @nodoc
class __$CampaignOpportunityItemCopyWithImpl<$Res>
    implements _$CampaignOpportunityItemCopyWith<$Res> {
  __$CampaignOpportunityItemCopyWithImpl(this._self, this._then);

  final _CampaignOpportunityItem _self;
  final $Res Function(_CampaignOpportunityItem) _then;

/// Create a copy of CampaignOpportunityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? campaignId = null,Object? organizationId = null,Object? title = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? compensationType = null,Object? currency = null,Object? budgetMin = freezed,Object? budgetMax = freezed,Object? barterValue = freezed,Object? barterDescription = freezed,Object? creatorSlots = null,Object? categoryNames = null,Object? languageNames = null,Object? platforms = null,Object? deliverableCount = null,Object? targetCity = freezed,Object? targetState = freezed,Object? targetCountry = null,Object? applicationDeadline = freezed,Object? contentDeadline = freezed,Object? publishedAt = freezed,Object? myApplicationStatus = freezed,Object? myApplicationId = freezed,}) {
  return _then(_CampaignOpportunityItem(
campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,compensationType: null == compensationType ? _self.compensationType : compensationType // ignore: cast_nullable_to_non_nullable
as CampaignCompensationType,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budgetMin: freezed == budgetMin ? _self.budgetMin : budgetMin // ignore: cast_nullable_to_non_nullable
as double?,budgetMax: freezed == budgetMax ? _self.budgetMax : budgetMax // ignore: cast_nullable_to_non_nullable
as double?,barterValue: freezed == barterValue ? _self.barterValue : barterValue // ignore: cast_nullable_to_non_nullable
as double?,barterDescription: freezed == barterDescription ? _self.barterDescription : barterDescription // ignore: cast_nullable_to_non_nullable
as String?,creatorSlots: null == creatorSlots ? _self.creatorSlots : creatorSlots // ignore: cast_nullable_to_non_nullable
as int,categoryNames: null == categoryNames ? _self._categoryNames : categoryNames // ignore: cast_nullable_to_non_nullable
as List<String>,languageNames: null == languageNames ? _self._languageNames : languageNames // ignore: cast_nullable_to_non_nullable
as List<String>,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,deliverableCount: null == deliverableCount ? _self.deliverableCount : deliverableCount // ignore: cast_nullable_to_non_nullable
as int,targetCity: freezed == targetCity ? _self.targetCity : targetCity // ignore: cast_nullable_to_non_nullable
as String?,targetState: freezed == targetState ? _self.targetState : targetState // ignore: cast_nullable_to_non_nullable
as String?,targetCountry: null == targetCountry ? _self.targetCountry : targetCountry // ignore: cast_nullable_to_non_nullable
as String,applicationDeadline: freezed == applicationDeadline ? _self.applicationDeadline : applicationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,contentDeadline: freezed == contentDeadline ? _self.contentDeadline : contentDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,myApplicationStatus: freezed == myApplicationStatus ? _self.myApplicationStatus : myApplicationStatus // ignore: cast_nullable_to_non_nullable
as String?,myApplicationId: freezed == myApplicationId ? _self.myApplicationId : myApplicationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CampaignSearchFilters {

 String get query; List<String> get categoryIds; List<String> get languageCodes; List<String> get platforms; CampaignCompensationType? get compensationType; double? get minBudget; double? get maxBudget; String? get city; String? get state; String? get country; bool? get onlyAvailableSlots;
/// Create a copy of CampaignSearchFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignSearchFiltersCopyWith<CampaignSearchFilters> get copyWith => _$CampaignSearchFiltersCopyWithImpl<CampaignSearchFilters>(this as CampaignSearchFilters, _$identity);

  /// Serializes this CampaignSearchFilters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CampaignSearchFilters;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignSearchFilters&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.categoryIds, _this.categoryIds)&&const DeepCollectionEquality().equals(other.languageCodes, _this.languageCodes)&&const DeepCollectionEquality().equals(other.platforms, _this.platforms)&&(identical(other.compensationType, _this.compensationType) || other.compensationType == _this.compensationType)&&(identical(other.minBudget, _this.minBudget) || other.minBudget == _this.minBudget)&&(identical(other.maxBudget, _this.maxBudget) || other.maxBudget == _this.maxBudget)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.onlyAvailableSlots, _this.onlyAvailableSlots) || other.onlyAvailableSlots == _this.onlyAvailableSlots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CampaignSearchFilters;
  return Object.hash(runtimeType,_this.query,const DeepCollectionEquality().hash(_this.categoryIds),const DeepCollectionEquality().hash(_this.languageCodes),const DeepCollectionEquality().hash(_this.platforms),_this.compensationType,_this.minBudget,_this.maxBudget,_this.city,_this.state,_this.country,_this.onlyAvailableSlots);
}

@override
String toString() {
  final _this = this as CampaignSearchFilters;
  return 'CampaignSearchFilters(query: ${_this.query}, categoryIds: ${_this.categoryIds}, languageCodes: ${_this.languageCodes}, platforms: ${_this.platforms}, compensationType: ${_this.compensationType}, minBudget: ${_this.minBudget}, maxBudget: ${_this.maxBudget}, city: ${_this.city}, state: ${_this.state}, country: ${_this.country}, onlyAvailableSlots: ${_this.onlyAvailableSlots})';
}


}

/// @nodoc
abstract mixin class $CampaignSearchFiltersCopyWith<$Res>  {
  factory $CampaignSearchFiltersCopyWith(CampaignSearchFilters value, $Res Function(CampaignSearchFilters) _then) = _$CampaignSearchFiltersCopyWithImpl;
@useResult
$Res call({
 String query, List<String> categoryIds, List<String> languageCodes, List<String> platforms, CampaignCompensationType? compensationType, double? minBudget, double? maxBudget, String? city, String? state, String? country, bool? onlyAvailableSlots
});




}
/// @nodoc
class _$CampaignSearchFiltersCopyWithImpl<$Res>
    implements $CampaignSearchFiltersCopyWith<$Res> {
  _$CampaignSearchFiltersCopyWithImpl(this._self, this._then);

  final CampaignSearchFilters _self;
  final $Res Function(CampaignSearchFilters) _then;

/// Create a copy of CampaignSearchFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? categoryIds = null,Object? languageCodes = null,Object? platforms = null,Object? compensationType = freezed,Object? minBudget = freezed,Object? maxBudget = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? onlyAvailableSlots = freezed,}) {
  return _then(CampaignSearchFilters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,compensationType: freezed == compensationType ? _self.compensationType : compensationType // ignore: cast_nullable_to_non_nullable
as CampaignCompensationType?,minBudget: freezed == minBudget ? _self.minBudget : minBudget // ignore: cast_nullable_to_non_nullable
as double?,maxBudget: freezed == maxBudget ? _self.maxBudget : maxBudget // ignore: cast_nullable_to_non_nullable
as double?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,onlyAvailableSlots: freezed == onlyAvailableSlots ? _self.onlyAvailableSlots : onlyAvailableSlots // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignSearchFilters].
extension CampaignSearchFiltersPatterns on CampaignSearchFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignSearchFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignSearchFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignSearchFilters value)  $default,){
final _that = this;
switch (_that) {
case _CampaignSearchFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignSearchFilters value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignSearchFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<String> categoryIds,  List<String> languageCodes,  List<String> platforms,  CampaignCompensationType? compensationType,  double? minBudget,  double? maxBudget,  String? city,  String? state,  String? country,  bool? onlyAvailableSlots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignSearchFilters() when $default != null:
return $default(_that.query,_that.categoryIds,_that.languageCodes,_that.platforms,_that.compensationType,_that.minBudget,_that.maxBudget,_that.city,_that.state,_that.country,_that.onlyAvailableSlots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<String> categoryIds,  List<String> languageCodes,  List<String> platforms,  CampaignCompensationType? compensationType,  double? minBudget,  double? maxBudget,  String? city,  String? state,  String? country,  bool? onlyAvailableSlots)  $default,) {final _that = this;
switch (_that) {
case _CampaignSearchFilters():
return $default(_that.query,_that.categoryIds,_that.languageCodes,_that.platforms,_that.compensationType,_that.minBudget,_that.maxBudget,_that.city,_that.state,_that.country,_that.onlyAvailableSlots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<String> categoryIds,  List<String> languageCodes,  List<String> platforms,  CampaignCompensationType? compensationType,  double? minBudget,  double? maxBudget,  String? city,  String? state,  String? country,  bool? onlyAvailableSlots)?  $default,) {final _that = this;
switch (_that) {
case _CampaignSearchFilters() when $default != null:
return $default(_that.query,_that.categoryIds,_that.languageCodes,_that.platforms,_that.compensationType,_that.minBudget,_that.maxBudget,_that.city,_that.state,_that.country,_that.onlyAvailableSlots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignSearchFilters implements CampaignSearchFilters {
  const _CampaignSearchFilters({this.query = '',  List<String> categoryIds = const [],  List<String> languageCodes = const [],  List<String> platforms = const [], this.compensationType, this.minBudget, this.maxBudget, this.city, this.state, this.country, this.onlyAvailableSlots}): _categoryIds = categoryIds,_languageCodes = languageCodes,_platforms = platforms;
  factory _CampaignSearchFilters.fromJson(Map<String, dynamic> json) => _$CampaignSearchFiltersFromJson(json);

@override@JsonKey() final  String query;
 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

 final  List<String> _languageCodes;
@override@JsonKey() List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

 final  List<String> _platforms;
@override@JsonKey() List<String> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

@override final  CampaignCompensationType? compensationType;
@override final  double? minBudget;
@override final  double? maxBudget;
@override final  String? city;
@override final  String? state;
@override final  String? country;
@override final  bool? onlyAvailableSlots;

/// Create a copy of CampaignSearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignSearchFiltersCopyWith<_CampaignSearchFilters> get copyWith => __$CampaignSearchFiltersCopyWithImpl<_CampaignSearchFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignSearchFiltersToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignSearchFilters&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.categoryIds, _categoryIds)&&const DeepCollectionEquality().equals(other.languageCodes, _languageCodes)&&const DeepCollectionEquality().equals(other.platforms, _platforms)&&(identical(other.compensationType, compensationType) || other.compensationType == compensationType)&&(identical(other.minBudget, minBudget) || other.minBudget == minBudget)&&(identical(other.maxBudget, maxBudget) || other.maxBudget == maxBudget)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.onlyAvailableSlots, onlyAvailableSlots) || other.onlyAvailableSlots == onlyAvailableSlots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_categoryIds),const DeepCollectionEquality().hash(_languageCodes),const DeepCollectionEquality().hash(_platforms),compensationType,minBudget,maxBudget,city,state,country,onlyAvailableSlots);
}

@override
String toString() {
    return 'CampaignSearchFilters(query: $query, categoryIds: $categoryIds, languageCodes: $languageCodes, platforms: $platforms, compensationType: $compensationType, minBudget: $minBudget, maxBudget: $maxBudget, city: $city, state: $state, country: $country, onlyAvailableSlots: $onlyAvailableSlots)';
}


}

/// @nodoc
abstract mixin class _$CampaignSearchFiltersCopyWith<$Res> implements $CampaignSearchFiltersCopyWith<$Res> {
  factory _$CampaignSearchFiltersCopyWith(_CampaignSearchFilters value, $Res Function(_CampaignSearchFilters) _then) = __$CampaignSearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 String query, List<String> categoryIds, List<String> languageCodes, List<String> platforms, CampaignCompensationType? compensationType, double? minBudget, double? maxBudget, String? city, String? state, String? country, bool? onlyAvailableSlots
});




}
/// @nodoc
class __$CampaignSearchFiltersCopyWithImpl<$Res>
    implements _$CampaignSearchFiltersCopyWith<$Res> {
  __$CampaignSearchFiltersCopyWithImpl(this._self, this._then);

  final _CampaignSearchFilters _self;
  final $Res Function(_CampaignSearchFilters) _then;

/// Create a copy of CampaignSearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? categoryIds = null,Object? languageCodes = null,Object? platforms = null,Object? compensationType = freezed,Object? minBudget = freezed,Object? maxBudget = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? onlyAvailableSlots = freezed,}) {
  return _then(_CampaignSearchFilters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,compensationType: freezed == compensationType ? _self.compensationType : compensationType // ignore: cast_nullable_to_non_nullable
as CampaignCompensationType?,minBudget: freezed == minBudget ? _self.minBudget : minBudget // ignore: cast_nullable_to_non_nullable
as double?,maxBudget: freezed == maxBudget ? _self.maxBudget : maxBudget // ignore: cast_nullable_to_non_nullable
as double?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,onlyAvailableSlots: freezed == onlyAvailableSlots ? _self.onlyAvailableSlots : onlyAvailableSlots // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
