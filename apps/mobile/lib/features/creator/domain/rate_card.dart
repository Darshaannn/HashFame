import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_card.freezed.dart';
part 'rate_card.g.dart';

enum DeliverableType {
  @JsonValue('instagram_reel')
  instagramReel,
  @JsonValue('instagram_story')
  instagramStory,
  @JsonValue('instagram_post')
  instagramPost,
  @JsonValue('youtube_video')
  youtubeVideo,
  @JsonValue('youtube_integration')
  youtubeIntegration,
  @JsonValue('youtube_short')
  youtubeShort,
  @JsonValue('ugc_video')
  ugcVideo,
  other;

  String get label => switch (this) {
    instagramReel => 'Instagram Reel',
    instagramStory => 'Instagram Story',
    instagramPost => 'Instagram Static Post',
    youtubeVideo => 'YouTube Dedicated Video',
    youtubeIntegration => 'YouTube Integration',
    youtubeShort => 'YouTube Short',
    ugcVideo => 'UGC Video (Raw Deliverable)',
    other => 'Other Deliverable',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class RateItem with _$RateItem {
  const factory RateItem({
    required String id,
    required String userId,
    required DeliverableType deliverableType,
    String? customTitle,
    required double priceAmount,
    @Default('INR') String currency,
    String? description,
    @Default(true) bool isActive,
  }) = _RateItem;

  factory RateItem.fromJson(Map<String, dynamic> json) =>
      _$RateItemFromJson(json);
}
