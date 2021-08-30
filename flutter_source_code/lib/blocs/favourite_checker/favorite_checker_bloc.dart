import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/favourite_checker/favorite_checker_event.dart';
import 'package:flutter_story_app/blocs/favourite_checker/favorite_checker_state.dart';
import 'package:flutter_story_app/utils/shared_preferences.dart';

class FavoriteCheckerBloc
    extends Bloc<FavoriteCheckerEvent, FavoriteCheckerState> {
  @override
  FavoriteCheckerState get initialState => InitialNullState();

  @override
  Stream<FavoriteCheckerState> mapEventToState(
      FavoriteCheckerEvent event) async* {
    if (event is CheckFavorite) {
      bool isFavorite = await SharedPreference.checkAvailability(event.storyId);
      yield HasValueState(isFavorite);
    }
    if (event is DeleteValueEvent) {
      yield HasValueState(null);
    }
  }
}
