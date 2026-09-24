// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissingRecommendation {

 String get key; String get title; String get description; int get weight; String get actionRoute;
/// Create a copy of MissingRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissingRecommendationCopyWith<MissingRecommendation> get copyWith => _$MissingRecommendationCopyWithImpl<MissingRecommendation>(this as MissingRecommendation, _$identity);

  /// Serializes this MissingRecommendation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MissingRecommendation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissingRecommendation&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.weight, _this.weight) || other.weight == _this.weight)&&(identical(other.actionRoute, _this.actionRoute) || other.actionRoute == _this.actionRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MissingRecommendation;
  return Object.hash(runtimeType,_this.key,_this.title,_this.description,_this.weight,_this.actionRoute);
}

@override
String toString() {
  final _this = this as MissingRecommendation;
  return 'MissingRecommendation(key: ${_this.key}, title: ${_this.title}, description: ${_this.description}, weight: ${_this.weight}, actionRoute: ${_this.actionRoute})';
}


}

/// @nodoc
abstract mixin class $MissingRecommendationCopyWith<$Res>  {
  factory $MissingRecommendationCopyWith(MissingRecommendation value, $Res Function(MissingRecommendation) _then) = _$MissingRecommendationCopyWithImpl;
@useResult
$Res call({
 String key, String title, String description, int weight, String actionRoute
});




}
/// @nodoc
class _$MissingRecommendationCopyWithImpl<$Res>
    implements $MissingRecommendationCopyWith<$Res> {
  _$MissingRecommendationCopyWithImpl(this._self, this._then);

  final MissingRecommendation _self;
  final $Res Function(MissingRecommendation) _then;

/// Create a copy of MissingRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? title = null,Object? description = null,Object? weight = null,Object? actionRoute = null,}) {
  return _then(MissingRecommendation(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,actionRoute: null == actionRoute ? _self.actionRoute : actionRoute // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MissingRecommendation].
extension MissingRecommendationPatterns on MissingRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissingRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissingRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissingRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _MissingRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissingRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _MissingRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String title,  String description,  int weight,  String actionRoute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissingRecommendation() when $default != null:
return $default(_that.key,_that.title,_that.description,_that.weight,_that.actionRoute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String title,  String description,  int weight,  String actionRoute)  $default,) {final _that = this;
switch (_that) {
case _MissingRecommendation():
return $default(_that.key,_that.title,_that.description,_that.weight,_that.actionRoute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String title,  String description,  int weight,  String actionRoute)?  $default,) {final _that = this;
switch (_that) {
case _MissingRecommendation() when $default != null:
return $default(_that.key,_that.title,_that.description,_that.weight,_that.actionRoute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissingRecommendation implements MissingRecommendation {
  const _MissingRecommendation({required this.key, required this.title, required this.description, required this.weight, required this.actionRoute});
  factory _MissingRecommendation.fromJson(Map<String, dynamic> json) => _$MissingRecommendationFromJson(json);

@override final  String key;
@override final  String title;
@override final  String description;
@override final  int weight;
@override final  String actionRoute;

/// Create a copy of MissingRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissingRecommendationCopyWith<_MissingRecommendation> get copyWith => __$MissingRecommendationCopyWithImpl<_MissingRecommendation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissingRecommendationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissingRecommendation&&(identical(other.key, key) || other.key == key)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.actionRoute, actionRoute) || other.actionRoute == actionRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,key,title,description,weight,actionRoute);
}

@override
String toString() {
    return 'MissingRecommendation(key: $key, title: $title, description: $description, weight: $weight, actionRoute: $actionRoute)';
}


}

/// @nodoc
abstract mixin class _$MissingRecommendationCopyWith<$Res> implements $MissingRecommendationCopyWith<$Res> {
  factory _$MissingRecommendationCopyWith(_MissingRecommendation value, $Res Function(_MissingRecommendation) _then) = __$MissingRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String key, String title, String description, int weight, String actionRoute
});




}
/// @nodoc
class __$MissingRecommendationCopyWithImpl<$Res>
    implements _$MissingRecommendationCopyWith<$Res> {
  __$MissingRecommendationCopyWithImpl(this._self, this._then);

  final _MissingRecommendation _self;
  final $Res Function(_MissingRecommendation) _then;

/// Create a copy of MissingRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? title = null,Object? description = null,Object? weight = null,Object? actionRoute = null,}) {
  return _then(_MissingRecommendation(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,actionRoute: null == actionRoute ? _self.actionRoute : actionRoute // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProfileCompletionReport {

 int get percentage; List<MissingRecommendation> get recommendations; Map<String, bool> get completedFields;
/// Create a copy of ProfileCompletionReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCompletionReportCopyWith<ProfileCompletionReport> get copyWith => _$ProfileCompletionReportCopyWithImpl<ProfileCompletionReport>(this as ProfileCompletionReport, _$identity);

  /// Serializes this ProfileCompletionReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileCompletionReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileCompletionReport&&(identical(other.percentage, _this.percentage) || other.percentage == _this.percentage)&&const DeepCollectionEquality().equals(other.recommendations, _this.recommendations)&&const DeepCollectionEquality().equals(other.completedFields, _this.completedFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileCompletionReport;
  return Object.hash(runtimeType,_this.percentage,const DeepCollectionEquality().hash(_this.recommendations),const DeepCollectionEquality().hash(_this.completedFields));
}

@override
String toString() {
  final _this = this as ProfileCompletionReport;
  return 'ProfileCompletionReport(percentage: ${_this.percentage}, recommendations: ${_this.recommendations}, completedFields: ${_this.completedFields})';
}


}

/// @nodoc
abstract mixin class $ProfileCompletionReportCopyWith<$Res>  {
  factory $ProfileCompletionReportCopyWith(ProfileCompletionReport value, $Res Function(ProfileCompletionReport) _then) = _$ProfileCompletionReportCopyWithImpl;
@useResult
$Res call({
 int percentage, List<MissingRecommendation> recommendations, Map<String, bool> completedFields
});




}
/// @nodoc
class _$ProfileCompletionReportCopyWithImpl<$Res>
    implements $ProfileCompletionReportCopyWith<$Res> {
  _$ProfileCompletionReportCopyWithImpl(this._self, this._then);

  final ProfileCompletionReport _self;
  final $Res Function(ProfileCompletionReport) _then;

/// Create a copy of ProfileCompletionReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? percentage = null,Object? recommendations = null,Object? completedFields = null,}) {
  return _then(ProfileCompletionReport(
percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<MissingRecommendation>,completedFields: null == completedFields ? _self.completedFields : completedFields // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileCompletionReport].
extension ProfileCompletionReportPatterns on ProfileCompletionReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileCompletionReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileCompletionReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileCompletionReport value)  $default,){
final _that = this;
switch (_that) {
case _ProfileCompletionReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileCompletionReport value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileCompletionReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int percentage,  List<MissingRecommendation> recommendations,  Map<String, bool> completedFields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileCompletionReport() when $default != null:
return $default(_that.percentage,_that.recommendations,_that.completedFields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int percentage,  List<MissingRecommendation> recommendations,  Map<String, bool> completedFields)  $default,) {final _that = this;
switch (_that) {
case _ProfileCompletionReport():
return $default(_that.percentage,_that.recommendations,_that.completedFields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int percentage,  List<MissingRecommendation> recommendations,  Map<String, bool> completedFields)?  $default,) {final _that = this;
switch (_that) {
case _ProfileCompletionReport() when $default != null:
return $default(_that.percentage,_that.recommendations,_that.completedFields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileCompletionReport implements ProfileCompletionReport {
  const _ProfileCompletionReport({required this.percentage, required  List<MissingRecommendation> recommendations, required  Map<String, bool> completedFields}): _recommendations = recommendations,_completedFields = completedFields;
  factory _ProfileCompletionReport.fromJson(Map<String, dynamic> json) => _$ProfileCompletionReportFromJson(json);

@override final  int percentage;
 final  List<MissingRecommendation> _recommendations;
@override List<MissingRecommendation> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}

 final  Map<String, bool> _completedFields;
@override Map<String, bool> get completedFields {
  if (_completedFields is EqualUnmodifiableMapView) return _completedFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_completedFields);
}


/// Create a copy of ProfileCompletionReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCompletionReportCopyWith<_ProfileCompletionReport> get copyWith => __$ProfileCompletionReportCopyWithImpl<_ProfileCompletionReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileCompletionReportToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileCompletionReport&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.recommendations, _recommendations)&&const DeepCollectionEquality().equals(other.completedFields, _completedFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,percentage,const DeepCollectionEquality().hash(_recommendations),const DeepCollectionEquality().hash(_completedFields));
}

@override
String toString() {
    return 'ProfileCompletionReport(percentage: $percentage, recommendations: $recommendations, completedFields: $completedFields)';
}


}

/// @nodoc
abstract mixin class _$ProfileCompletionReportCopyWith<$Res> implements $ProfileCompletionReportCopyWith<$Res> {
  factory _$ProfileCompletionReportCopyWith(_ProfileCompletionReport value, $Res Function(_ProfileCompletionReport) _then) = __$ProfileCompletionReportCopyWithImpl;
@override @useResult
$Res call({
 int percentage, List<MissingRecommendation> recommendations, Map<String, bool> completedFields
});




}
/// @nodoc
class __$ProfileCompletionReportCopyWithImpl<$Res>
    implements _$ProfileCompletionReportCopyWith<$Res> {
  __$ProfileCompletionReportCopyWithImpl(this._self, this._then);

  final _ProfileCompletionReport _self;
  final $Res Function(_ProfileCompletionReport) _then;

/// Create a copy of ProfileCompletionReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? percentage = null,Object? recommendations = null,Object? completedFields = null,}) {
  return _then(_ProfileCompletionReport(
percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<MissingRecommendation>,completedFields: null == completedFields ? _self._completedFields : completedFields // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}


}

// dart format on
