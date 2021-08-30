import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_events.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/repositories/stories_repository.dart';
import 'package:flutter_story_app/utils/network_info.dart';

class TrendingListBloc extends Bloc<TrendingListEvent, TrendingListState> {
  final StoriesRepository storiesRepository;
  final NetworkInfo networkInfo;

  TrendingListBloc({
    @required this.storiesRepository,
    @required this.networkInfo,
  });

  @override
  TrendingListState get initialState => TrendingListFetchingState();

  @override
  Stream<TrendingListState> mapEventToState(TrendingListEvent event) async* {
    try {
      List<Story> latestStories;

      if (event is TrendingListFetchList) {
        yield TrendingListLoadingState();
        latestStories = await storiesRepository.getLatestStories();
      }

      if (latestStories.length == 0) {
        yield TrendingListEmptyState();
      } else {
        yield TrendingListFetchedState(
            latestStories: latestStories.reversed.toList());
      }
    } catch (error) {
      yield TrendingListErrorState(error: error);
    }
  }
}
