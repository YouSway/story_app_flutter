// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
    json['id'] as int,
    json['intro'] as String,
    json['story'] as String,
    json['authorId'] as int,
    json['author'] as String,
    json['images'] as String,
    json['tags'] as String,
    json['title'] as String,
  )..isFavourite = json['isFavourite'] as bool;
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'intro': instance.intro,
      'story': instance.story,
      'authorId': instance.authorId,
      'author': instance.author,
      'images': instance.images,
      'tags': instance.tags,
      'title': instance.title,
      'isFavourite': instance.isFavourite,
    };
