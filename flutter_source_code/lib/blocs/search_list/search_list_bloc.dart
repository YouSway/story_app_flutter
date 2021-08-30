import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_events.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/repositories/stories_repository.dart';
import 'package:flutter_story_app/utils/network_info.dart';

class SearchListBloc extends Bloc<SearchListEvent, SearchListState> {
  final StoriesRepository storiesRepository;
  final NetworkInfo networkInfo;

  SearchListBloc({
    @required this.storiesRepository,
    @required this.networkInfo,
  });

  @override
  SearchListState get initialState => SearchListEmptyState();

  @override
  Stream<SearchListState> mapEventToState(SearchListEvent event) async* {
    try {
      List<Story> stories;

      if (event is FetchSearchList) {
        yield SearchListLoadingState();
        stories = await storiesRepository.getSearchStories(event.keyWord);
      }

      if (event is DeleteList) {
        stories = new List();
      }

      if (stories.length == 0) {
        yield SearchListEmptyState();
      } else {
        yield SearchListFetchedState(stories: stories);
      }
    } catch (error) {
      yield SearchListErrorState(error: error);
    }
  }
}
