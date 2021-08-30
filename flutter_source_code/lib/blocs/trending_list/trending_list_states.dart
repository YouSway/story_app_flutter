import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_story_app/model/story.dart';

abstract class TrendingListState extends Equatable {
  const TrendingListState();

  @override
  List<Object> get props => [];
}

class TrendingListEmptyState extends TrendingListState {}

class TrendingListLoadingState extends TrendingListState {}

class TrendingListErrorState extends TrendingListState {
  final String error;

  TrendingListErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}

class TrendingListFetchedState extends TrendingListState {
  final List<Story> latestStories;

  TrendingListFetchedState({@required this.latestStories});

  @override
  List<Object> get props => [latestStories];
}

class TrendingListFetchingState extends TrendingListState {}
