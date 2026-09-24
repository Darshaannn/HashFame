// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompanyBrand {

 String get id; String get organizationId; String get name; String? get logoPath; String? get industry; String? get website; String? get description; String? get headquarters; String get status; DateTime? get createdAt;
/// Create a copy of CompanyBrand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyBrandCopyWith<CompanyBrand> get copyWith => _$CompanyBrandCopyWithImpl<CompanyBrand>(this as CompanyBrand, _$identity);

  /// Serializes this CompanyBrand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CompanyBrand;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyBrand&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.logoPath, _this.logoPath) || other.logoPath == _this.logoPath)&&(identical(other.industry, _this.industry) || other.industry == _this.industry)&&(identical(other.website, _this.website) || other.website == _this.website)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.headquarters, _this.headquarters) || other.headquarters == _this.headquarters)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CompanyBrand;
  return Object.hash(runtimeType,_this.id,_this.organizationId,_this.name,_this.logoPath,_this.industry,_this.website,_this.description,_this.headquarters,_this.status,_this.createdAt);
}

@override
String toString() {
  final _this = this as CompanyBrand;
  return 'CompanyBrand(id: ${_this.id}, organizationId: ${_this.organizationId}, name: ${_this.name}, logoPath: ${_this.logoPath}, industry: ${_this.industry}, website: ${_this.website}, description: ${_this.description}, headquarters: ${_this.headquarters}, status: ${_this.status}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CompanyBrandCopyWith<$Res>  {
  factory $CompanyBrandCopyWith(CompanyBrand value, $Res Function(CompanyBrand) _then) = _$CompanyBrandCopyWithImpl;
@useResult
$Res call({
 String id, String organizationId, String name, String? logoPath, String? industry, String? website, String? description, String? headquarters, String status, DateTime? createdAt
});




}
/// @nodoc
class _$CompanyBrandCopyWithImpl<$Res>
    implements $CompanyBrandCopyWith<$Res> {
  _$CompanyBrandCopyWithImpl(this._self, this._then);

  final CompanyBrand _self;
  final $Res Function(CompanyBrand) _then;

/// Create a copy of CompanyBrand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organizationId = null,Object? name = null,Object? logoPath = freezed,Object? industry = freezed,Object? website = freezed,Object? description = freezed,Object? headquarters = freezed,Object? status = null,Object? createdAt = freezed,}) {
  return _then(CompanyBrand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,headquarters: freezed == headquarters ? _self.headquarters : headquarters // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyBrand].
extension CompanyBrandPatterns on CompanyBrand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyBrand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyBrand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyBrand value)  $default,){
final _that = this;
switch (_that) {
case _CompanyBrand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyBrand value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyBrand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String organizationId,  String name,  String? logoPath,  String? industry,  String? website,  String? description,  String? headquarters,  String status,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyBrand() when $default != null:
return $default(_that.id,_that.organizationId,_that.name,_that.logoPath,_that.industry,_that.website,_that.description,_that.headquarters,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String organizationId,  String name,  String? logoPath,  String? industry,  String? website,  String? description,  String? headquarters,  String status,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CompanyBrand():
return $default(_that.id,_that.organizationId,_that.name,_that.logoPath,_that.industry,_that.website,_that.description,_that.headquarters,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String organizationId,  String name,  String? logoPath,  String? industry,  String? website,  String? description,  String? headquarters,  String status,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CompanyBrand() when $default != null:
return $default(_that.id,_that.organizationId,_that.name,_that.logoPath,_that.industry,_that.website,_that.description,_that.headquarters,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyBrand implements CompanyBrand {
  const _CompanyBrand({required this.id, required this.organizationId, required this.name, this.logoPath, this.industry, this.website, this.description, this.headquarters, this.status = 'active', this.createdAt});
  factory _CompanyBrand.fromJson(Map<String, dynamic> json) => _$CompanyBrandFromJson(json);

@override final  String id;
@override final  String organizationId;
@override final  String name;
@override final  String? logoPath;
@override final  String? industry;
@override final  String? website;
@override final  String? description;
@override final  String? headquarters;
@override@JsonKey() final  String status;
@override final  DateTime? createdAt;

/// Create a copy of CompanyBrand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyBrandCopyWith<_CompanyBrand> get copyWith => __$CompanyBrandCopyWithImpl<_CompanyBrand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyBrandToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyBrand&&(identical(other.id, id) || other.id == id)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.website, website) || other.website == website)&&(identical(other.description, description) || other.description == description)&&(identical(other.headquarters, headquarters) || other.headquarters == headquarters)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,organizationId,name,logoPath,industry,website,description,headquarters,status,createdAt);
}

@override
String toString() {
    return 'CompanyBrand(id: $id, organizationId: $organizationId, name: $name, logoPath: $logoPath, industry: $industry, website: $website, description: $description, headquarters: $headquarters, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CompanyBrandCopyWith<$Res> implements $CompanyBrandCopyWith<$Res> {
  factory _$CompanyBrandCopyWith(_CompanyBrand value, $Res Function(_CompanyBrand) _then) = __$CompanyBrandCopyWithImpl;
@override @useResult
$Res call({
 String id, String organizationId, String name, String? logoPath, String? industry, String? website, String? description, String? headquarters, String status, DateTime? createdAt
});




}
/// @nodoc
class __$CompanyBrandCopyWithImpl<$Res>
    implements _$CompanyBrandCopyWith<$Res> {
  __$CompanyBrandCopyWithImpl(this._self, this._then);

  final _CompanyBrand _self;
  final $Res Function(_CompanyBrand) _then;

/// Create a copy of CompanyBrand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organizationId = null,Object? name = null,Object? logoPath = freezed,Object? industry = freezed,Object? website = freezed,Object? description = freezed,Object? headquarters = freezed,Object? status = null,Object? createdAt = freezed,}) {
  return _then(_CompanyBrand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,headquarters: freezed == headquarters ? _self.headquarters : headquarters // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$BrandMarketerProfile {

 String get userId; String get displayName; String? get jobTitle; String? get workEmail; String? get phone; String? get bio; String? get organizationId; String? get organizationName; List<CompanyBrand> get managedBrands; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of BrandMarketerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandMarketerProfileCopyWith<BrandMarketerProfile> get copyWith => _$BrandMarketerProfileCopyWithImpl<BrandMarketerProfile>(this as BrandMarketerProfile, _$identity);

  /// Serializes this BrandMarketerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BrandMarketerProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandMarketerProfile&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.jobTitle, _this.jobTitle) || other.jobTitle == _this.jobTitle)&&(identical(other.workEmail, _this.workEmail) || other.workEmail == _this.workEmail)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.organizationName, _this.organizationName) || other.organizationName == _this.organizationName)&&const DeepCollectionEquality().equals(other.managedBrands, _this.managedBrands)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BrandMarketerProfile;
  return Object.hash(runtimeType,_this.userId,_this.displayName,_this.jobTitle,_this.workEmail,_this.phone,_this.bio,_this.organizationId,_this.organizationName,const DeepCollectionEquality().hash(_this.managedBrands),_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as BrandMarketerProfile;
  return 'BrandMarketerProfile(userId: ${_this.userId}, displayName: ${_this.displayName}, jobTitle: ${_this.jobTitle}, workEmail: ${_this.workEmail}, phone: ${_this.phone}, bio: ${_this.bio}, organizationId: ${_this.organizationId}, organizationName: ${_this.organizationName}, managedBrands: ${_this.managedBrands}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $BrandMarketerProfileCopyWith<$Res>  {
  factory $BrandMarketerProfileCopyWith(BrandMarketerProfile value, $Res Function(BrandMarketerProfile) _then) = _$BrandMarketerProfileCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? jobTitle, String? workEmail, String? phone, String? bio, String? organizationId, String? organizationName, List<CompanyBrand> managedBrands, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$BrandMarketerProfileCopyWithImpl<$Res>
    implements $BrandMarketerProfileCopyWith<$Res> {
  _$BrandMarketerProfileCopyWithImpl(this._self, this._then);

  final BrandMarketerProfile _self;
  final $Res Function(BrandMarketerProfile) _then;

/// Create a copy of BrandMarketerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? jobTitle = freezed,Object? workEmail = freezed,Object? phone = freezed,Object? bio = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? managedBrands = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(BrandMarketerProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,workEmail: freezed == workEmail ? _self.workEmail : workEmail // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,managedBrands: null == managedBrands ? _self.managedBrands : managedBrands // ignore: cast_nullable_to_non_nullable
as List<CompanyBrand>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandMarketerProfile].
extension BrandMarketerProfilePatterns on BrandMarketerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandMarketerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandMarketerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandMarketerProfile value)  $default,){
final _that = this;
switch (_that) {
case _BrandMarketerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandMarketerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _BrandMarketerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? jobTitle,  String? workEmail,  String? phone,  String? bio,  String? organizationId,  String? organizationName,  List<CompanyBrand> managedBrands,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandMarketerProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.jobTitle,_that.workEmail,_that.phone,_that.bio,_that.organizationId,_that.organizationName,_that.managedBrands,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? jobTitle,  String? workEmail,  String? phone,  String? bio,  String? organizationId,  String? organizationName,  List<CompanyBrand> managedBrands,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BrandMarketerProfile():
return $default(_that.userId,_that.displayName,_that.jobTitle,_that.workEmail,_that.phone,_that.bio,_that.organizationId,_that.organizationName,_that.managedBrands,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? jobTitle,  String? workEmail,  String? phone,  String? bio,  String? organizationId,  String? organizationName,  List<CompanyBrand> managedBrands,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BrandMarketerProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.jobTitle,_that.workEmail,_that.phone,_that.bio,_that.organizationId,_that.organizationName,_that.managedBrands,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BrandMarketerProfile implements BrandMarketerProfile {
  const _BrandMarketerProfile({required this.userId, required this.displayName, this.jobTitle, this.workEmail, this.phone, this.bio, this.organizationId, this.organizationName,  List<CompanyBrand> managedBrands = const [], this.createdAt, this.updatedAt}): _managedBrands = managedBrands;
  factory _BrandMarketerProfile.fromJson(Map<String, dynamic> json) => _$BrandMarketerProfileFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? jobTitle;
@override final  String? workEmail;
@override final  String? phone;
@override final  String? bio;
@override final  String? organizationId;
@override final  String? organizationName;
 final  List<CompanyBrand> _managedBrands;
@override@JsonKey() List<CompanyBrand> get managedBrands {
  if (_managedBrands is EqualUnmodifiableListView) return _managedBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_managedBrands);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of BrandMarketerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandMarketerProfileCopyWith<_BrandMarketerProfile> get copyWith => __$BrandMarketerProfileCopyWithImpl<_BrandMarketerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BrandMarketerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandMarketerProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.workEmail, workEmail) || other.workEmail == workEmail)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&const DeepCollectionEquality().equals(other.managedBrands, _managedBrands)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,displayName,jobTitle,workEmail,phone,bio,organizationId,organizationName,const DeepCollectionEquality().hash(_managedBrands),createdAt,updatedAt);
}

@override
String toString() {
    return 'BrandMarketerProfile(userId: $userId, displayName: $displayName, jobTitle: $jobTitle, workEmail: $workEmail, phone: $phone, bio: $bio, organizationId: $organizationId, organizationName: $organizationName, managedBrands: $managedBrands, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BrandMarketerProfileCopyWith<$Res> implements $BrandMarketerProfileCopyWith<$Res> {
  factory _$BrandMarketerProfileCopyWith(_BrandMarketerProfile value, $Res Function(_BrandMarketerProfile) _then) = __$BrandMarketerProfileCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? jobTitle, String? workEmail, String? phone, String? bio, String? organizationId, String? organizationName, List<CompanyBrand> managedBrands, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$BrandMarketerProfileCopyWithImpl<$Res>
    implements _$BrandMarketerProfileCopyWith<$Res> {
  __$BrandMarketerProfileCopyWithImpl(this._self, this._then);

  final _BrandMarketerProfile _self;
  final $Res Function(_BrandMarketerProfile) _then;

/// Create a copy of BrandMarketerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? jobTitle = freezed,Object? workEmail = freezed,Object? phone = freezed,Object? bio = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? managedBrands = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_BrandMarketerProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,workEmail: freezed == workEmail ? _self.workEmail : workEmail // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,managedBrands: null == managedBrands ? _self._managedBrands : managedBrands // ignore: cast_nullable_to_non_nullable
as List<CompanyBrand>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
