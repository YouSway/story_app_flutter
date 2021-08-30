import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_story_app/model/story.dart';

class SearchListEmptyState extends SearchListState {}

class SearchListLoadingState extends SearchListState {}

class SearchListErrorState extends SearchListState {
  final String error;
  SearchListErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}

class SearchListFetchedState extends SearchListState {
  final List<Story> stories;
  SearchListFetchedState({@required this.stories});

  @override
  List<Object> get props => [stories];
}

class SearchListFetchingState extends SearchListState {}

abstract class SearchListState extends Equatable {
  const SearchListState();

  @override
  List<Object> get props => [];
}
