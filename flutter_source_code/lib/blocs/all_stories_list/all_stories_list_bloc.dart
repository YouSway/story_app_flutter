import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_events.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/repositories/stories_repository.dart';

class AllStoriesListBloc extends Bloc<AllStoriesListEvent, AllStoriesListState> {
  final StoriesRepository storiesRepository;

  AllStoriesListBloc({@required this.storiesRepository});

  @override
  AllStoriesListState get initialState => AllStoriesListFetchingState();

  @override
  Stream<AllStoriesListState> mapEventToState(AllStoriesListEvent event) async* {
    final currentState = state;
    try {
      List<Story> stories;
      if (event is AllStoriesListFetchList) {
        if (event.offset == "0"){
          yield AllStoriesListLoadingState();
        }
        stories = await storiesRepository.getAllStories(event.offset);
      }

      if (event is AllStoriesListFetchListByTag) {
        if (event.offset == "0"){
          yield AllStoriesListLoadingState();
        }
        stories = await storiesRepository.getAllStoriesByTag(event.tag, event.offset);
      }

      if (stories.length == 0 && currentState is AllStoriesListFetchedState && currentState.stories.length == 0) {
        yield AllStoriesListEmptyState();
      } else if (stories.length == 0 && currentState is AllStoriesListFetchedState) {
        yield AllStoriesListFetchedState(currentState.stories, true);
      } else if (currentState is AllStoriesListFetchedState) {
        yield AllStoriesListFetchedState(currentState.stories + stories, false);
      } else if (stories.length == 0) {
        yield AllStoriesListEmptyState();
      } else if (!(currentState is AllStoriesListFetchedState)) {
        yield AllStoriesListFetchedState(stories, false);
      }
    } catch (error) {
      print(error);
      yield AllStoriesListErrorState(error: error);
    }
  }
}
