import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  int id;
  String intro;
  String story;
  int authorId;
  String author;
  String images;
  String tags;
  String title;
  bool isFavourite;

  Story(this.id, this.intro, this.story, this.authorId, this.author,
      this.images, this.tags, this.title);

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
