import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_events.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/repositories/stories_repository.dart';
import 'package:flutter_story_app/utils/network_info.dart';
import 'package:flutter_story_app/utils/shared_preferences.dart';

class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  final StoriesRepository storiesRepository;
  final NetworkInfo networkInfo;

  FavoritesListBloc({
    @required this.storiesRepository,
    @required this.networkInfo,
  });

  @override
  FavoritesListState get initialState => FavoritesListFetchingState();

  @override
  Stream<FavoritesListState> mapEventToState(FavoritesListEvent event) async* {
    try {
      List<Story> latestStories;
      if (event is FavoritesListFetchList) {
        yield FavoritesListLoadingState();
        List<String> favorites = await SharedPreference.getAllStoryIds();
        if (favorites != null && favorites.length > 0) {
          String ids =
              favorites.reduce((value, element) => value + ',' + element);
          latestStories = await storiesRepository.getFavoriteStories('($ids)');
        }
      }

      if (latestStories.length == 0) {
        yield FavoritesListEmptyState();
      } else {
        yield FavoritesListFetchedState(stories: latestStories);
      }
    } catch (error) {
      yield FavoritesListErrorState(error: error);
    }
  }
}
