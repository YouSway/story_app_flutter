import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_bloc.dart';
import 'package:flutter_story_app/blocs/favourite_checker/favorite_checker_bloc.dart';
import 'package:flutter_story_app/blocs/font_size/font_size_bloc.dart';
import 'package:flutter_story_app/blocs/page_controller/page_controller_bloc.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_bloc.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_bloc.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_bloc.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_bloc.dart';
import 'package:flutter_story_app/repositories/rest_client.dart';
import 'package:flutter_story_app/repositories/stories_repository.dart';
import 'package:flutter_story_app/repositories/tags_repository.dart';
import 'package:flutter_story_app/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs
  sl.registerFactory(
    () => FavoritesListBloc(
      storiesRepository: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerFactory(
    () => FavoriteCheckerBloc(),
  );
  sl.registerFactory(
    () => FontSizeBloc(),
  );
  sl.registerFactory(
    () => PageControllerBloc(),
  );
  sl.registerFactory(
    () => ReadingModeBloc(),
  );
  sl.registerFactory(
    () => SearchListBloc(
      storiesRepository: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerFactory(
    () => TagsListBloc(
      tagsRepository: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerFactory(
    () => TrendingListBloc(
      storiesRepository: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerFactory(
    () => AllStoriesListBloc(
      storiesRepository: sl(),
    ),
  );

  //Repositories
  sl.registerLazySingleton(() => StoriesRepository(client: sl()));
  sl.registerLazySingleton(() => TagsRepository(client: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: sl()),
  );

  //External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => Dio()..interceptors.add(LogInterceptor()));
  sl.registerLazySingleton(() => RestClient(sl()));
}
