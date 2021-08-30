import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_story_app/model/story.dart';

class FavoritesListEmptyState extends FavoritesListState {}

class FavoritesListLoadingState extends FavoritesListState {}

class FavoritesListErrorState extends FavoritesListState {
  final String error;

  FavoritesListErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}

class FavoritesListFetchedState extends FavoritesListState {
  final List<Story> stories;

  FavoritesListFetchedState({@required this.stories});

  @override
  List<Object> get props => [stories];
}

class FavoritesListFetchingState extends FavoritesListState {}

abstract class FavoritesListState extends Equatable {
  const FavoritesListState();

  @override
  List<Object> get props => [];
}
