// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RateItem _$RateItemFromJson(Map<String, dynamic> json) => _RateItem(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  deliverableType: $enumDecode(
    _$DeliverableTypeEnumMap,
    json['deliverable_type'],
  ),
  customTitle: json['custom_title'] as String?,
  priceAmount: (json['price_amount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'INR',
  description: json['description'] as String?,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$RateItemToJson(_RateItem instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'deliverable_type': _$DeliverableTypeEnumMap[instance.deliverableType]!,
  'custom_title': instance.customTitle,
  'price_amount': instance.priceAmount,
  'currency': instance.currency,
  'description': instance.description,
  'is_active': instance.isActive,
};

const _$DeliverableTypeEnumMap = {
  DeliverableType.instagramReel: 'instagram_reel',
  DeliverableType.instagramStory: 'instagram_story',
  DeliverableType.instagramPost: 'instagram_post',
  DeliverableType.youtubeVideo: 'youtube_video',
  DeliverableType.youtubeIntegration: 'youtube_integration',
  DeliverableType.youtubeShort: 'youtube_short',
  DeliverableType.ugcVideo: 'ugc_video',
  DeliverableType.other: 'other',
};
