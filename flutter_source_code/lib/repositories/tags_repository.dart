import 'package:flutter/material.dart';
import 'package:flutter_story_app/model/tag.dart';
import 'package:flutter_story_app/repositories/rest_client.dart';

class TagsRepository {
  final RestClient client;

  TagsRepository({@required this.client});

  Future<List<Tag>> getAllTags() {
    return client.getAllTags();
  }
}
