import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_events.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_events.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_states.dart';
import 'package:flutter_story_app/blocs/page_controller/page_controller_bloc.dart';
import 'package:flutter_story_app/blocs/page_controller/page_controller_event.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_bloc.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_bloc.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_events.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_states.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_bloc.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_events.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/pages/all_stories_page.dart';
import 'package:flutter_story_app/pages/all_tags_page.dart';
import 'package:flutter_story_app/pages/favorites_page.dart';
import 'package:flutter_story_app/pages/search_page.dart';
import 'package:flutter_story_app/pages/story_page.dart';
import 'package:flutter_story_app/utils/theme.dart';
import 'package:flutter_story_app/widgets/card_scroll_widget.dart';
import 'package:flutter_story_app/widgets/fav_card.dart';
import 'package:flutter_story_app/widgets/story_chips.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../injection_container.dart';
import '../utils/constants.dart';
import '../widgets/custom_Icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cardAspectRatio = 12.0 / 16.0;
  var widgetAspectRatio = 12.0 / 16.0 * 1.2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        drawer: _buildDrawer(),
        backgroundColor: Colors.transparent,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF1b1e44),
                Color(0xFF2d3447),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp),
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
            ),
            ListTile(
              title: Text(
                'Tags',
                style: CustomTheme.mainTheme.textTheme.title.merge(TextStyle(
                  color: Colors.white,
                )),
              ),
              onTap: () {
                var route = AllTagsPage();
                Navigator.pop(context);
                Navigator.of(context).push(_createRoute(route));
              },
            ),
            ListTile(
              title: Text(
                'Favourites',
                style: CustomTheme.mainTheme.textTheme.title.merge(TextStyle(
                  color: Colors.white,
                )),
              ),
              onTap: () {
                var route = FavoritesPage();
                Navigator.pop(context);
                Navigator.of(context).push(_createRoute(route));
              },
            ),
            ListTile(
              title: Text(
                'All stories',
                style: CustomTheme.mainTheme.textTheme.title.merge(TextStyle(
                  color: Colors.white,
                )),
              ),
              onTap: () {
                var route = BlocProvider<AllStoriesListBloc>(
                  create: (_) => sl<AllStoriesListBloc>()
                    ..add(AllStoriesListFetchList("0")),
                  child: AllStoriesPage(
                    isComingFromTag: false,
                  ),
                );
                Navigator.pop(context);
                Navigator.of(context).push(_createRoute(route));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DrawerIcon(),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        _onRefresh(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        var route = BlocProvider<SearchListBloc>(
                          create: (_) => sl<SearchListBloc>(),
                          child: SearchPage(),
                        );
                        Navigator.of(context).push(_createRoute(route));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Latest",
                  style: CustomTheme.mainTheme.textTheme.headline,
                ),
                IconButton(
                  icon: Icon(
                    CustomIcons.option,
                    size: 12.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    var route = BlocProvider<AllStoriesListBloc>(
                      create: (_) => sl<AllStoriesListBloc>()
                        ..add(AllStoriesListFetchList("0")),
                      child: AllStoriesPage(
                        isComingFromTag: false,
                      ),
                    );
                    Navigator.of(context).push(_createRoute(route));
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTagsList(),
              ],
            ),
          ),
          _buildCardScrollingWidget(),
          SizedBox(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Favourites",
                  style: CustomTheme.mainTheme.textTheme.headline,
                ),
                IconButton(
                  icon: Icon(
                    CustomIcons.option,
                    size: 12.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    var route = FavoritesPage();
                    Navigator.of(context).push(_createRoute(route));
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          _buildFavoritesList(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildTagsList() {
    return BlocBuilder<TagsListBloc, TagsListState>(
      builder: (context, state) {
        if (state is TagsListFetchedState) {
          List<String> tagsList = state.tags.map((tag) => tag.tag).toList();
          String tags =
              tagsList.reduce((value, element) => value + ',' + element);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StoryChips(
                  strTags: tags,
                  shouldShuffle: true,
                  chipsCount: 6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: Text(
                      (tagsList.length - 6).toString() + "+ tags",
                      style: CustomTheme.mainTheme.textTheme.body2,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildCardScrollingWidget() {
    return BlocBuilder<TrendingListBloc, TrendingListState>(
      builder: (context, state) {
        int itemCount = TRENDING_LIST_ITEM_COUNT;
        if (state is TrendingListFetchedState) {
          List<Story> stories = state.latestStories;
          itemCount = stories.length;
          PageController controller = PageController(initialPage: itemCount);
          controller.addListener(() {
            BlocProvider.of<PageControllerBloc>(context)
                .add(PageControllerChangePage(controller.page));
          });
          return GestureDetector(
            onTap: () {
              if (state is TrendingListFetchedState) {
                Story story = stories[
                    BlocProvider.of<PageControllerBloc>(context).state.round()];
                var route = StoryPage(
                  story: story,
                );
                Navigator.of(context).push(_createRoute(route));
              }
            },
            child: Stack(
              children: <Widget>[
                BlocBuilder<PageControllerBloc, double>(
                  builder: (context, state) {
                    return BlocProvider.value(
                      value: BlocProvider.of<TrendingListBloc>(context),
                      child: CardScrollWidget(
                          state, cardAspectRatio, widgetAspectRatio),
                    );
                  },
                ),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: itemCount,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                )
              ],
            ),
          );
        } else if (state is TrendingListLoadingState) {
          return Center(
            child: SizedBox(
              width: 130,
              height: 130,
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                color: Colors.white70,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildFavoritesList() {
    return BlocBuilder<FavoritesListBloc, FavoritesListState>(
      builder: (context, state) {
        if (state is FavoritesListFetchedState) {
          List<Story> stories = state.stories;
          List<Widget> cards = new List();
          for (int i = 0; i < stories.length; i = i + 2) {
            cards.add(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex: 1, child: CardFav(story: stories[i])),
                  (i + 1 < stories.length)
                      ? Expanded(flex: 1, child: CardFav(story: stories[i + 1]))
                      : Container()
                ],
              ),
            );
          }
          return Column(
            children: cards,
          );
        } else if (state is FavoritesListLoadingState) {
          return Center(
            child: SizedBox(
              width: 130,
              height: 130,
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                color: Colors.white70,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Route _createRoute(var route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CircularRevealAnimation(
          child: child,
          animation: animation,
          centerAlignment: Alignment.center,
        );
      },
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    // monitor network fetch
    BlocProvider.of<TrendingListBloc>(context).add(TrendingListFetchList());
    BlocProvider.of<FavoritesListBloc>(context).add(FavoritesListFetchList());
    BlocProvider.of<TagsListBloc>(context).add(FetchTagsList());

    await Future.delayed(Duration(milliseconds: 1000));
  }
}

class DrawerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        CustomIcons.menu,
        color: Colors.white,
        size: 30.0,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
