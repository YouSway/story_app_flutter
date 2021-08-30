import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_bloc.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_events.dart';
import 'package:flutter_story_app/blocs/favorites_list/favorites_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/utils/theme.dart';
import 'package:flutter_story_app/widgets/fav_card.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../injection_container.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
  }

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
              children: <Widget>[
                Row(
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
                          "Favourites",
                          style: CustomTheme.mainTheme.textTheme.title.merge(
                            TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                BlocProvider<FavoritesListBloc>(
                  create: (BuildContext context) =>
                      sl<FavoritesListBloc>()..add(FavoritesListFetchList()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: _buildFavoritesList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  @override
  void dispose() {
    super.dispose();
  }
}
