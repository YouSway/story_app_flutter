import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_events.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_states.dart';
import 'package:flutter_story_app/model/tag.dart';
import 'package:flutter_story_app/repositories/tags_repository.dart';
import 'package:flutter_story_app/utils/network_info.dart';

class TagsListBloc extends Bloc<TagsListEvent, TagsListState> {
  final TagsRepository tagsRepository;
  final NetworkInfo networkInfo;

  TagsListBloc({
    @required this.tagsRepository,
    @required this.networkInfo,
  });

  @override
  TagsListState get initialState => TagsListEmptyState();

  @override
  Stream<TagsListState> mapEventToState(TagsListEvent event) async* {
    try {
      List<Tag> tags;

      if (event is FetchTagsList) {
        tags = await tagsRepository.getAllTags();
      }

      if (event is DeleteList) {
        tags = new List();
      }

      if (tags.length == 0) {
        yield TagsListEmptyState();
      } else {
        yield TagsListFetchedState(tags: tags);
      }
    } catch (error) {
      yield TagsListErrorState(error: error);
    }
  }
}
