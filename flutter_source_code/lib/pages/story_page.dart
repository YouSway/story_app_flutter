import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_bloc.dart';
import 'package:flutter_story_app/blocs/favourite_checker/favorite_checker_bloc.dart';
import 'package:flutter_story_app/blocs/favourite_checker/favorite_checker_event.dart';
import 'package:flutter_story_app/blocs/favourite_checker/favorite_checker_state.dart';
import 'package:flutter_story_app/blocs/font_size/font_size_bloc.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_bloc.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_event.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/pages/reading_page.dart';
import 'package:flutter_story_app/utils/shared_preferences.dart';
import 'package:flutter_story_app/widgets/story_chips.dart';

import '../injection_container.dart';
import '../utils/constants.dart';

class StoryPage extends StatefulWidget {
  final Story story;
  const StoryPage({Key key, @required this.story}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildWidgetImageHeader(mediaQuery),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    backgroundColor: Color(0xFF2d3447),
                  ),
                ),
              ),
            ),
            _buildWidgetDetail(mediaQuery, context),
          ],
        ),
      ),
    );
  }

  Widget _buildIntro(String intro) {
    return Container(
      child: Text(
        intro,
        style: Theme.of(context)
            .textTheme
            .body1
            .merge(TextStyle(color: Colors.white70, fontSize: 16)),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildReadButton(Story story) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute(story));
          },
          child: Text(
            "Read",
            style: Theme.of(context)
                .textTheme
                .body1
                .merge(TextStyle(color: Colors.white70, fontSize: 16)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          borderSide: BorderSide(
            color: Colors.orange, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 0.8, //width of the border
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.story.title,
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 20),
                    ),
                maxLines: 2,
              ),
              Text(
                "by " + widget.story.author,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .merge(TextStyle(color: Colors.white70)),
                maxLines: 2,
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: _favoriteIconWidget(),
        ),
      ],
    );
  }

  Widget _buildWidgetBottomSheet({BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StoryChips(
            strTags: widget.story?.tags ?? null,
            shouldShuffle: true,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 12.0)),
        _buildIntro(widget.story.intro),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        _buildReadButton(widget.story),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
      ],
    );
  }

  Widget _buildWidgetDetail(MediaQueryData mediaQuery, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: mediaQuery.size.height / 2.5),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color(0xFF1b1e44),
                Color(0xFF2d3447),
              ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp)),
          child: SafeArea(
            left: false,
            top: false,
            right: false,
            child: ListView(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
              ),
              children: <Widget>[
                _buildTitle(context),
                _buildWidgetBottomSheet(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetImageHeader(MediaQueryData mediaQuery) {
    return Hero(
      tag: "image_detail",
      child: FadeInImage(
        image: NetworkImage(IMAGES_BASE_URL + widget.story.images),
        placeholder: AssetImage("assets/black.jpg"),
        fit: BoxFit.cover,
        width: double.infinity,
        height: mediaQuery.size.height / 2.2,
      ),
    );
  }

  Route _createRoute(Story story) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          MultiBlocProvider(
            providers: [
              BlocProvider<ReadingModeBloc>(
                create: (_) =>
                sl<ReadingModeBloc>()
                  ..add(SwitchToDarkMode()),
              ),
              BlocProvider<FontSizeBloc>(
                create: (_) => sl<FontSizeBloc>(),
              ),
            ],
            child: ReadingPage(
              story: story,
            ),
          ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CircularRevealAnimation(
          child: child,
          animation: animation,
          centerAlignment: Alignment.center,
        );
      },
    );
  }

  Widget _favoriteIconWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteCheckerBloc>(
          create: (_) => sl<FavoriteCheckerBloc>()..add(CheckFavorite(widget.story.id)),
        ),
        BlocProvider<FavoritesListBloc>(
          create: (_) => sl<FavoritesListBloc>(),
        ),
      ],
      child: BlocBuilder<FavoriteCheckerBloc, FavoriteCheckerState>(
        builder: (context, state) {
          if (state is HasValueState) {
            return GestureDetector(
              onTap: () {
                if (state.isFavorite) {
                  SharedPreference.delete(widget.story.id);
                  BlocProvider.of<FavoriteCheckerBloc>(context)
                      .add(DeleteValueEvent());
                  BlocProvider.of<FavoriteCheckerBloc>(context)
                      .add(CheckFavorite(widget.story.id));
                } else {
                  SharedPreference.storeStoryId(widget.story.id);
                  BlocProvider.of<FavoriteCheckerBloc>(context)
                      .add(DeleteValueEvent());
                  BlocProvider.of<FavoriteCheckerBloc>(context)
                      .add(CheckFavorite(widget.story.id));
                }
              },
              child: CircleAvatar(
                backgroundColor: Color(0xAFE8364B),
                child: state.isFavorite
                    ? Icon(
                  Icons.favorite,
                  color: Colors.white,
                )
                    : Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
