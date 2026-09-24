// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Account {

 String get id; String get displayName; ProfessionalRole? get primaryRoleLabel; AccountState get accountState; DateTime get updatedAt; String? get avatarPath;
/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCopyWith<Account> get copyWith => _$AccountCopyWithImpl<Account>(this as Account, _$identity);

  /// Serializes this Account to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Account;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Account&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.primaryRoleLabel, _this.primaryRoleLabel) || other.primaryRoleLabel == _this.primaryRoleLabel)&&(identical(other.accountState, _this.accountState) || other.accountState == _this.accountState)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.avatarPath, _this.avatarPath) || other.avatarPath == _this.avatarPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Account;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.primaryRoleLabel,_this.accountState,_this.updatedAt,_this.avatarPath);
}

@override
String toString() {
  final _this = this as Account;
  return 'Account(id: ${_this.id}, displayName: ${_this.displayName}, primaryRoleLabel: ${_this.primaryRoleLabel}, accountState: ${_this.accountState}, updatedAt: ${_this.updatedAt}, avatarPath: ${_this.avatarPath})';
}


}

/// @nodoc
abstract mixin class $AccountCopyWith<$Res>  {
  factory $AccountCopyWith(Account value, $Res Function(Account) _then) = _$AccountCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, ProfessionalRole? primaryRoleLabel, AccountState accountState, DateTime updatedAt, String? avatarPath
});




}
/// @nodoc
class _$AccountCopyWithImpl<$Res>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._self, this._then);

  final Account _self;
  final $Res Function(Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? primaryRoleLabel = freezed,Object? accountState = null,Object? updatedAt = null,Object? avatarPath = freezed,}) {
  return _then(Account(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,primaryRoleLabel: freezed == primaryRoleLabel ? _self.primaryRoleLabel : primaryRoleLabel // ignore: cast_nullable_to_non_nullable
as ProfessionalRole?,accountState: null == accountState ? _self.accountState : accountState // ignore: cast_nullable_to_non_nullable
as AccountState,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Account].
extension AccountPatterns on Account {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Account value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Account value)  $default,){
final _that = this;
switch (_that) {
case _Account():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Account value)?  $default,){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  ProfessionalRole? primaryRoleLabel,  AccountState accountState,  DateTime updatedAt,  String? avatarPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.id,_that.displayName,_that.primaryRoleLabel,_that.accountState,_that.updatedAt,_that.avatarPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  ProfessionalRole? primaryRoleLabel,  AccountState accountState,  DateTime updatedAt,  String? avatarPath)  $default,) {final _that = this;
switch (_that) {
case _Account():
return $default(_that.id,_that.displayName,_that.primaryRoleLabel,_that.accountState,_that.updatedAt,_that.avatarPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  ProfessionalRole? primaryRoleLabel,  AccountState accountState,  DateTime updatedAt,  String? avatarPath)?  $default,) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.id,_that.displayName,_that.primaryRoleLabel,_that.accountState,_that.updatedAt,_that.avatarPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Account extends Account {
  const _Account({required this.id, required this.displayName, this.primaryRoleLabel, required this.accountState, required this.updatedAt, this.avatarPath}): super._();
  factory _Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  ProfessionalRole? primaryRoleLabel;
@override final  AccountState accountState;
@override final  DateTime updatedAt;
@override final  String? avatarPath;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountCopyWith<_Account> get copyWith => __$AccountCopyWithImpl<_Account>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Account&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.primaryRoleLabel, primaryRoleLabel) || other.primaryRoleLabel == primaryRoleLabel)&&(identical(other.accountState, accountState) || other.accountState == accountState)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,primaryRoleLabel,accountState,updatedAt,avatarPath);
}

@override
String toString() {
    return 'Account(id: $id, displayName: $displayName, primaryRoleLabel: $primaryRoleLabel, accountState: $accountState, updatedAt: $updatedAt, avatarPath: $avatarPath)';
}


}

/// @nodoc
abstract mixin class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) _then) = __$AccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, ProfessionalRole? primaryRoleLabel, AccountState accountState, DateTime updatedAt, String? avatarPath
});




}
/// @nodoc
class __$AccountCopyWithImpl<$Res>
    implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(this._self, this._then);

  final _Account _self;
  final $Res Function(_Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? primaryRoleLabel = freezed,Object? accountState = null,Object? updatedAt = null,Object? avatarPath = freezed,}) {
  return _then(_Account(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,primaryRoleLabel: freezed == primaryRoleLabel ? _self.primaryRoleLabel : primaryRoleLabel // ignore: cast_nullable_to_non_nullable
as ProfessionalRole?,accountState: null == accountState ? _self.accountState : accountState // ignore: cast_nullable_to_non_nullable
as AccountState,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AccountSettings {

 String get locale; String get themePreference; NotificationPreferences get notificationPreferences;
/// Create a copy of AccountSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountSettingsCopyWith<AccountSettings> get copyWith => _$AccountSettingsCopyWithImpl<AccountSettings>(this as AccountSettings, _$identity);

  /// Serializes this AccountSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AccountSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountSettings&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.themePreference, _this.themePreference) || other.themePreference == _this.themePreference)&&(identical(other.notificationPreferences, _this.notificationPreferences) || other.notificationPreferences == _this.notificationPreferences));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AccountSettings;
  return Object.hash(runtimeType,_this.locale,_this.themePreference,_this.notificationPreferences);
}

@override
String toString() {
  final _this = this as AccountSettings;
  return 'AccountSettings(locale: ${_this.locale}, themePreference: ${_this.themePreference}, notificationPreferences: ${_this.notificationPreferences})';
}


}

/// @nodoc
abstract mixin class $AccountSettingsCopyWith<$Res>  {
  factory $AccountSettingsCopyWith(AccountSettings value, $Res Function(AccountSettings) _then) = _$AccountSettingsCopyWithImpl;
@useResult
$Res call({
 String locale, String themePreference, NotificationPreferences notificationPreferences
});


$NotificationPreferencesCopyWith<$Res> get notificationPreferences;

}
/// @nodoc
class _$AccountSettingsCopyWithImpl<$Res>
    implements $AccountSettingsCopyWith<$Res> {
  _$AccountSettingsCopyWithImpl(this._self, this._then);

  final AccountSettings _self;
  final $Res Function(AccountSettings) _then;

/// Create a copy of AccountSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? themePreference = null,Object? notificationPreferences = null,}) {
  return _then(AccountSettings(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as String,notificationPreferences: null == notificationPreferences ? _self.notificationPreferences : notificationPreferences // ignore: cast_nullable_to_non_nullable
as NotificationPreferences,
  ));
}
/// Create a copy of AccountSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<$Res> get notificationPreferences {
  
  return $NotificationPreferencesCopyWith<$Res>(_self.notificationPreferences, (value) {
    return _then(_self.copyWith(notificationPreferences: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountSettings].
extension AccountSettingsPatterns on AccountSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountSettings value)  $default,){
final _that = this;
switch (_that) {
case _AccountSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AccountSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale,  String themePreference,  NotificationPreferences notificationPreferences)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountSettings() when $default != null:
return $default(_that.locale,_that.themePreference,_that.notificationPreferences);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale,  String themePreference,  NotificationPreferences notificationPreferences)  $default,) {final _that = this;
switch (_that) {
case _AccountSettings():
return $default(_that.locale,_that.themePreference,_that.notificationPreferences);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale,  String themePreference,  NotificationPreferences notificationPreferences)?  $default,) {final _that = this;
switch (_that) {
case _AccountSettings() when $default != null:
return $default(_that.locale,_that.themePreference,_that.notificationPreferences);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountSettings implements AccountSettings {
  const _AccountSettings({this.locale = 'en', this.themePreference = 'system', this.notificationPreferences = const NotificationPreferences()});
  factory _AccountSettings.fromJson(Map<String, dynamic> json) => _$AccountSettingsFromJson(json);

@override@JsonKey() final  String locale;
@override@JsonKey() final  String themePreference;
@override@JsonKey() final  NotificationPreferences notificationPreferences;

/// Create a copy of AccountSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountSettingsCopyWith<_AccountSettings> get copyWith => __$AccountSettingsCopyWithImpl<_AccountSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountSettings&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference)&&(identical(other.notificationPreferences, notificationPreferences) || other.notificationPreferences == notificationPreferences));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,locale,themePreference,notificationPreferences);
}

@override
String toString() {
    return 'AccountSettings(locale: $locale, themePreference: $themePreference, notificationPreferences: $notificationPreferences)';
}


}

/// @nodoc
abstract mixin class _$AccountSettingsCopyWith<$Res> implements $AccountSettingsCopyWith<$Res> {
  factory _$AccountSettingsCopyWith(_AccountSettings value, $Res Function(_AccountSettings) _then) = __$AccountSettingsCopyWithImpl;
@override @useResult
$Res call({
 String locale, String themePreference, NotificationPreferences notificationPreferences
});


@override $NotificationPreferencesCopyWith<$Res> get notificationPreferences;

}
/// @nodoc
class __$AccountSettingsCopyWithImpl<$Res>
    implements _$AccountSettingsCopyWith<$Res> {
  __$AccountSettingsCopyWithImpl(this._self, this._then);

  final _AccountSettings _self;
  final $Res Function(_AccountSettings) _then;

/// Create a copy of AccountSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? themePreference = null,Object? notificationPreferences = null,}) {
  return _then(_AccountSettings(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as String,notificationPreferences: null == notificationPreferences ? _self.notificationPreferences : notificationPreferences // ignore: cast_nullable_to_non_nullable
as NotificationPreferences,
  ));
}

/// Create a copy of AccountSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<$Res> get notificationPreferences {
  
  return $NotificationPreferencesCopyWith<$Res>(_self.notificationPreferences, (value) {
    return _then(_self.copyWith(notificationPreferences: value));
  });
}
}


/// @nodoc
mixin _$NotificationPreferences {

 bool get productUpdates; bool get securityAlerts;
/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<NotificationPreferences> get copyWith => _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(this as NotificationPreferences, _$identity);

  /// Serializes this NotificationPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationPreferences;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferences&&(identical(other.productUpdates, _this.productUpdates) || other.productUpdates == _this.productUpdates)&&(identical(other.securityAlerts, _this.securityAlerts) || other.securityAlerts == _this.securityAlerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationPreferences;
  return Object.hash(runtimeType,_this.productUpdates,_this.securityAlerts);
}

@override
String toString() {
  final _this = this as NotificationPreferences;
  return 'NotificationPreferences(productUpdates: ${_this.productUpdates}, securityAlerts: ${_this.securityAlerts})';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res>  {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value, $Res Function(NotificationPreferences) _then) = _$NotificationPreferencesCopyWithImpl;
@useResult
$Res call({
 bool productUpdates, bool securityAlerts
});




}
/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productUpdates = null,Object? securityAlerts = null,}) {
  return _then(NotificationPreferences(
productUpdates: null == productUpdates ? _self.productUpdates : productUpdates // ignore: cast_nullable_to_non_nullable
as bool,securityAlerts: null == securityAlerts ? _self.securityAlerts : securityAlerts // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferences].
extension NotificationPreferencesPatterns on NotificationPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferences value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool productUpdates,  bool securityAlerts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.productUpdates,_that.securityAlerts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool productUpdates,  bool securityAlerts)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences():
return $default(_that.productUpdates,_that.securityAlerts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool productUpdates,  bool securityAlerts)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.productUpdates,_that.securityAlerts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferences implements NotificationPreferences {
  const _NotificationPreferences({this.productUpdates = false, this.securityAlerts = true});
  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesFromJson(json);

@override@JsonKey() final  bool productUpdates;
@override@JsonKey() final  bool securityAlerts;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith => __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferences&&(identical(other.productUpdates, productUpdates) || other.productUpdates == productUpdates)&&(identical(other.securityAlerts, securityAlerts) || other.securityAlerts == securityAlerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,productUpdates,securityAlerts);
}

@override
String toString() {
    return 'NotificationPreferences(productUpdates: $productUpdates, securityAlerts: $securityAlerts)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res> implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value, $Res Function(_NotificationPreferences) _then) = __$NotificationPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool productUpdates, bool securityAlerts
});




}
/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productUpdates = null,Object? securityAlerts = null,}) {
  return _then(_NotificationPreferences(
productUpdates: null == productUpdates ? _self.productUpdates : productUpdates // ignore: cast_nullable_to_non_nullable
as bool,securityAlerts: null == securityAlerts ? _self.securityAlerts : securityAlerts // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
