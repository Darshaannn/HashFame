// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PortfolioItem _$PortfolioItemFromJson(Map<String, dynamic> json) =>
    _PortfolioItem(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      platform: $enumDecodeNullable(_$SocialPlatformEnumMap, json['platform']),
      contentUrl: json['content_url'] as String?,
      mediaPath: json['media_path'] as String?,
      brandName: json['brand_name'] as String?,
      publishedDate: json['published_date'] == null
          ? null
          : DateTime.parse(json['published_date'] as String),
      contentType:
          $enumDecodeNullable(
            _$PortfolioContentTypeEnumMap,
            json['content_type'],
          ) ??
          PortfolioContentType.video,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PortfolioItemToJson(_PortfolioItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'platform': _$SocialPlatformEnumMap[instance.platform],
      'content_url': instance.contentUrl,
      'media_path': instance.mediaPath,
      'brand_name': instance.brandName,
      'published_date': instance.publishedDate?.toIso8601String(),
      'content_type': _$PortfolioContentTypeEnumMap[instance.contentType]!,
      'sort_order': instance.sortOrder,
    };

const _$SocialPlatformEnumMap = {
  SocialPlatform.instagram: 'instagram',
  SocialPlatform.youtube: 'youtube',
  SocialPlatform.facebook: 'facebook',
  SocialPlatform.x: 'x',
  SocialPlatform.linkedin: 'linkedin',
  SocialPlatform.other: 'other',
};

const _$PortfolioContentTypeEnumMap = {
  PortfolioContentType.video: 'video',
  PortfolioContentType.image: 'image',
  PortfolioContentType.article: 'article',
  PortfolioContentType.campaign: 'campaign',
  PortfolioContentType.other: 'other',
};
