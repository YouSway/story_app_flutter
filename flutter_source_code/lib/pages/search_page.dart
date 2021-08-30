import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_bloc.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/utils/theme.dart';
import 'package:flutter_story_app/widgets/search_card.dart';
import 'package:flutter_story_app/widgets/text_field_search.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../injection_container.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
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
        child: Stack(
          children: <Widget>[
            _buildWidgetBackground(),
            _buildWidgetContent(mediaQuery, context),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSearchStories(MediaQueryData mediaQuery) {
    return BlocBuilder<SearchListBloc, SearchListState>(
      builder: (context, state) {
        if (state is SearchListFetchedState) {
          List<Story> stories = state.stories;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              Story story = stories[index];
              return BlocProvider<SearchListBloc>(
                create: (_) => sl<SearchListBloc>(),
                child: CardSearch(story: story),
              );
            },
          );
        } else if (state is SearchListLoadingState) {
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
        } else if (state is SearchListEmptyState) {
          return Center(
            child: SizedBox(
              width: double.infinity,
              height: 130,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset("assets/box.png", colorBlendMode: BlendMode.overlay,),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Text("Sorry! Nothing found",
                  style: CustomTheme.mainTheme.textTheme.body1,),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildTextFieldSearch() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.0),
        color: Color(0x2FFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: TextFieldSearch(),
      ),
    );
  }

  Widget _buildWidgetBackground() {
    return Column(
      children: <Widget>[
        Expanded(
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
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetContent(MediaQueryData mediaQuery, BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<SearchListBloc, SearchListState>(
            builder: (context, state) {
              if (state is SearchListFetchedState) {
                return Padding(
                  padding: EdgeInsets.only(top: mediaQuery.padding.top),
                );
              }
              return Padding(
                padding: EdgeInsets.only(
                    top: 16.0 + mediaQuery.padding.top, bottom: 16.0),
                child: Text(
                  "Search\nSomething ?",
                  style: CustomTheme.mainTheme.textTheme.headline,
                ),
              );
            },
          ),
          _buildTextFieldSearch(),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Expanded(child: _buildResultSearchStories(mediaQuery)),
        ],
      ),
    );
  }
}
