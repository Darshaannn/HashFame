// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_collaboration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollaborationDeliverableSubmission {

 String get id; String get collaborationId; String get deliverableTitle; String get contentLink; String? get creatorNotes; DeliverableSubmissionStatus get status; String? get feedback; DateTime get submittedAt; DateTime? get reviewedAt; String? get reviewedBy; int get version;
/// Create a copy of CollaborationDeliverableSubmission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollaborationDeliverableSubmissionCopyWith<CollaborationDeliverableSubmission> get copyWith => _$CollaborationDeliverableSubmissionCopyWithImpl<CollaborationDeliverableSubmission>(this as CollaborationDeliverableSubmission, _$identity);

  /// Serializes this CollaborationDeliverableSubmission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CollaborationDeliverableSubmission;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollaborationDeliverableSubmission&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.collaborationId, _this.collaborationId) || other.collaborationId == _this.collaborationId)&&(identical(other.deliverableTitle, _this.deliverableTitle) || other.deliverableTitle == _this.deliverableTitle)&&(identical(other.contentLink, _this.contentLink) || other.contentLink == _this.contentLink)&&(identical(other.creatorNotes, _this.creatorNotes) || other.creatorNotes == _this.creatorNotes)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.submittedAt, _this.submittedAt) || other.submittedAt == _this.submittedAt)&&(identical(other.reviewedAt, _this.reviewedAt) || other.reviewedAt == _this.reviewedAt)&&(identical(other.reviewedBy, _this.reviewedBy) || other.reviewedBy == _this.reviewedBy)&&(identical(other.version, _this.version) || other.version == _this.version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CollaborationDeliverableSubmission;
  return Object.hash(runtimeType,_this.id,_this.collaborationId,_this.deliverableTitle,_this.contentLink,_this.creatorNotes,_this.status,_this.feedback,_this.submittedAt,_this.reviewedAt,_this.reviewedBy,_this.version);
}

@override
String toString() {
  final _this = this as CollaborationDeliverableSubmission;
  return 'CollaborationDeliverableSubmission(id: ${_this.id}, collaborationId: ${_this.collaborationId}, deliverableTitle: ${_this.deliverableTitle}, contentLink: ${_this.contentLink}, creatorNotes: ${_this.creatorNotes}, status: ${_this.status}, feedback: ${_this.feedback}, submittedAt: ${_this.submittedAt}, reviewedAt: ${_this.reviewedAt}, reviewedBy: ${_this.reviewedBy}, version: ${_this.version})';
}


}

/// @nodoc
abstract mixin class $CollaborationDeliverableSubmissionCopyWith<$Res>  {
  factory $CollaborationDeliverableSubmissionCopyWith(CollaborationDeliverableSubmission value, $Res Function(CollaborationDeliverableSubmission) _then) = _$CollaborationDeliverableSubmissionCopyWithImpl;
@useResult
$Res call({
 String id, String collaborationId, String deliverableTitle, String contentLink, String? creatorNotes, DeliverableSubmissionStatus status, String? feedback, DateTime submittedAt, DateTime? reviewedAt, String? reviewedBy, int version
});




}
/// @nodoc
class _$CollaborationDeliverableSubmissionCopyWithImpl<$Res>
    implements $CollaborationDeliverableSubmissionCopyWith<$Res> {
  _$CollaborationDeliverableSubmissionCopyWithImpl(this._self, this._then);

  final CollaborationDeliverableSubmission _self;
  final $Res Function(CollaborationDeliverableSubmission) _then;

/// Create a copy of CollaborationDeliverableSubmission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? collaborationId = null,Object? deliverableTitle = null,Object? contentLink = null,Object? creatorNotes = freezed,Object? status = null,Object? feedback = freezed,Object? submittedAt = null,Object? reviewedAt = freezed,Object? reviewedBy = freezed,Object? version = null,}) {
  return _then(CollaborationDeliverableSubmission(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collaborationId: null == collaborationId ? _self.collaborationId : collaborationId // ignore: cast_nullable_to_non_nullable
as String,deliverableTitle: null == deliverableTitle ? _self.deliverableTitle : deliverableTitle // ignore: cast_nullable_to_non_nullable
as String,contentLink: null == contentLink ? _self.contentLink : contentLink // ignore: cast_nullable_to_non_nullable
as String,creatorNotes: freezed == creatorNotes ? _self.creatorNotes : creatorNotes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliverableSubmissionStatus,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CollaborationDeliverableSubmission].
extension CollaborationDeliverableSubmissionPatterns on CollaborationDeliverableSubmission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollaborationDeliverableSubmission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollaborationDeliverableSubmission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollaborationDeliverableSubmission value)  $default,){
final _that = this;
switch (_that) {
case _CollaborationDeliverableSubmission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollaborationDeliverableSubmission value)?  $default,){
final _that = this;
switch (_that) {
case _CollaborationDeliverableSubmission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String collaborationId,  String deliverableTitle,  String contentLink,  String? creatorNotes,  DeliverableSubmissionStatus status,  String? feedback,  DateTime submittedAt,  DateTime? reviewedAt,  String? reviewedBy,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollaborationDeliverableSubmission() when $default != null:
return $default(_that.id,_that.collaborationId,_that.deliverableTitle,_that.contentLink,_that.creatorNotes,_that.status,_that.feedback,_that.submittedAt,_that.reviewedAt,_that.reviewedBy,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String collaborationId,  String deliverableTitle,  String contentLink,  String? creatorNotes,  DeliverableSubmissionStatus status,  String? feedback,  DateTime submittedAt,  DateTime? reviewedAt,  String? reviewedBy,  int version)  $default,) {final _that = this;
switch (_that) {
case _CollaborationDeliverableSubmission():
return $default(_that.id,_that.collaborationId,_that.deliverableTitle,_that.contentLink,_that.creatorNotes,_that.status,_that.feedback,_that.submittedAt,_that.reviewedAt,_that.reviewedBy,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String collaborationId,  String deliverableTitle,  String contentLink,  String? creatorNotes,  DeliverableSubmissionStatus status,  String? feedback,  DateTime submittedAt,  DateTime? reviewedAt,  String? reviewedBy,  int version)?  $default,) {final _that = this;
switch (_that) {
case _CollaborationDeliverableSubmission() when $default != null:
return $default(_that.id,_that.collaborationId,_that.deliverableTitle,_that.contentLink,_that.creatorNotes,_that.status,_that.feedback,_that.submittedAt,_that.reviewedAt,_that.reviewedBy,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollaborationDeliverableSubmission implements CollaborationDeliverableSubmission {
  const _CollaborationDeliverableSubmission({required this.id, required this.collaborationId, required this.deliverableTitle, required this.contentLink, this.creatorNotes, this.status = DeliverableSubmissionStatus.submitted, this.feedback, required this.submittedAt, this.reviewedAt, this.reviewedBy, this.version = 1});
  factory _CollaborationDeliverableSubmission.fromJson(Map<String, dynamic> json) => _$CollaborationDeliverableSubmissionFromJson(json);

@override final  String id;
@override final  String collaborationId;
@override final  String deliverableTitle;
@override final  String contentLink;
@override final  String? creatorNotes;
@override@JsonKey() final  DeliverableSubmissionStatus status;
@override final  String? feedback;
@override final  DateTime submittedAt;
@override final  DateTime? reviewedAt;
@override final  String? reviewedBy;
@override@JsonKey() final  int version;

/// Create a copy of CollaborationDeliverableSubmission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollaborationDeliverableSubmissionCopyWith<_CollaborationDeliverableSubmission> get copyWith => __$CollaborationDeliverableSubmissionCopyWithImpl<_CollaborationDeliverableSubmission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollaborationDeliverableSubmissionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollaborationDeliverableSubmission&&(identical(other.id, id) || other.id == id)&&(identical(other.collaborationId, collaborationId) || other.collaborationId == collaborationId)&&(identical(other.deliverableTitle, deliverableTitle) || other.deliverableTitle == deliverableTitle)&&(identical(other.contentLink, contentLink) || other.contentLink == contentLink)&&(identical(other.creatorNotes, creatorNotes) || other.creatorNotes == creatorNotes)&&(identical(other.status, status) || other.status == status)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,collaborationId,deliverableTitle,contentLink,creatorNotes,status,feedback,submittedAt,reviewedAt,reviewedBy,version);
}

@override
String toString() {
    return 'CollaborationDeliverableSubmission(id: $id, collaborationId: $collaborationId, deliverableTitle: $deliverableTitle, contentLink: $contentLink, creatorNotes: $creatorNotes, status: $status, feedback: $feedback, submittedAt: $submittedAt, reviewedAt: $reviewedAt, reviewedBy: $reviewedBy, version: $version)';
}


}

/// @nodoc
abstract mixin class _$CollaborationDeliverableSubmissionCopyWith<$Res> implements $CollaborationDeliverableSubmissionCopyWith<$Res> {
  factory _$CollaborationDeliverableSubmissionCopyWith(_CollaborationDeliverableSubmission value, $Res Function(_CollaborationDeliverableSubmission) _then) = __$CollaborationDeliverableSubmissionCopyWithImpl;
@override @useResult
$Res call({
 String id, String collaborationId, String deliverableTitle, String contentLink, String? creatorNotes, DeliverableSubmissionStatus status, String? feedback, DateTime submittedAt, DateTime? reviewedAt, String? reviewedBy, int version
});




}
/// @nodoc
class __$CollaborationDeliverableSubmissionCopyWithImpl<$Res>
    implements _$CollaborationDeliverableSubmissionCopyWith<$Res> {
  __$CollaborationDeliverableSubmissionCopyWithImpl(this._self, this._then);

  final _CollaborationDeliverableSubmission _self;
  final $Res Function(_CollaborationDeliverableSubmission) _then;

/// Create a copy of CollaborationDeliverableSubmission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? collaborationId = null,Object? deliverableTitle = null,Object? contentLink = null,Object? creatorNotes = freezed,Object? status = null,Object? feedback = freezed,Object? submittedAt = null,Object? reviewedAt = freezed,Object? reviewedBy = freezed,Object? version = null,}) {
  return _then(_CollaborationDeliverableSubmission(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collaborationId: null == collaborationId ? _self.collaborationId : collaborationId // ignore: cast_nullable_to_non_nullable
as String,deliverableTitle: null == deliverableTitle ? _self.deliverableTitle : deliverableTitle // ignore: cast_nullable_to_non_nullable
as String,contentLink: null == contentLink ? _self.contentLink : contentLink // ignore: cast_nullable_to_non_nullable
as String,creatorNotes: freezed == creatorNotes ? _self.creatorNotes : creatorNotes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliverableSubmissionStatus,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CollaborationMessage {

 String get id; String get collaborationId; String get senderId; String get senderName; String get content; DateTime? get readAt; DateTime get createdAt; bool get isMine;
/// Create a copy of CollaborationMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollaborationMessageCopyWith<CollaborationMessage> get copyWith => _$CollaborationMessageCopyWithImpl<CollaborationMessage>(this as CollaborationMessage, _$identity);

  /// Serializes this CollaborationMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CollaborationMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollaborationMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.collaborationId, _this.collaborationId) || other.collaborationId == _this.collaborationId)&&(identical(other.senderId, _this.senderId) || other.senderId == _this.senderId)&&(identical(other.senderName, _this.senderName) || other.senderName == _this.senderName)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.readAt, _this.readAt) || other.readAt == _this.readAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.isMine, _this.isMine) || other.isMine == _this.isMine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CollaborationMessage;
  return Object.hash(runtimeType,_this.id,_this.collaborationId,_this.senderId,_this.senderName,_this.content,_this.readAt,_this.createdAt,_this.isMine);
}

@override
String toString() {
  final _this = this as CollaborationMessage;
  return 'CollaborationMessage(id: ${_this.id}, collaborationId: ${_this.collaborationId}, senderId: ${_this.senderId}, senderName: ${_this.senderName}, content: ${_this.content}, readAt: ${_this.readAt}, createdAt: ${_this.createdAt}, isMine: ${_this.isMine})';
}


}

/// @nodoc
abstract mixin class $CollaborationMessageCopyWith<$Res>  {
  factory $CollaborationMessageCopyWith(CollaborationMessage value, $Res Function(CollaborationMessage) _then) = _$CollaborationMessageCopyWithImpl;
@useResult
$Res call({
 String id, String collaborationId, String senderId, String senderName, String content, DateTime? readAt, DateTime createdAt, bool isMine
});




}
/// @nodoc
class _$CollaborationMessageCopyWithImpl<$Res>
    implements $CollaborationMessageCopyWith<$Res> {
  _$CollaborationMessageCopyWithImpl(this._self, this._then);

  final CollaborationMessage _self;
  final $Res Function(CollaborationMessage) _then;

/// Create a copy of CollaborationMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? collaborationId = null,Object? senderId = null,Object? senderName = null,Object? content = null,Object? readAt = freezed,Object? createdAt = null,Object? isMine = null,}) {
  return _then(CollaborationMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collaborationId: null == collaborationId ? _self.collaborationId : collaborationId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CollaborationMessage].
extension CollaborationMessagePatterns on CollaborationMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollaborationMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollaborationMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollaborationMessage value)  $default,){
final _that = this;
switch (_that) {
case _CollaborationMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollaborationMessage value)?  $default,){
final _that = this;
switch (_that) {
case _CollaborationMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String collaborationId,  String senderId,  String senderName,  String content,  DateTime? readAt,  DateTime createdAt,  bool isMine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollaborationMessage() when $default != null:
return $default(_that.id,_that.collaborationId,_that.senderId,_that.senderName,_that.content,_that.readAt,_that.createdAt,_that.isMine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String collaborationId,  String senderId,  String senderName,  String content,  DateTime? readAt,  DateTime createdAt,  bool isMine)  $default,) {final _that = this;
switch (_that) {
case _CollaborationMessage():
return $default(_that.id,_that.collaborationId,_that.senderId,_that.senderName,_that.content,_that.readAt,_that.createdAt,_that.isMine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String collaborationId,  String senderId,  String senderName,  String content,  DateTime? readAt,  DateTime createdAt,  bool isMine)?  $default,) {final _that = this;
switch (_that) {
case _CollaborationMessage() when $default != null:
return $default(_that.id,_that.collaborationId,_that.senderId,_that.senderName,_that.content,_that.readAt,_that.createdAt,_that.isMine);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollaborationMessage implements CollaborationMessage {
  const _CollaborationMessage({required this.id, required this.collaborationId, required this.senderId, required this.senderName, required this.content, this.readAt, required this.createdAt, this.isMine = false});
  factory _CollaborationMessage.fromJson(Map<String, dynamic> json) => _$CollaborationMessageFromJson(json);

@override final  String id;
@override final  String collaborationId;
@override final  String senderId;
@override final  String senderName;
@override final  String content;
@override final  DateTime? readAt;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isMine;

/// Create a copy of CollaborationMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollaborationMessageCopyWith<_CollaborationMessage> get copyWith => __$CollaborationMessageCopyWithImpl<_CollaborationMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollaborationMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollaborationMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.collaborationId, collaborationId) || other.collaborationId == collaborationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.content, content) || other.content == content)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isMine, isMine) || other.isMine == isMine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,collaborationId,senderId,senderName,content,readAt,createdAt,isMine);
}

@override
String toString() {
    return 'CollaborationMessage(id: $id, collaborationId: $collaborationId, senderId: $senderId, senderName: $senderName, content: $content, readAt: $readAt, createdAt: $createdAt, isMine: $isMine)';
}


}

/// @nodoc
abstract mixin class _$CollaborationMessageCopyWith<$Res> implements $CollaborationMessageCopyWith<$Res> {
  factory _$CollaborationMessageCopyWith(_CollaborationMessage value, $Res Function(_CollaborationMessage) _then) = __$CollaborationMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String collaborationId, String senderId, String senderName, String content, DateTime? readAt, DateTime createdAt, bool isMine
});




}
/// @nodoc
class __$CollaborationMessageCopyWithImpl<$Res>
    implements _$CollaborationMessageCopyWith<$Res> {
  __$CollaborationMessageCopyWithImpl(this._self, this._then);

  final _CollaborationMessage _self;
  final $Res Function(_CollaborationMessage) _then;

/// Create a copy of CollaborationMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? collaborationId = null,Object? senderId = null,Object? senderName = null,Object? content = null,Object? readAt = freezed,Object? createdAt = null,Object? isMine = null,}) {
  return _then(_CollaborationMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collaborationId: null == collaborationId ? _self.collaborationId : collaborationId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ActiveCollaboration {

 String get id; String get organizationId; String get campaignId; String get applicationId; String get creatorId; ActiveCollaborationStatus get status; double? get compensationAmount; String get currency; DateTime? get dueDate; DateTime? get completedAt; DateTime? get cancelledAt; String? get cancellationReason; DateTime get createdAt; DateTime? get updatedAt; String? get campaignTitle; String? get brandName; String? get brandLogoUrl; String? get creatorDisplayName; String? get creatorAvatarPath; String? get creatorCity; List<String> get deliverableRequirements; List<CollaborationDeliverableSubmission> get submissions; List<CollaborationMessage> get messages;
/// Create a copy of ActiveCollaboration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveCollaborationCopyWith<ActiveCollaboration> get copyWith => _$ActiveCollaborationCopyWithImpl<ActiveCollaboration>(this as ActiveCollaboration, _$identity);

  /// Serializes this ActiveCollaboration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActiveCollaboration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveCollaboration&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.campaignId, _this.campaignId) || other.campaignId == _this.campaignId)&&(identical(other.applicationId, _this.applicationId) || other.applicationId == _this.applicationId)&&(identical(other.creatorId, _this.creatorId) || other.creatorId == _this.creatorId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.compensationAmount, _this.compensationAmount) || other.compensationAmount == _this.compensationAmount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.cancelledAt, _this.cancelledAt) || other.cancelledAt == _this.cancelledAt)&&(identical(other.cancellationReason, _this.cancellationReason) || other.cancellationReason == _this.cancellationReason)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.campaignTitle, _this.campaignTitle) || other.campaignTitle == _this.campaignTitle)&&(identical(other.brandName, _this.brandName) || other.brandName == _this.brandName)&&(identical(other.brandLogoUrl, _this.brandLogoUrl) || other.brandLogoUrl == _this.brandLogoUrl)&&(identical(other.creatorDisplayName, _this.creatorDisplayName) || other.creatorDisplayName == _this.creatorDisplayName)&&(identical(other.creatorAvatarPath, _this.creatorAvatarPath) || other.creatorAvatarPath == _this.creatorAvatarPath)&&(identical(other.creatorCity, _this.creatorCity) || other.creatorCity == _this.creatorCity)&&const DeepCollectionEquality().equals(other.deliverableRequirements, _this.deliverableRequirements)&&const DeepCollectionEquality().equals(other.submissions, _this.submissions)&&const DeepCollectionEquality().equals(other.messages, _this.messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActiveCollaboration;
  return Object.hashAll([runtimeType,_this.id,_this.organizationId,_this.campaignId,_this.applicationId,_this.creatorId,_this.status,_this.compensationAmount,_this.currency,_this.dueDate,_this.completedAt,_this.cancelledAt,_this.cancellationReason,_this.createdAt,_this.updatedAt,_this.campaignTitle,_this.brandName,_this.brandLogoUrl,_this.creatorDisplayName,_this.creatorAvatarPath,_this.creatorCity,const DeepCollectionEquality().hash(_this.deliverableRequirements),const DeepCollectionEquality().hash(_this.submissions),const DeepCollectionEquality().hash(_this.messages)]);
}

@override
String toString() {
  final _this = this as ActiveCollaboration;
  return 'ActiveCollaboration(id: ${_this.id}, organizationId: ${_this.organizationId}, campaignId: ${_this.campaignId}, applicationId: ${_this.applicationId}, creatorId: ${_this.creatorId}, status: ${_this.status}, compensationAmount: ${_this.compensationAmount}, currency: ${_this.currency}, dueDate: ${_this.dueDate}, completedAt: ${_this.completedAt}, cancelledAt: ${_this.cancelledAt}, cancellationReason: ${_this.cancellationReason}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, campaignTitle: ${_this.campaignTitle}, brandName: ${_this.brandName}, brandLogoUrl: ${_this.brandLogoUrl}, creatorDisplayName: ${_this.creatorDisplayName}, creatorAvatarPath: ${_this.creatorAvatarPath}, creatorCity: ${_this.creatorCity}, deliverableRequirements: ${_this.deliverableRequirements}, submissions: ${_this.submissions}, messages: ${_this.messages})';
}


}

/// @nodoc
abstract mixin class $ActiveCollaborationCopyWith<$Res>  {
  factory $ActiveCollaborationCopyWith(ActiveCollaboration value, $Res Function(ActiveCollaboration) _then) = _$ActiveCollaborationCopyWithImpl;
@useResult
$Res call({
 String id, String organizationId, String campaignId, String applicationId, String creatorId, ActiveCollaborationStatus status, double? compensationAmount, String currency, DateTime? dueDate, DateTime? completedAt, DateTime? cancelledAt, String? cancellationReason, DateTime createdAt, DateTime? updatedAt, String? campaignTitle, String? brandName, String? brandLogoUrl, String? creatorDisplayName, String? creatorAvatarPath, String? creatorCity, List<String> deliverableRequirements, List<CollaborationDeliverableSubmission> submissions, List<CollaborationMessage> messages
});




}
/// @nodoc
class _$ActiveCollaborationCopyWithImpl<$Res>
    implements $ActiveCollaborationCopyWith<$Res> {
  _$ActiveCollaborationCopyWithImpl(this._self, this._then);

  final ActiveCollaboration _self;
  final $Res Function(ActiveCollaboration) _then;

/// Create a copy of ActiveCollaboration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organizationId = null,Object? campaignId = null,Object? applicationId = null,Object? creatorId = null,Object? status = null,Object? compensationAmount = freezed,Object? currency = null,Object? dueDate = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? cancellationReason = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? campaignTitle = freezed,Object? brandName = freezed,Object? brandLogoUrl = freezed,Object? creatorDisplayName = freezed,Object? creatorAvatarPath = freezed,Object? creatorCity = freezed,Object? deliverableRequirements = null,Object? submissions = null,Object? messages = null,}) {
  return _then(ActiveCollaboration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActiveCollaborationStatus,compensationAmount: freezed == compensationAmount ? _self.compensationAmount : compensationAmount // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,creatorDisplayName: freezed == creatorDisplayName ? _self.creatorDisplayName : creatorDisplayName // ignore: cast_nullable_to_non_nullable
as String?,creatorAvatarPath: freezed == creatorAvatarPath ? _self.creatorAvatarPath : creatorAvatarPath // ignore: cast_nullable_to_non_nullable
as String?,creatorCity: freezed == creatorCity ? _self.creatorCity : creatorCity // ignore: cast_nullable_to_non_nullable
as String?,deliverableRequirements: null == deliverableRequirements ? _self.deliverableRequirements : deliverableRequirements // ignore: cast_nullable_to_non_nullable
as List<String>,submissions: null == submissions ? _self.submissions : submissions // ignore: cast_nullable_to_non_nullable
as List<CollaborationDeliverableSubmission>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<CollaborationMessage>,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveCollaboration].
extension ActiveCollaborationPatterns on ActiveCollaboration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveCollaboration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveCollaboration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveCollaboration value)  $default,){
final _that = this;
switch (_that) {
case _ActiveCollaboration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveCollaboration value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveCollaboration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String organizationId,  String campaignId,  String applicationId,  String creatorId,  ActiveCollaborationStatus status,  double? compensationAmount,  String currency,  DateTime? dueDate,  DateTime? completedAt,  DateTime? cancelledAt,  String? cancellationReason,  DateTime createdAt,  DateTime? updatedAt,  String? campaignTitle,  String? brandName,  String? brandLogoUrl,  String? creatorDisplayName,  String? creatorAvatarPath,  String? creatorCity,  List<String> deliverableRequirements,  List<CollaborationDeliverableSubmission> submissions,  List<CollaborationMessage> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveCollaboration() when $default != null:
return $default(_that.id,_that.organizationId,_that.campaignId,_that.applicationId,_that.creatorId,_that.status,_that.compensationAmount,_that.currency,_that.dueDate,_that.completedAt,_that.cancelledAt,_that.cancellationReason,_that.createdAt,_that.updatedAt,_that.campaignTitle,_that.brandName,_that.brandLogoUrl,_that.creatorDisplayName,_that.creatorAvatarPath,_that.creatorCity,_that.deliverableRequirements,_that.submissions,_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String organizationId,  String campaignId,  String applicationId,  String creatorId,  ActiveCollaborationStatus status,  double? compensationAmount,  String currency,  DateTime? dueDate,  DateTime? completedAt,  DateTime? cancelledAt,  String? cancellationReason,  DateTime createdAt,  DateTime? updatedAt,  String? campaignTitle,  String? brandName,  String? brandLogoUrl,  String? creatorDisplayName,  String? creatorAvatarPath,  String? creatorCity,  List<String> deliverableRequirements,  List<CollaborationDeliverableSubmission> submissions,  List<CollaborationMessage> messages)  $default,) {final _that = this;
switch (_that) {
case _ActiveCollaboration():
return $default(_that.id,_that.organizationId,_that.campaignId,_that.applicationId,_that.creatorId,_that.status,_that.compensationAmount,_that.currency,_that.dueDate,_that.completedAt,_that.cancelledAt,_that.cancellationReason,_that.createdAt,_that.updatedAt,_that.campaignTitle,_that.brandName,_that.brandLogoUrl,_that.creatorDisplayName,_that.creatorAvatarPath,_that.creatorCity,_that.deliverableRequirements,_that.submissions,_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String organizationId,  String campaignId,  String applicationId,  String creatorId,  ActiveCollaborationStatus status,  double? compensationAmount,  String currency,  DateTime? dueDate,  DateTime? completedAt,  DateTime? cancelledAt,  String? cancellationReason,  DateTime createdAt,  DateTime? updatedAt,  String? campaignTitle,  String? brandName,  String? brandLogoUrl,  String? creatorDisplayName,  String? creatorAvatarPath,  String? creatorCity,  List<String> deliverableRequirements,  List<CollaborationDeliverableSubmission> submissions,  List<CollaborationMessage> messages)?  $default,) {final _that = this;
switch (_that) {
case _ActiveCollaboration() when $default != null:
return $default(_that.id,_that.organizationId,_that.campaignId,_that.applicationId,_that.creatorId,_that.status,_that.compensationAmount,_that.currency,_that.dueDate,_that.completedAt,_that.cancelledAt,_that.cancellationReason,_that.createdAt,_that.updatedAt,_that.campaignTitle,_that.brandName,_that.brandLogoUrl,_that.creatorDisplayName,_that.creatorAvatarPath,_that.creatorCity,_that.deliverableRequirements,_that.submissions,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveCollaboration implements ActiveCollaboration {
  const _ActiveCollaboration({required this.id, required this.organizationId, required this.campaignId, required this.applicationId, required this.creatorId, this.status = ActiveCollaborationStatus.active, this.compensationAmount, this.currency = 'INR', this.dueDate, this.completedAt, this.cancelledAt, this.cancellationReason, required this.createdAt, this.updatedAt, this.campaignTitle, this.brandName, this.brandLogoUrl, this.creatorDisplayName, this.creatorAvatarPath, this.creatorCity,  List<String> deliverableRequirements = const [],  List<CollaborationDeliverableSubmission> submissions = const [],  List<CollaborationMessage> messages = const []}): _deliverableRequirements = deliverableRequirements,_submissions = submissions,_messages = messages;
  factory _ActiveCollaboration.fromJson(Map<String, dynamic> json) => _$ActiveCollaborationFromJson(json);

@override final  String id;
@override final  String organizationId;
@override final  String campaignId;
@override final  String applicationId;
@override final  String creatorId;
@override@JsonKey() final  ActiveCollaborationStatus status;
@override final  double? compensationAmount;
@override@JsonKey() final  String currency;
@override final  DateTime? dueDate;
@override final  DateTime? completedAt;
@override final  DateTime? cancelledAt;
@override final  String? cancellationReason;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override final  String? campaignTitle;
@override final  String? brandName;
@override final  String? brandLogoUrl;
@override final  String? creatorDisplayName;
@override final  String? creatorAvatarPath;
@override final  String? creatorCity;
 final  List<String> _deliverableRequirements;
@override@JsonKey() List<String> get deliverableRequirements {
  if (_deliverableRequirements is EqualUnmodifiableListView) return _deliverableRequirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deliverableRequirements);
}

 final  List<CollaborationDeliverableSubmission> _submissions;
@override@JsonKey() List<CollaborationDeliverableSubmission> get submissions {
  if (_submissions is EqualUnmodifiableListView) return _submissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_submissions);
}

 final  List<CollaborationMessage> _messages;
@override@JsonKey() List<CollaborationMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ActiveCollaboration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveCollaborationCopyWith<_ActiveCollaboration> get copyWith => __$ActiveCollaborationCopyWithImpl<_ActiveCollaboration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveCollaborationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveCollaboration&&(identical(other.id, id) || other.id == id)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.compensationAmount, compensationAmount) || other.compensationAmount == compensationAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignTitle, campaignTitle) || other.campaignTitle == campaignTitle)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.creatorDisplayName, creatorDisplayName) || other.creatorDisplayName == creatorDisplayName)&&(identical(other.creatorAvatarPath, creatorAvatarPath) || other.creatorAvatarPath == creatorAvatarPath)&&(identical(other.creatorCity, creatorCity) || other.creatorCity == creatorCity)&&const DeepCollectionEquality().equals(other.deliverableRequirements, _deliverableRequirements)&&const DeepCollectionEquality().equals(other.submissions, _submissions)&&const DeepCollectionEquality().equals(other.messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,organizationId,campaignId,applicationId,creatorId,status,compensationAmount,currency,dueDate,completedAt,cancelledAt,cancellationReason,createdAt,updatedAt,campaignTitle,brandName,brandLogoUrl,creatorDisplayName,creatorAvatarPath,creatorCity,const DeepCollectionEquality().hash(_deliverableRequirements),const DeepCollectionEquality().hash(_submissions),const DeepCollectionEquality().hash(_messages)]);
}

@override
String toString() {
    return 'ActiveCollaboration(id: $id, organizationId: $organizationId, campaignId: $campaignId, applicationId: $applicationId, creatorId: $creatorId, status: $status, compensationAmount: $compensationAmount, currency: $currency, dueDate: $dueDate, completedAt: $completedAt, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason, createdAt: $createdAt, updatedAt: $updatedAt, campaignTitle: $campaignTitle, brandName: $brandName, brandLogoUrl: $brandLogoUrl, creatorDisplayName: $creatorDisplayName, creatorAvatarPath: $creatorAvatarPath, creatorCity: $creatorCity, deliverableRequirements: $deliverableRequirements, submissions: $submissions, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ActiveCollaborationCopyWith<$Res> implements $ActiveCollaborationCopyWith<$Res> {
  factory _$ActiveCollaborationCopyWith(_ActiveCollaboration value, $Res Function(_ActiveCollaboration) _then) = __$ActiveCollaborationCopyWithImpl;
@override @useResult
$Res call({
 String id, String organizationId, String campaignId, String applicationId, String creatorId, ActiveCollaborationStatus status, double? compensationAmount, String currency, DateTime? dueDate, DateTime? completedAt, DateTime? cancelledAt, String? cancellationReason, DateTime createdAt, DateTime? updatedAt, String? campaignTitle, String? brandName, String? brandLogoUrl, String? creatorDisplayName, String? creatorAvatarPath, String? creatorCity, List<String> deliverableRequirements, List<CollaborationDeliverableSubmission> submissions, List<CollaborationMessage> messages
});




}
/// @nodoc
class __$ActiveCollaborationCopyWithImpl<$Res>
    implements _$ActiveCollaborationCopyWith<$Res> {
  __$ActiveCollaborationCopyWithImpl(this._self, this._then);

  final _ActiveCollaboration _self;
  final $Res Function(_ActiveCollaboration) _then;

/// Create a copy of ActiveCollaboration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organizationId = null,Object? campaignId = null,Object? applicationId = null,Object? creatorId = null,Object? status = null,Object? compensationAmount = freezed,Object? currency = null,Object? dueDate = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? cancellationReason = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? campaignTitle = freezed,Object? brandName = freezed,Object? brandLogoUrl = freezed,Object? creatorDisplayName = freezed,Object? creatorAvatarPath = freezed,Object? creatorCity = freezed,Object? deliverableRequirements = null,Object? submissions = null,Object? messages = null,}) {
  return _then(_ActiveCollaboration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActiveCollaborationStatus,compensationAmount: freezed == compensationAmount ? _self.compensationAmount : compensationAmount // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,creatorDisplayName: freezed == creatorDisplayName ? _self.creatorDisplayName : creatorDisplayName // ignore: cast_nullable_to_non_nullable
as String?,creatorAvatarPath: freezed == creatorAvatarPath ? _self.creatorAvatarPath : creatorAvatarPath // ignore: cast_nullable_to_non_nullable
as String?,creatorCity: freezed == creatorCity ? _self.creatorCity : creatorCity // ignore: cast_nullable_to_non_nullable
as String?,deliverableRequirements: null == deliverableRequirements ? _self._deliverableRequirements : deliverableRequirements // ignore: cast_nullable_to_non_nullable
as List<String>,submissions: null == submissions ? _self._submissions : submissions // ignore: cast_nullable_to_non_nullable
as List<CollaborationDeliverableSubmission>,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<CollaborationMessage>,
  ));
}


}

// dart format on
