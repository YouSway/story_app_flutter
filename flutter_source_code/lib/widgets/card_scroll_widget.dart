import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_bloc.dart';
import 'package:flutter_story_app/blocs/trending_list/trending_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/utils/theme.dart';
import 'package:flutter_story_app/widgets/story_chips.dart';

import '../utils/constants.dart';

class CardScrollWidget extends StatelessWidget {
  final double padding = 20.0;
  final double verticalInset = 20.0;

  final double currentPage;
  final double cardAspectRatio;
  final double widgetAspectRatio;

  CardScrollWidget(
      this.currentPage, this.cardAspectRatio, this.widgetAspectRatio);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingListBloc, TrendingListState>(
      builder: (context, state) {
        return new AspectRatio(
          aspectRatio: widgetAspectRatio,
          child: LayoutBuilder(builder: (context, constraints) {
            var width = constraints.maxWidth;
            var height = constraints.maxHeight;

            var safeWidth = width - 2 * padding;
            var safeHeight = height - 2 * padding;

            var heightOfPrimaryCard = safeHeight;
            var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

            var primaryCardLeft = safeWidth - widthOfPrimaryCard;
            var horizontalInset = primaryCardLeft / 2;

            List<Widget> cardList = new List();

            if (state is TrendingListFetchedState) {
              List<Story> latestStories = state.latestStories;
              for (var i = 0; i < latestStories.length; i++) {
                Story story = latestStories[i];
                var delta = i - currentPage;
                bool isOnRight = delta > 0;
                var start = padding +
                    max(
                        primaryCardLeft -
                            horizontalInset * -delta * (isOnRight ? 15 : 1),
                        0.0);

                var cardItem = Positioned.directional(
                  top: padding + verticalInset * max(-delta, 0.0),
                  bottom: padding + verticalInset * max(-delta, 0.0),
                  start: start,
                  textDirection: TextDirection.rtl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 6.0),
                                blurRadius: 10.0)
                          ]),
                      child: AspectRatio(
                        aspectRatio: cardAspectRatio,
                        child: Container(
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              FadeInImage(
                                image: NetworkImage(
                                    THUMBNAILS_BASE_URL + story.images),
                                fit: BoxFit.cover,
                                placeholder: AssetImage("assets/black.jpg"),
                              ),
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [
                                        0.1,
                                        0.9
                                      ],
                                      colors: [
                                        Color(0x001b1e44),
                                        Color(0xFF1b1e44),
                                      ]),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 0),
                                      child: Text(
                                        story.title,
                                        style: CustomTheme.mainTheme.textTheme.title,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 0),
                                      child: Text(
                                        "by " + story.author,
                                        style: CustomTheme.mainTheme.textTheme.body1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: StoryChips(strTags: story.tags, shouldShuffle: false,),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
                cardList.add(cardItem);
              }
              return Stack(
                children: cardList,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        );
      },
    );
  }
}
