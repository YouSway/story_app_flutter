import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_story_app/model/tag.dart';

class TagsListEmptyState extends TagsListState {}

class TagsListErrorState extends TagsListState {
  final String error;
  TagsListErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}

class TagsListFetchedState extends TagsListState {
  final List<Tag> tags;
  TagsListFetchedState({@required this.tags});

  @override
  List<Object> get props => [tags];
}

class TagsListFetchingState extends TagsListState {}

abstract class TagsListState extends Equatable {
  const TagsListState();

  @override
  List<Object> get props => [];
}
