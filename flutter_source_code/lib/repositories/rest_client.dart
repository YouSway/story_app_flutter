import 'package:dio/dio.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/model/tag.dart';
import 'package:flutter_story_app/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: API_BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(ALL_TAGS_URL)
  Future<List<Tag>> getAllTags();

  @GET(FAVORITE_STORIES_URL + "/{array}")
  Future<List<Story>> getFavoriteStories(@Path("array") String array);

  @GET(LATEST_STORIES_URL)
  Future<List<Story>> getLatestStories();

  @GET(SEARCH_STORIES_URL + "/{word}")
  Future<List<Story>> getSearchStories(@Path("word") String word);

  @GET(ALL_STORIES_URL + "/{offset}")
  Future<List<Story>> getAllStories(@Path("offset") String offset);

  @GET(ALL_STORIES_BY_TAG_URL + "{tag}/{offset}")
  Future<List<Story>> getAllStoriesByTag(@Path("tag") String tag, @Path("offset") String offset);
}
