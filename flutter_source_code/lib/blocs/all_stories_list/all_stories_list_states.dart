import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_story_app/model/story.dart';

abstract class AllStoriesListState extends Equatable {
  const AllStoriesListState();

  @override
  List<Object> get props => [];
}

class AllStoriesListEmptyState extends AllStoriesListState {}

class AllStoriesListLoadingState extends AllStoriesListState {}

class AllStoriesListErrorState extends AllStoriesListState {
  final String error;

  AllStoriesListErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}

class AllStoriesListFetchedState extends AllStoriesListState {
  final List<Story> stories;
  final bool hasReachedMax;

  AllStoriesListFetchedState(this.stories, this.hasReachedMax);

  AllStoriesListFetchedState copyWith({
    List<Story> stories,
    bool hasReachedMax,
  }) {
    return AllStoriesListFetchedState(
      stories ?? this.stories,
      hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [stories, hasReachedMax];
}

class AllStoriesListFetchingState extends AllStoriesListState {}
