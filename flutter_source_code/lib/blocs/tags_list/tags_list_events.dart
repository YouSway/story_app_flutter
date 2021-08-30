import 'package:equatable/equatable.dart';

class DeleteList extends TagsListEvent {}

class FetchTagsList extends TagsListEvent {
  @override
  List<Object> get props => [];
}

abstract class TagsListEvent extends Equatable {
  const TagsListEvent();
  @override
  List<Object> get props => [];
}
