// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialAccount {

 String get id; String get userId; SocialPlatform get platform; String get handle; String? get profileUrl; int? get userProvidedFollowerCount; SocialConnectionStatus get connectionStatus; FieldVerificationStatus get verificationStatus; DateTime? get lastVerifiedAt;
/// Create a copy of SocialAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialAccountCopyWith<SocialAccount> get copyWith => _$SocialAccountCopyWithImpl<SocialAccount>(this as SocialAccount, _$identity);

  /// Serializes this SocialAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialAccount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialAccount&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.profileUrl, _this.profileUrl) || other.profileUrl == _this.profileUrl)&&(identical(other.userProvidedFollowerCount, _this.userProvidedFollowerCount) || other.userProvidedFollowerCount == _this.userProvidedFollowerCount)&&(identical(other.connectionStatus, _this.connectionStatus) || other.connectionStatus == _this.connectionStatus)&&(identical(other.verificationStatus, _this.verificationStatus) || other.verificationStatus == _this.verificationStatus)&&(identical(other.lastVerifiedAt, _this.lastVerifiedAt) || other.lastVerifiedAt == _this.lastVerifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialAccount;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.platform,_this.handle,_this.profileUrl,_this.userProvidedFollowerCount,_this.connectionStatus,_this.verificationStatus,_this.lastVerifiedAt);
}

@override
String toString() {
  final _this = this as SocialAccount;
  return 'SocialAccount(id: ${_this.id}, userId: ${_this.userId}, platform: ${_this.platform}, handle: ${_this.handle}, profileUrl: ${_this.profileUrl}, userProvidedFollowerCount: ${_this.userProvidedFollowerCount}, connectionStatus: ${_this.connectionStatus}, verificationStatus: ${_this.verificationStatus}, lastVerifiedAt: ${_this.lastVerifiedAt})';
}


}

/// @nodoc
abstract mixin class $SocialAccountCopyWith<$Res>  {
  factory $SocialAccountCopyWith(SocialAccount value, $Res Function(SocialAccount) _then) = _$SocialAccountCopyWithImpl;
@useResult
$Res call({
 String id, String userId, SocialPlatform platform, String handle, String? profileUrl, int? userProvidedFollowerCount, SocialConnectionStatus connectionStatus, FieldVerificationStatus verificationStatus, DateTime? lastVerifiedAt
});




}
/// @nodoc
class _$SocialAccountCopyWithImpl<$Res>
    implements $SocialAccountCopyWith<$Res> {
  _$SocialAccountCopyWithImpl(this._self, this._then);

  final SocialAccount _self;
  final $Res Function(SocialAccount) _then;

/// Create a copy of SocialAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? platform = null,Object? handle = null,Object? profileUrl = freezed,Object? userProvidedFollowerCount = freezed,Object? connectionStatus = null,Object? verificationStatus = null,Object? lastVerifiedAt = freezed,}) {
  return _then(SocialAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SocialPlatform,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,profileUrl: freezed == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String?,userProvidedFollowerCount: freezed == userProvidedFollowerCount ? _self.userProvidedFollowerCount : userProvidedFollowerCount // ignore: cast_nullable_to_non_nullable
as int?,connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as SocialConnectionStatus,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,lastVerifiedAt: freezed == lastVerifiedAt ? _self.lastVerifiedAt : lastVerifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialAccount].
extension SocialAccountPatterns on SocialAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialAccount value)  $default,){
final _that = this;
switch (_that) {
case _SocialAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialAccount value)?  $default,){
final _that = this;
switch (_that) {
case _SocialAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  SocialPlatform platform,  String handle,  String? profileUrl,  int? userProvidedFollowerCount,  SocialConnectionStatus connectionStatus,  FieldVerificationStatus verificationStatus,  DateTime? lastVerifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialAccount() when $default != null:
return $default(_that.id,_that.userId,_that.platform,_that.handle,_that.profileUrl,_that.userProvidedFollowerCount,_that.connectionStatus,_that.verificationStatus,_that.lastVerifiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  SocialPlatform platform,  String handle,  String? profileUrl,  int? userProvidedFollowerCount,  SocialConnectionStatus connectionStatus,  FieldVerificationStatus verificationStatus,  DateTime? lastVerifiedAt)  $default,) {final _that = this;
switch (_that) {
case _SocialAccount():
return $default(_that.id,_that.userId,_that.platform,_that.handle,_that.profileUrl,_that.userProvidedFollowerCount,_that.connectionStatus,_that.verificationStatus,_that.lastVerifiedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  SocialPlatform platform,  String handle,  String? profileUrl,  int? userProvidedFollowerCount,  SocialConnectionStatus connectionStatus,  FieldVerificationStatus verificationStatus,  DateTime? lastVerifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _SocialAccount() when $default != null:
return $default(_that.id,_that.userId,_that.platform,_that.handle,_that.profileUrl,_that.userProvidedFollowerCount,_that.connectionStatus,_that.verificationStatus,_that.lastVerifiedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialAccount implements SocialAccount {
  const _SocialAccount({required this.id, required this.userId, required this.platform, required this.handle, this.profileUrl, this.userProvidedFollowerCount, this.connectionStatus = SocialConnectionStatus.selfReported, this.verificationStatus = FieldVerificationStatus.notStarted, this.lastVerifiedAt});
  factory _SocialAccount.fromJson(Map<String, dynamic> json) => _$SocialAccountFromJson(json);

@override final  String id;
@override final  String userId;
@override final  SocialPlatform platform;
@override final  String handle;
@override final  String? profileUrl;
@override final  int? userProvidedFollowerCount;
@override@JsonKey() final  SocialConnectionStatus connectionStatus;
@override@JsonKey() final  FieldVerificationStatus verificationStatus;
@override final  DateTime? lastVerifiedAt;

/// Create a copy of SocialAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAccountCopyWith<_SocialAccount> get copyWith => __$SocialAccountCopyWithImpl<_SocialAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialAccountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.userProvidedFollowerCount, userProvidedFollowerCount) || other.userProvidedFollowerCount == userProvidedFollowerCount)&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.lastVerifiedAt, lastVerifiedAt) || other.lastVerifiedAt == lastVerifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,platform,handle,profileUrl,userProvidedFollowerCount,connectionStatus,verificationStatus,lastVerifiedAt);
}

@override
String toString() {
    return 'SocialAccount(id: $id, userId: $userId, platform: $platform, handle: $handle, profileUrl: $profileUrl, userProvidedFollowerCount: $userProvidedFollowerCount, connectionStatus: $connectionStatus, verificationStatus: $verificationStatus, lastVerifiedAt: $lastVerifiedAt)';
}


}

/// @nodoc
abstract mixin class _$SocialAccountCopyWith<$Res> implements $SocialAccountCopyWith<$Res> {
  factory _$SocialAccountCopyWith(_SocialAccount value, $Res Function(_SocialAccount) _then) = __$SocialAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, SocialPlatform platform, String handle, String? profileUrl, int? userProvidedFollowerCount, SocialConnectionStatus connectionStatus, FieldVerificationStatus verificationStatus, DateTime? lastVerifiedAt
});




}
/// @nodoc
class __$SocialAccountCopyWithImpl<$Res>
    implements _$SocialAccountCopyWith<$Res> {
  __$SocialAccountCopyWithImpl(this._self, this._then);

  final _SocialAccount _self;
  final $Res Function(_SocialAccount) _then;

/// Create a copy of SocialAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? platform = null,Object? handle = null,Object? profileUrl = freezed,Object? userProvidedFollowerCount = freezed,Object? connectionStatus = null,Object? verificationStatus = null,Object? lastVerifiedAt = freezed,}) {
  return _then(_SocialAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SocialPlatform,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,profileUrl: freezed == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String?,userProvidedFollowerCount: freezed == userProvidedFollowerCount ? _self.userProvidedFollowerCount : userProvidedFollowerCount // ignore: cast_nullable_to_non_nullable
as int?,connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as SocialConnectionStatus,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as FieldVerificationStatus,lastVerifiedAt: freezed == lastVerifiedAt ? _self.lastVerifiedAt : lastVerifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
