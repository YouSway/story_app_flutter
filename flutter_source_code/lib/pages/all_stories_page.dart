import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_bloc.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_events.dart';
import 'package:flutter_story_app/blocs/all_stories_list/all_stories_list_states.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/utils/theme.dart';
import 'package:flutter_story_app/widgets/all_card.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AllStoriesPage extends StatefulWidget {
  final bool isComingFromTag;
  final String tag;

  const AllStoriesPage({Key key, @required this.isComingFromTag, this.tag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllStoriesPageState();
}

class _AllStoriesPageState extends State<AllStoriesPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  AllStoriesListBloc _allStoriesListBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _allStoriesListBloc = BlocProvider.of<AllStoriesListBloc>(context);
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
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.isComingFromTag
                                  ? "'${widget.tag.toLowerCase()}' tag"
                                  : "All Stories",
                              style: CustomTheme.mainTheme.textTheme.title.merge(
                                TextStyle(fontSize: 25),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AllStoriesListBloc, AllStoriesListState>(
                  builder: (context, state) {
                    if (state is AllStoriesListFetchedState) {
                      List<Story> stories = state.stories;
                      return Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (index < stories.length) {
                              return CardAll(story: stories[index]);
                            } else {
                              if (!state.hasReachedMax) {
                                if (widget.isComingFromTag) {
                                  _allStoriesListBloc
                                      .add(AllStoriesListFetchListByTag(
                                    offset: stories.length.toString(),
                                    tag: widget.tag,
                                  ));
                                } else {
                                  _allStoriesListBloc.add(
                                      AllStoriesListFetchList(
                                          stories.length.toString()));
                                }
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          accentColor: Colors.white70),
                                      child: SizedBox(
                                        width: 75,
                                        height: 75,
                                        child: LoadingIndicator(
                                          indicatorType:
                                              Indicator.ballClipRotateMultiple,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }
                          },
                          itemCount: stories.length + 1,
                        ),
                      );
                    } else if (state is AllStoriesListLoadingState) {
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {}
  }
}
