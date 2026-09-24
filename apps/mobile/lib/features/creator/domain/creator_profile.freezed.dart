// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creator_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatorAvailability {

 AvailabilityStatus get status; DateTime? get availableFrom;
/// Create a copy of CreatorAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatorAvailabilityCopyWith<CreatorAvailability> get copyWith => _$CreatorAvailabilityCopyWithImpl<CreatorAvailability>(this as CreatorAvailability, _$identity);

  /// Serializes this CreatorAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreatorAvailability;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatorAvailability&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.availableFrom, _this.availableFrom) || other.availableFrom == _this.availableFrom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreatorAvailability;
  return Object.hash(runtimeType,_this.status,_this.availableFrom);
}

@override
String toString() {
  final _this = this as CreatorAvailability;
  return 'CreatorAvailability(status: ${_this.status}, availableFrom: ${_this.availableFrom})';
}


}

/// @nodoc
abstract mixin class $CreatorAvailabilityCopyWith<$Res>  {
  factory $CreatorAvailabilityCopyWith(CreatorAvailability value, $Res Function(CreatorAvailability) _then) = _$CreatorAvailabilityCopyWithImpl;
@useResult
$Res call({
 AvailabilityStatus status, DateTime? availableFrom
});




}
/// @nodoc
class _$CreatorAvailabilityCopyWithImpl<$Res>
    implements $CreatorAvailabilityCopyWith<$Res> {
  _$CreatorAvailabilityCopyWithImpl(this._self, this._then);

  final CreatorAvailability _self;
  final $Res Function(CreatorAvailability) _then;

/// Create a copy of CreatorAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? availableFrom = freezed,}) {
  return _then(CreatorAvailability(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AvailabilityStatus,availableFrom: freezed == availableFrom ? _self.availableFrom : availableFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatorAvailability].
extension CreatorAvailabilityPatterns on CreatorAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatorAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatorAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatorAvailability value)  $default,){
final _that = this;
switch (_that) {
case _CreatorAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatorAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _CreatorAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AvailabilityStatus status,  DateTime? availableFrom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatorAvailability() when $default != null:
return $default(_that.status,_that.availableFrom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AvailabilityStatus status,  DateTime? availableFrom)  $default,) {final _that = this;
switch (_that) {
case _CreatorAvailability():
return $default(_that.status,_that.availableFrom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AvailabilityStatus status,  DateTime? availableFrom)?  $default,) {final _that = this;
switch (_that) {
case _CreatorAvailability() when $default != null:
return $default(_that.status,_that.availableFrom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatorAvailability implements CreatorAvailability {
  const _CreatorAvailability({this.status = AvailabilityStatus.open, this.availableFrom});
  factory _CreatorAvailability.fromJson(Map<String, dynamic> json) => _$CreatorAvailabilityFromJson(json);

@override@JsonKey() final  AvailabilityStatus status;
@override final  DateTime? availableFrom;

/// Create a copy of CreatorAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatorAvailabilityCopyWith<_CreatorAvailability> get copyWith => __$CreatorAvailabilityCopyWithImpl<_CreatorAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatorAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatorAvailability&&(identical(other.status, status) || other.status == status)&&(identical(other.availableFrom, availableFrom) || other.availableFrom == availableFrom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,availableFrom);
}

@override
String toString() {
    return 'CreatorAvailability(status: $status, availableFrom: $availableFrom)';
}


}

/// @nodoc
abstract mixin class _$CreatorAvailabilityCopyWith<$Res> implements $CreatorAvailabilityCopyWith<$Res> {
  factory _$CreatorAvailabilityCopyWith(_CreatorAvailability value, $Res Function(_CreatorAvailability) _then) = __$CreatorAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 AvailabilityStatus status, DateTime? availableFrom
});




}
/// @nodoc
class __$CreatorAvailabilityCopyWithImpl<$Res>
    implements _$CreatorAvailabilityCopyWith<$Res> {
  __$CreatorAvailabilityCopyWithImpl(this._self, this._then);

  final _CreatorAvailability _self;
  final $Res Function(_CreatorAvailability) _then;

/// Create a copy of CreatorAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? availableFrom = freezed,}) {
  return _then(_CreatorAvailability(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AvailabilityStatus,availableFrom: freezed == availableFrom ? _self.availableFrom : availableFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreatorProfile {

 String get userId; String get displayName; String? get professionalName; String? get avatarPath; String? get bio; LocationData get location; CreatorAvailability get availability; bool get isRepresented; int get onboardingStep; bool get onboardingCompleted; List<Category> get primaryCategories; List<Category> get additionalCategories; List<Language> get languages; List<SocialAccount> get socialAccounts; List<RateItem> get rateCard; List<PortfolioItem> get portfolio; List<PastCollaboration> get pastCollaborations; List<CreatorManagerRelationship> get managerRelationships; VerificationSummary get verificationSummary; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatorProfileCopyWith<CreatorProfile> get copyWith => _$CreatorProfileCopyWithImpl<CreatorProfile>(this as CreatorProfile, _$identity);

  /// Serializes this CreatorProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreatorProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatorProfile&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.professionalName, _this.professionalName) || other.professionalName == _this.professionalName)&&(identical(other.avatarPath, _this.avatarPath) || other.avatarPath == _this.avatarPath)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.availability, _this.availability) || other.availability == _this.availability)&&(identical(other.isRepresented, _this.isRepresented) || other.isRepresented == _this.isRepresented)&&(identical(other.onboardingStep, _this.onboardingStep) || other.onboardingStep == _this.onboardingStep)&&(identical(other.onboardingCompleted, _this.onboardingCompleted) || other.onboardingCompleted == _this.onboardingCompleted)&&const DeepCollectionEquality().equals(other.primaryCategories, _this.primaryCategories)&&const DeepCollectionEquality().equals(other.additionalCategories, _this.additionalCategories)&&const DeepCollectionEquality().equals(other.languages, _this.languages)&&const DeepCollectionEquality().equals(other.socialAccounts, _this.socialAccounts)&&const DeepCollectionEquality().equals(other.rateCard, _this.rateCard)&&const DeepCollectionEquality().equals(other.portfolio, _this.portfolio)&&const DeepCollectionEquality().equals(other.pastCollaborations, _this.pastCollaborations)&&const DeepCollectionEquality().equals(other.managerRelationships, _this.managerRelationships)&&(identical(other.verificationSummary, _this.verificationSummary) || other.verificationSummary == _this.verificationSummary)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreatorProfile;
  return Object.hashAll([runtimeType,_this.userId,_this.displayName,_this.professionalName,_this.avatarPath,_this.bio,_this.location,_this.availability,_this.isRepresented,_this.onboardingStep,_this.onboardingCompleted,const DeepCollectionEquality().hash(_this.primaryCategories),const DeepCollectionEquality().hash(_this.additionalCategories),const DeepCollectionEquality().hash(_this.languages),const DeepCollectionEquality().hash(_this.socialAccounts),const DeepCollectionEquality().hash(_this.rateCard),const DeepCollectionEquality().hash(_this.portfolio),const DeepCollectionEquality().hash(_this.pastCollaborations),const DeepCollectionEquality().hash(_this.managerRelationships),_this.verificationSummary,_this.createdAt,_this.updatedAt]);
}

@override
String toString() {
  final _this = this as CreatorProfile;
  return 'CreatorProfile(userId: ${_this.userId}, displayName: ${_this.displayName}, professionalName: ${_this.professionalName}, avatarPath: ${_this.avatarPath}, bio: ${_this.bio}, location: ${_this.location}, availability: ${_this.availability}, isRepresented: ${_this.isRepresented}, onboardingStep: ${_this.onboardingStep}, onboardingCompleted: ${_this.onboardingCompleted}, primaryCategories: ${_this.primaryCategories}, additionalCategories: ${_this.additionalCategories}, languages: ${_this.languages}, socialAccounts: ${_this.socialAccounts}, rateCard: ${_this.rateCard}, portfolio: ${_this.portfolio}, pastCollaborations: ${_this.pastCollaborations}, managerRelationships: ${_this.managerRelationships}, verificationSummary: ${_this.verificationSummary}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $CreatorProfileCopyWith<$Res>  {
  factory $CreatorProfileCopyWith(CreatorProfile value, $Res Function(CreatorProfile) _then) = _$CreatorProfileCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? professionalName, String? avatarPath, String? bio, LocationData location, CreatorAvailability availability, bool isRepresented, int onboardingStep, bool onboardingCompleted, List<Category> primaryCategories, List<Category> additionalCategories, List<Language> languages, List<SocialAccount> socialAccounts, List<RateItem> rateCard, List<PortfolioItem> portfolio, List<PastCollaboration> pastCollaborations, List<CreatorManagerRelationship> managerRelationships, VerificationSummary verificationSummary, DateTime? createdAt, DateTime? updatedAt
});


$LocationDataCopyWith<$Res> get location;$CreatorAvailabilityCopyWith<$Res> get availability;$VerificationSummaryCopyWith<$Res> get verificationSummary;

}
/// @nodoc
class _$CreatorProfileCopyWithImpl<$Res>
    implements $CreatorProfileCopyWith<$Res> {
  _$CreatorProfileCopyWithImpl(this._self, this._then);

  final CreatorProfile _self;
  final $Res Function(CreatorProfile) _then;

/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? professionalName = freezed,Object? avatarPath = freezed,Object? bio = freezed,Object? location = null,Object? availability = null,Object? isRepresented = null,Object? onboardingStep = null,Object? onboardingCompleted = null,Object? primaryCategories = null,Object? additionalCategories = null,Object? languages = null,Object? socialAccounts = null,Object? rateCard = null,Object? portfolio = null,Object? pastCollaborations = null,Object? managerRelationships = null,Object? verificationSummary = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(CreatorProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,professionalName: freezed == professionalName ? _self.professionalName : professionalName // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as CreatorAvailability,isRepresented: null == isRepresented ? _self.isRepresented : isRepresented // ignore: cast_nullable_to_non_nullable
as bool,onboardingStep: null == onboardingStep ? _self.onboardingStep : onboardingStep // ignore: cast_nullable_to_non_nullable
as int,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,primaryCategories: null == primaryCategories ? _self.primaryCategories : primaryCategories // ignore: cast_nullable_to_non_nullable
as List<Category>,additionalCategories: null == additionalCategories ? _self.additionalCategories : additionalCategories // ignore: cast_nullable_to_non_nullable
as List<Category>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>,socialAccounts: null == socialAccounts ? _self.socialAccounts : socialAccounts // ignore: cast_nullable_to_non_nullable
as List<SocialAccount>,rateCard: null == rateCard ? _self.rateCard : rateCard // ignore: cast_nullable_to_non_nullable
as List<RateItem>,portfolio: null == portfolio ? _self.portfolio : portfolio // ignore: cast_nullable_to_non_nullable
as List<PortfolioItem>,pastCollaborations: null == pastCollaborations ? _self.pastCollaborations : pastCollaborations // ignore: cast_nullable_to_non_nullable
as List<PastCollaboration>,managerRelationships: null == managerRelationships ? _self.managerRelationships : managerRelationships // ignore: cast_nullable_to_non_nullable
as List<CreatorManagerRelationship>,verificationSummary: null == verificationSummary ? _self.verificationSummary : verificationSummary // ignore: cast_nullable_to_non_nullable
as VerificationSummary,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res> get location {
  
  return $LocationDataCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatorAvailabilityCopyWith<$Res> get availability {
  
  return $CreatorAvailabilityCopyWith<$Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationSummaryCopyWith<$Res> get verificationSummary {
  
  return $VerificationSummaryCopyWith<$Res>(_self.verificationSummary, (value) {
    return _then(_self.copyWith(verificationSummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatorProfile].
extension CreatorProfilePatterns on CreatorProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatorProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatorProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatorProfile value)  $default,){
final _that = this;
switch (_that) {
case _CreatorProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatorProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CreatorProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? professionalName,  String? avatarPath,  String? bio,  LocationData location,  CreatorAvailability availability,  bool isRepresented,  int onboardingStep,  bool onboardingCompleted,  List<Category> primaryCategories,  List<Category> additionalCategories,  List<Language> languages,  List<SocialAccount> socialAccounts,  List<RateItem> rateCard,  List<PortfolioItem> portfolio,  List<PastCollaboration> pastCollaborations,  List<CreatorManagerRelationship> managerRelationships,  VerificationSummary verificationSummary,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatorProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.professionalName,_that.avatarPath,_that.bio,_that.location,_that.availability,_that.isRepresented,_that.onboardingStep,_that.onboardingCompleted,_that.primaryCategories,_that.additionalCategories,_that.languages,_that.socialAccounts,_that.rateCard,_that.portfolio,_that.pastCollaborations,_that.managerRelationships,_that.verificationSummary,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? professionalName,  String? avatarPath,  String? bio,  LocationData location,  CreatorAvailability availability,  bool isRepresented,  int onboardingStep,  bool onboardingCompleted,  List<Category> primaryCategories,  List<Category> additionalCategories,  List<Language> languages,  List<SocialAccount> socialAccounts,  List<RateItem> rateCard,  List<PortfolioItem> portfolio,  List<PastCollaboration> pastCollaborations,  List<CreatorManagerRelationship> managerRelationships,  VerificationSummary verificationSummary,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CreatorProfile():
return $default(_that.userId,_that.displayName,_that.professionalName,_that.avatarPath,_that.bio,_that.location,_that.availability,_that.isRepresented,_that.onboardingStep,_that.onboardingCompleted,_that.primaryCategories,_that.additionalCategories,_that.languages,_that.socialAccounts,_that.rateCard,_that.portfolio,_that.pastCollaborations,_that.managerRelationships,_that.verificationSummary,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? professionalName,  String? avatarPath,  String? bio,  LocationData location,  CreatorAvailability availability,  bool isRepresented,  int onboardingStep,  bool onboardingCompleted,  List<Category> primaryCategories,  List<Category> additionalCategories,  List<Language> languages,  List<SocialAccount> socialAccounts,  List<RateItem> rateCard,  List<PortfolioItem> portfolio,  List<PastCollaboration> pastCollaborations,  List<CreatorManagerRelationship> managerRelationships,  VerificationSummary verificationSummary,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CreatorProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.professionalName,_that.avatarPath,_that.bio,_that.location,_that.availability,_that.isRepresented,_that.onboardingStep,_that.onboardingCompleted,_that.primaryCategories,_that.additionalCategories,_that.languages,_that.socialAccounts,_that.rateCard,_that.portfolio,_that.pastCollaborations,_that.managerRelationships,_that.verificationSummary,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatorProfile implements CreatorProfile {
  const _CreatorProfile({required this.userId, required this.displayName, this.professionalName, this.avatarPath, this.bio, this.location = const LocationData(), this.availability = const CreatorAvailability(), this.isRepresented = false, this.onboardingStep = 1, this.onboardingCompleted = false,  List<Category> primaryCategories = const [],  List<Category> additionalCategories = const [],  List<Language> languages = const [],  List<SocialAccount> socialAccounts = const [],  List<RateItem> rateCard = const [],  List<PortfolioItem> portfolio = const [],  List<PastCollaboration> pastCollaborations = const [],  List<CreatorManagerRelationship> managerRelationships = const [], this.verificationSummary = const VerificationSummary(), this.createdAt, this.updatedAt}): _primaryCategories = primaryCategories,_additionalCategories = additionalCategories,_languages = languages,_socialAccounts = socialAccounts,_rateCard = rateCard,_portfolio = portfolio,_pastCollaborations = pastCollaborations,_managerRelationships = managerRelationships;
  factory _CreatorProfile.fromJson(Map<String, dynamic> json) => _$CreatorProfileFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? professionalName;
@override final  String? avatarPath;
@override final  String? bio;
@override@JsonKey() final  LocationData location;
@override@JsonKey() final  CreatorAvailability availability;
@override@JsonKey() final  bool isRepresented;
@override@JsonKey() final  int onboardingStep;
@override@JsonKey() final  bool onboardingCompleted;
 final  List<Category> _primaryCategories;
@override@JsonKey() List<Category> get primaryCategories {
  if (_primaryCategories is EqualUnmodifiableListView) return _primaryCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryCategories);
}

 final  List<Category> _additionalCategories;
@override@JsonKey() List<Category> get additionalCategories {
  if (_additionalCategories is EqualUnmodifiableListView) return _additionalCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_additionalCategories);
}

 final  List<Language> _languages;
@override@JsonKey() List<Language> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

 final  List<SocialAccount> _socialAccounts;
@override@JsonKey() List<SocialAccount> get socialAccounts {
  if (_socialAccounts is EqualUnmodifiableListView) return _socialAccounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_socialAccounts);
}

 final  List<RateItem> _rateCard;
@override@JsonKey() List<RateItem> get rateCard {
  if (_rateCard is EqualUnmodifiableListView) return _rateCard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rateCard);
}

 final  List<PortfolioItem> _portfolio;
@override@JsonKey() List<PortfolioItem> get portfolio {
  if (_portfolio is EqualUnmodifiableListView) return _portfolio;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_portfolio);
}

 final  List<PastCollaboration> _pastCollaborations;
@override@JsonKey() List<PastCollaboration> get pastCollaborations {
  if (_pastCollaborations is EqualUnmodifiableListView) return _pastCollaborations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pastCollaborations);
}

 final  List<CreatorManagerRelationship> _managerRelationships;
@override@JsonKey() List<CreatorManagerRelationship> get managerRelationships {
  if (_managerRelationships is EqualUnmodifiableListView) return _managerRelationships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_managerRelationships);
}

@override@JsonKey() final  VerificationSummary verificationSummary;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatorProfileCopyWith<_CreatorProfile> get copyWith => __$CreatorProfileCopyWithImpl<_CreatorProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatorProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatorProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.professionalName, professionalName) || other.professionalName == professionalName)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.location, location) || other.location == location)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.isRepresented, isRepresented) || other.isRepresented == isRepresented)&&(identical(other.onboardingStep, onboardingStep) || other.onboardingStep == onboardingStep)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted)&&const DeepCollectionEquality().equals(other.primaryCategories, _primaryCategories)&&const DeepCollectionEquality().equals(other.additionalCategories, _additionalCategories)&&const DeepCollectionEquality().equals(other.languages, _languages)&&const DeepCollectionEquality().equals(other.socialAccounts, _socialAccounts)&&const DeepCollectionEquality().equals(other.rateCard, _rateCard)&&const DeepCollectionEquality().equals(other.portfolio, _portfolio)&&const DeepCollectionEquality().equals(other.pastCollaborations, _pastCollaborations)&&const DeepCollectionEquality().equals(other.managerRelationships, _managerRelationships)&&(identical(other.verificationSummary, verificationSummary) || other.verificationSummary == verificationSummary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,userId,displayName,professionalName,avatarPath,bio,location,availability,isRepresented,onboardingStep,onboardingCompleted,const DeepCollectionEquality().hash(_primaryCategories),const DeepCollectionEquality().hash(_additionalCategories),const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_socialAccounts),const DeepCollectionEquality().hash(_rateCard),const DeepCollectionEquality().hash(_portfolio),const DeepCollectionEquality().hash(_pastCollaborations),const DeepCollectionEquality().hash(_managerRelationships),verificationSummary,createdAt,updatedAt]);
}

@override
String toString() {
    return 'CreatorProfile(userId: $userId, displayName: $displayName, professionalName: $professionalName, avatarPath: $avatarPath, bio: $bio, location: $location, availability: $availability, isRepresented: $isRepresented, onboardingStep: $onboardingStep, onboardingCompleted: $onboardingCompleted, primaryCategories: $primaryCategories, additionalCategories: $additionalCategories, languages: $languages, socialAccounts: $socialAccounts, rateCard: $rateCard, portfolio: $portfolio, pastCollaborations: $pastCollaborations, managerRelationships: $managerRelationships, verificationSummary: $verificationSummary, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CreatorProfileCopyWith<$Res> implements $CreatorProfileCopyWith<$Res> {
  factory _$CreatorProfileCopyWith(_CreatorProfile value, $Res Function(_CreatorProfile) _then) = __$CreatorProfileCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? professionalName, String? avatarPath, String? bio, LocationData location, CreatorAvailability availability, bool isRepresented, int onboardingStep, bool onboardingCompleted, List<Category> primaryCategories, List<Category> additionalCategories, List<Language> languages, List<SocialAccount> socialAccounts, List<RateItem> rateCard, List<PortfolioItem> portfolio, List<PastCollaboration> pastCollaborations, List<CreatorManagerRelationship> managerRelationships, VerificationSummary verificationSummary, DateTime? createdAt, DateTime? updatedAt
});


@override $LocationDataCopyWith<$Res> get location;@override $CreatorAvailabilityCopyWith<$Res> get availability;@override $VerificationSummaryCopyWith<$Res> get verificationSummary;

}
/// @nodoc
class __$CreatorProfileCopyWithImpl<$Res>
    implements _$CreatorProfileCopyWith<$Res> {
  __$CreatorProfileCopyWithImpl(this._self, this._then);

  final _CreatorProfile _self;
  final $Res Function(_CreatorProfile) _then;

/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? professionalName = freezed,Object? avatarPath = freezed,Object? bio = freezed,Object? location = null,Object? availability = null,Object? isRepresented = null,Object? onboardingStep = null,Object? onboardingCompleted = null,Object? primaryCategories = null,Object? additionalCategories = null,Object? languages = null,Object? socialAccounts = null,Object? rateCard = null,Object? portfolio = null,Object? pastCollaborations = null,Object? managerRelationships = null,Object? verificationSummary = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CreatorProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,professionalName: freezed == professionalName ? _self.professionalName : professionalName // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as CreatorAvailability,isRepresented: null == isRepresented ? _self.isRepresented : isRepresented // ignore: cast_nullable_to_non_nullable
as bool,onboardingStep: null == onboardingStep ? _self.onboardingStep : onboardingStep // ignore: cast_nullable_to_non_nullable
as int,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,primaryCategories: null == primaryCategories ? _self._primaryCategories : primaryCategories // ignore: cast_nullable_to_non_nullable
as List<Category>,additionalCategories: null == additionalCategories ? _self._additionalCategories : additionalCategories // ignore: cast_nullable_to_non_nullable
as List<Category>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>,socialAccounts: null == socialAccounts ? _self._socialAccounts : socialAccounts // ignore: cast_nullable_to_non_nullable
as List<SocialAccount>,rateCard: null == rateCard ? _self._rateCard : rateCard // ignore: cast_nullable_to_non_nullable
as List<RateItem>,portfolio: null == portfolio ? _self._portfolio : portfolio // ignore: cast_nullable_to_non_nullable
as List<PortfolioItem>,pastCollaborations: null == pastCollaborations ? _self._pastCollaborations : pastCollaborations // ignore: cast_nullable_to_non_nullable
as List<PastCollaboration>,managerRelationships: null == managerRelationships ? _self._managerRelationships : managerRelationships // ignore: cast_nullable_to_non_nullable
as List<CreatorManagerRelationship>,verificationSummary: null == verificationSummary ? _self.verificationSummary : verificationSummary // ignore: cast_nullable_to_non_nullable
as VerificationSummary,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res> get location {
  
  return $LocationDataCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of CreatorProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatorAvailabilityCopyWith<$Res> get availability {
  
  return $CreatorAvailabilityCopyWith<$Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of CreatorProfile
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
