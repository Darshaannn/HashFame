import 'package:freezed_annotation/freezed_annotation.dart';

import 'social_account.dart';

part 'portfolio.freezed.dart';
part 'portfolio.g.dart';

enum PortfolioContentType {
  video,
  image,
  article,
  campaign,
  other;

  String get label => switch (this) {
    video => 'Video / Reel',
    image => 'Photo / Post',
    article => 'Article / Blog',
    campaign => 'Campaign Showcase',
    other => 'Other Format',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class PortfolioItem with _$PortfolioItem {
  const factory PortfolioItem({
    required String id,
    required String userId,
    required String title,
    String? description,
    SocialPlatform? platform,
    String? contentUrl,
    String? mediaPath,
    String? brandName,
    DateTime? publishedDate,
    @Default(PortfolioContentType.video) PortfolioContentType contentType,
    @Default(0) int sortOrder,
  }) = _PortfolioItem;

  factory PortfolioItem.fromJson(Map<String, dynamic> json) =>
      _$PortfolioItemFromJson(json);
}
