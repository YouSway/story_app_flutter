import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_events.dart';
import 'package:flutter_story_app/pages/all_stories_page.dart';
import 'package:flutter_story_app/utils/constants.dart';
import 'package:flutter_story_app/utils/theme.dart';

import '../injection_container.dart';

class StoryChips extends StatelessWidget {
  final String strTags;
  final bool shouldShuffle;
  final int chipsCount;

  const StoryChips(
      {Key key,
      @required this.strTags,
      @required this.shouldShuffle,
      this.chipsCount = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTagStory(strTags, context);
  }

  List<Widget> _buildChips(String strTags, BuildContext context) {
    List<Color> colors = new List()..addAll(TAG_COLORS);
    if (shouldShuffle) colors.shuffle();
    List<String> tags = strTags.split(',');
    List<Widget> chips = new List();
    for (int i = 0; i < tags.length; i++) {
      if (i == chipsCount) break;
      chips.add(InkWell(
        onTap: () {
          var route = BlocProvider<AllStoriesListBloc>(
            create: (_) => sl<AllStoriesListBloc>()
              ..add(AllStoriesListFetchListByTag(offset: "0", tag: tags[i].toUpperCase())),
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

  Widget _buildTagStory(String strTags, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildChips(strTags, context),
    );
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
