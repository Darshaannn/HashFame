// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PortfolioItem {

 String get id; String get userId; String get title; String? get description; SocialPlatform? get platform; String? get contentUrl; String? get mediaPath; String? get brandName; DateTime? get publishedDate; PortfolioContentType get contentType; int get sortOrder;
/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioItemCopyWith<PortfolioItem> get copyWith => _$PortfolioItemCopyWithImpl<PortfolioItem>(this as PortfolioItem, _$identity);

  /// Serializes this PortfolioItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PortfolioItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.contentUrl, _this.contentUrl) || other.contentUrl == _this.contentUrl)&&(identical(other.mediaPath, _this.mediaPath) || other.mediaPath == _this.mediaPath)&&(identical(other.brandName, _this.brandName) || other.brandName == _this.brandName)&&(identical(other.publishedDate, _this.publishedDate) || other.publishedDate == _this.publishedDate)&&(identical(other.contentType, _this.contentType) || other.contentType == _this.contentType)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PortfolioItem;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.title,_this.description,_this.platform,_this.contentUrl,_this.mediaPath,_this.brandName,_this.publishedDate,_this.contentType,_this.sortOrder);
}

@override
String toString() {
  final _this = this as PortfolioItem;
  return 'PortfolioItem(id: ${_this.id}, userId: ${_this.userId}, title: ${_this.title}, description: ${_this.description}, platform: ${_this.platform}, contentUrl: ${_this.contentUrl}, mediaPath: ${_this.mediaPath}, brandName: ${_this.brandName}, publishedDate: ${_this.publishedDate}, contentType: ${_this.contentType}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $PortfolioItemCopyWith<$Res>  {
  factory $PortfolioItemCopyWith(PortfolioItem value, $Res Function(PortfolioItem) _then) = _$PortfolioItemCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, String? description, SocialPlatform? platform, String? contentUrl, String? mediaPath, String? brandName, DateTime? publishedDate, PortfolioContentType contentType, int sortOrder
});




}
/// @nodoc
class _$PortfolioItemCopyWithImpl<$Res>
    implements $PortfolioItemCopyWith<$Res> {
  _$PortfolioItemCopyWithImpl(this._self, this._then);

  final PortfolioItem _self;
  final $Res Function(PortfolioItem) _then;

/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = freezed,Object? platform = freezed,Object? contentUrl = freezed,Object? mediaPath = freezed,Object? brandName = freezed,Object? publishedDate = freezed,Object? contentType = null,Object? sortOrder = null,}) {
  return _then(PortfolioItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SocialPlatform?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaPath: freezed == mediaPath ? _self.mediaPath : mediaPath // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,publishedDate: freezed == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as PortfolioContentType,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioItem].
extension PortfolioItemPatterns on PortfolioItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioItem value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioItem value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? description,  SocialPlatform? platform,  String? contentUrl,  String? mediaPath,  String? brandName,  DateTime? publishedDate,  PortfolioContentType contentType,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.platform,_that.contentUrl,_that.mediaPath,_that.brandName,_that.publishedDate,_that.contentType,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? description,  SocialPlatform? platform,  String? contentUrl,  String? mediaPath,  String? brandName,  DateTime? publishedDate,  PortfolioContentType contentType,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _PortfolioItem():
return $default(_that.id,_that.userId,_that.title,_that.description,_that.platform,_that.contentUrl,_that.mediaPath,_that.brandName,_that.publishedDate,_that.contentType,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  String? description,  SocialPlatform? platform,  String? contentUrl,  String? mediaPath,  String? brandName,  DateTime? publishedDate,  PortfolioContentType contentType,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.platform,_that.contentUrl,_that.mediaPath,_that.brandName,_that.publishedDate,_that.contentType,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioItem implements PortfolioItem {
  const _PortfolioItem({required this.id, required this.userId, required this.title, this.description, this.platform, this.contentUrl, this.mediaPath, this.brandName, this.publishedDate, this.contentType = PortfolioContentType.video, this.sortOrder = 0});
  factory _PortfolioItem.fromJson(Map<String, dynamic> json) => _$PortfolioItemFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String title;
@override final  String? description;
@override final  SocialPlatform? platform;
@override final  String? contentUrl;
@override final  String? mediaPath;
@override final  String? brandName;
@override final  DateTime? publishedDate;
@override@JsonKey() final  PortfolioContentType contentType;
@override@JsonKey() final  int sortOrder;

/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioItemCopyWith<_PortfolioItem> get copyWith => __$PortfolioItemCopyWithImpl<_PortfolioItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioItem&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.mediaPath, mediaPath) || other.mediaPath == mediaPath)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,title,description,platform,contentUrl,mediaPath,brandName,publishedDate,contentType,sortOrder);
}

@override
String toString() {
    return 'PortfolioItem(id: $id, userId: $userId, title: $title, description: $description, platform: $platform, contentUrl: $contentUrl, mediaPath: $mediaPath, brandName: $brandName, publishedDate: $publishedDate, contentType: $contentType, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$PortfolioItemCopyWith<$Res> implements $PortfolioItemCopyWith<$Res> {
  factory _$PortfolioItemCopyWith(_PortfolioItem value, $Res Function(_PortfolioItem) _then) = __$PortfolioItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, String? description, SocialPlatform? platform, String? contentUrl, String? mediaPath, String? brandName, DateTime? publishedDate, PortfolioContentType contentType, int sortOrder
});




}
/// @nodoc
class __$PortfolioItemCopyWithImpl<$Res>
    implements _$PortfolioItemCopyWith<$Res> {
  __$PortfolioItemCopyWithImpl(this._self, this._then);

  final _PortfolioItem _self;
  final $Res Function(_PortfolioItem) _then;

/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = freezed,Object? platform = freezed,Object? contentUrl = freezed,Object? mediaPath = freezed,Object? brandName = freezed,Object? publishedDate = freezed,Object? contentType = null,Object? sortOrder = null,}) {
  return _then(_PortfolioItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SocialPlatform?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaPath: freezed == mediaPath ? _self.mediaPath : mediaPath // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,publishedDate: freezed == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as PortfolioContentType,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
