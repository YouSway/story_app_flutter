import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_bloc.dart';
import 'package:flutter_story_app/blocs/search_list/search_list_events.dart';
import 'package:flutter_story_app/utils/theme.dart';

class TextFieldSearch extends StatefulWidget {
  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  var _textEditingControllerKeyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.white,
        ),
        Padding(padding: EdgeInsets.only(right: 8.0)),
        Expanded(
          child: TextField(
            autofocus: true,
            controller: _textEditingControllerKeyword,
            decoration: InputDecoration.collapsed(
              hintText: "Search...",
              hintStyle: CustomTheme.mainTheme.textTheme.body2.merge(
                TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            style: TextStyle(color: Colors.white),
            maxLines: 1,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              BlocProvider.of<SearchListBloc>(context).add(DeleteList());
              BlocProvider.of<SearchListBloc>(context)
                  .add(FetchSearchList(value));
            },
          ),
        ),
        _textEditingControllerKeyword.text.isEmpty
            ? Container()
            : GestureDetector(
                onTap: () {
                  setState(() => _textEditingControllerKeyword.clear());
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
      ],
    );
  }
}
