import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AllStoriesListEvent extends Equatable {
  const AllStoriesListEvent();

  @override
  List<Object> get props => [];
}

class AllStoriesListFetchList extends AllStoriesListEvent {
  final String offset;

  AllStoriesListFetchList(this.offset);

  @override
  List<Object> get props => [offset];
}

class AllStoriesListFetchListByTag extends AllStoriesListEvent {
  final String tag;
  final String offset;

  AllStoriesListFetchListByTag({@required this.offset, @required this.tag});

  @override
  List<Object> get props => [offset];
}
