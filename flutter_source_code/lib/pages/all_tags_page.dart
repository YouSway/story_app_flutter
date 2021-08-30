import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_events.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_bloc.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_events.dart';
import 'package:flutter_story_app/blocs/tags_list/tags_list_states.dart';
import 'package:flutter_story_app/utils/constants.dart';
import 'package:flutter_story_app/utils/theme.dart';

import '../injection_container.dart';
import 'all_stories_page.dart';

class AllTagsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AllTagsPageState();
}

class _AllTagsPageState extends State<AllTagsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                child:
                                Icon(Icons.arrow_back, color: Colors.white),
                                backgroundColor: Color(0xFF2d3447),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "All tags",
                            style: CustomTheme.mainTheme.textTheme.title.merge(
                              TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: BlocProvider<TagsListBloc>(
                    create: (BuildContext context) =>
                        sl<TagsListBloc>()..add(FetchTagsList()),
                    child: _buildTagsList(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagsList(BuildContext context) {
    return BlocBuilder<TagsListBloc, TagsListState>(
      builder: (context, state) {
        if (state is TagsListFetchedState) {
          List<String> tagsList = state.tags.map((tag) => tag.tag).toList();
          String tags =
              tagsList.reduce((value, element) => value + ',' + element);
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    alignment: WrapAlignment.center,
                    children: _buildChips(tags, context),
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

  List<Widget> _buildChips(String strTags, BuildContext context) {
    List<Color> colors = new List()..addAll(TAG_COLORS);
    colors.shuffle();
    List<String> tags = strTags.split(',');
    List<Widget> chips = new List();
    for (int i = 0; i < tags.length; i++) {
      chips.add(InkWell(
        onTap: () {
          var route = BlocProvider<AllStoriesListBloc>(
            create: (_) => sl<AllStoriesListBloc>()
              ..add(AllStoriesListFetchListByTag(
                  offset: "0", tag: tags[i].toUpperCase())),
            child: AllStoriesPage(
              isComingFromTag: true,
              tag: tags[i].toUpperCase(),
            ),
          );
          Navigator.of(context).push(_createRouteToAllStoriesPage(route));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: new Chip(
            label: Text(
              tags[i].toLowerCase(),
              style: CustomTheme.mainTheme.textTheme.body2.merge(
                TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            backgroundColor: colors[i % colors.length],
          ),
        ),
      ));
    }
    return chips;
  }

  Route _createRouteToAllStoriesPage(var route) {
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
}
