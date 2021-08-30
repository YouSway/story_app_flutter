import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_events.dart';
import 'package:flutter_story_app/blocs/page_controller/page_controller_bloc.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_bloc.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_events.dart';
import 'package:flutter_story_app/injection_container.dart' as di;
import 'package:flutter_story_app/pages/home_page.dart';
import 'package:flutter_story_app/utils/http_overider.dart';

import 'blocs/tags_list/tags_list_bloc.dart';
import 'blocs/tags_list/tags_list_events.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  HttpOverrides.global = ModifiedHttpOverrides();
  runApp(StoryApp());
}

class StoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stories App',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TrendingListBloc>(
            create: (BuildContext context) =>
            di.sl<TrendingListBloc>()
              ..add(TrendingListFetchList()),
          ),
          BlocProvider<FavoritesListBloc>(
            create: (BuildContext context) =>
            di.sl<FavoritesListBloc>()
              ..add(FavoritesListFetchList()),
          ),
          BlocProvider<TagsListBloc>(
            create: (BuildContext context) =>
            di.sl<TagsListBloc>()
              ..add(FetchTagsList()),
          ),
          BlocProvider<PageControllerBloc>(
            create: (BuildContext context) => PageControllerBloc(),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
