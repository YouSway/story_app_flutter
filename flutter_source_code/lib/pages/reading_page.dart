import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/font_size/font_size_bloc.dart';
import 'package:flutter_story_app/blocs/font_size/font_size_event.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_bloc.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_event.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_state.dart';
import 'package:flutter_story_app/model/story.dart';

class ReadingPage extends StatefulWidget {
  final Story story;
  const ReadingPage({Key key, this.story}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ReadingPageState();
}

class ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingModeBloc, ReadingModeState>(
      builder: (context, state) {
        Mode _mode = state.mode;
        return Scaffold(
          backgroundColor: _mode.backgroundColor,
          body: Container(
            child: Stack(
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    top: 100.0,
                    right: 16.0,
                  ),
                  children: <Widget>[
                    BlocBuilder<FontSizeBloc, double>(
                        builder: (context, state) {
                      return Container(
                        child: Text(
                          widget.story.story,
                          style: Theme.of(context).textTheme.body1.merge(
                              TextStyle(
                                  color: _mode.textColor, fontSize: state)),
                          textAlign: TextAlign.justify,
                        ),
                      );
                    }),
                  ],
                ),
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 16.0, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            child:
                                Icon(Icons.arrow_back, color: _mode.iconColor),
                            backgroundColor: _mode.iconBackgroundColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<FontSizeBloc>(context)
                                      .add(IncreaseSize());
                                },
                                child: CircleAvatar(
                                  child:
                                      Icon(Icons.title, color: _mode.iconColor),
                                  backgroundColor: _mode.iconBackgroundColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<FontSizeBloc>(context)
                                      .add(DecreaseSize());
                                },
                                child: CircleAvatar(
                                  child: Icon(Icons.title,
                                      size: 16, color: _mode.iconColor),
                                  backgroundColor: _mode.iconBackgroundColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  if (state is DarkMode) {
                                    BlocProvider.of<ReadingModeBloc>(context)
                                        .add(SwitchToLightMode());
                                  } else {
                                    BlocProvider.of<ReadingModeBloc>(context)
                                        .add(SwitchToDarkMode());
                                  }
                                },
                                child: CircleAvatar(
                                  child: Icon(Icons.color_lens,
                                      color: _mode.iconColor),
                                  backgroundColor: _mode.iconBackgroundColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
