import 'package:flutter/cupertino.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/repositories/rest_client.dart';

class StoriesRepository {
  final RestClient client;

  StoriesRepository({@required this.client});

  Future<List<Story>> getFavoriteStories(String array) {
    return client.getFavoriteStories(array);
  }

  Future<List<Story>> getLatestStories() {
    return client.getLatestStories();
  }

  Future<List<Story>> getSearchStories(String word) {
    return client.getSearchStories(word);
  }

  Future<List<Story>> getAllStories(String offset) {
    return client.getAllStories(offset);
  }

  Future<List<Story>> getAllStoriesByTag(String tag, String offset) {
    return client.getAllStoriesByTag(tag, offset);
  }
}
