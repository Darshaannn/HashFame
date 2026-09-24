// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RateItem {

 String get id; String get userId; DeliverableType get deliverableType; String? get customTitle; double get priceAmount; String get currency; String? get description; bool get isActive;
/// Create a copy of RateItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateItemCopyWith<RateItem> get copyWith => _$RateItemCopyWithImpl<RateItem>(this as RateItem, _$identity);

  /// Serializes this RateItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RateItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.deliverableType, _this.deliverableType) || other.deliverableType == _this.deliverableType)&&(identical(other.customTitle, _this.customTitle) || other.customTitle == _this.customTitle)&&(identical(other.priceAmount, _this.priceAmount) || other.priceAmount == _this.priceAmount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RateItem;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.deliverableType,_this.customTitle,_this.priceAmount,_this.currency,_this.description,_this.isActive);
}

@override
String toString() {
  final _this = this as RateItem;
  return 'RateItem(id: ${_this.id}, userId: ${_this.userId}, deliverableType: ${_this.deliverableType}, customTitle: ${_this.customTitle}, priceAmount: ${_this.priceAmount}, currency: ${_this.currency}, description: ${_this.description}, isActive: ${_this.isActive})';
}


}

/// @nodoc
abstract mixin class $RateItemCopyWith<$Res>  {
  factory $RateItemCopyWith(RateItem value, $Res Function(RateItem) _then) = _$RateItemCopyWithImpl;
@useResult
$Res call({
 String id, String userId, DeliverableType deliverableType, String? customTitle, double priceAmount, String currency, String? description, bool isActive
});




}
/// @nodoc
class _$RateItemCopyWithImpl<$Res>
    implements $RateItemCopyWith<$Res> {
  _$RateItemCopyWithImpl(this._self, this._then);

  final RateItem _self;
  final $Res Function(RateItem) _then;

/// Create a copy of RateItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? deliverableType = null,Object? customTitle = freezed,Object? priceAmount = null,Object? currency = null,Object? description = freezed,Object? isActive = null,}) {
  return _then(RateItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,deliverableType: null == deliverableType ? _self.deliverableType : deliverableType // ignore: cast_nullable_to_non_nullable
as DeliverableType,customTitle: freezed == customTitle ? _self.customTitle : customTitle // ignore: cast_nullable_to_non_nullable
as String?,priceAmount: null == priceAmount ? _self.priceAmount : priceAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RateItem].
extension RateItemPatterns on RateItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateItem value)  $default,){
final _that = this;
switch (_that) {
case _RateItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateItem value)?  $default,){
final _that = this;
switch (_that) {
case _RateItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  DeliverableType deliverableType,  String? customTitle,  double priceAmount,  String currency,  String? description,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateItem() when $default != null:
return $default(_that.id,_that.userId,_that.deliverableType,_that.customTitle,_that.priceAmount,_that.currency,_that.description,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  DeliverableType deliverableType,  String? customTitle,  double priceAmount,  String currency,  String? description,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _RateItem():
return $default(_that.id,_that.userId,_that.deliverableType,_that.customTitle,_that.priceAmount,_that.currency,_that.description,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  DeliverableType deliverableType,  String? customTitle,  double priceAmount,  String currency,  String? description,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _RateItem() when $default != null:
return $default(_that.id,_that.userId,_that.deliverableType,_that.customTitle,_that.priceAmount,_that.currency,_that.description,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateItem implements RateItem {
  const _RateItem({required this.id, required this.userId, required this.deliverableType, this.customTitle, required this.priceAmount, this.currency = 'INR', this.description, this.isActive = true});
  factory _RateItem.fromJson(Map<String, dynamic> json) => _$RateItemFromJson(json);

@override final  String id;
@override final  String userId;
@override final  DeliverableType deliverableType;
@override final  String? customTitle;
@override final  double priceAmount;
@override@JsonKey() final  String currency;
@override final  String? description;
@override@JsonKey() final  bool isActive;

/// Create a copy of RateItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateItemCopyWith<_RateItem> get copyWith => __$RateItemCopyWithImpl<_RateItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateItem&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.deliverableType, deliverableType) || other.deliverableType == deliverableType)&&(identical(other.customTitle, customTitle) || other.customTitle == customTitle)&&(identical(other.priceAmount, priceAmount) || other.priceAmount == priceAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,deliverableType,customTitle,priceAmount,currency,description,isActive);
}

@override
String toString() {
    return 'RateItem(id: $id, userId: $userId, deliverableType: $deliverableType, customTitle: $customTitle, priceAmount: $priceAmount, currency: $currency, description: $description, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$RateItemCopyWith<$Res> implements $RateItemCopyWith<$Res> {
  factory _$RateItemCopyWith(_RateItem value, $Res Function(_RateItem) _then) = __$RateItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, DeliverableType deliverableType, String? customTitle, double priceAmount, String currency, String? description, bool isActive
});




}
/// @nodoc
class __$RateItemCopyWithImpl<$Res>
    implements _$RateItemCopyWith<$Res> {
  __$RateItemCopyWithImpl(this._self, this._then);

  final _RateItem _self;
  final $Res Function(_RateItem) _then;

/// Create a copy of RateItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? deliverableType = null,Object? customTitle = freezed,Object? priceAmount = null,Object? currency = null,Object? description = freezed,Object? isActive = null,}) {
  return _then(_RateItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,deliverableType: null == deliverableType ? _self.deliverableType : deliverableType // ignore: cast_nullable_to_non_nullable
as DeliverableType,customTitle: freezed == customTitle ? _self.customTitle : customTitle // ignore: cast_nullable_to_non_nullable
as String?,priceAmount: null == priceAmount ? _self.priceAmount : priceAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
