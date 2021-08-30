import 'package:equatable/equatable.dart';

class DeleteList extends SearchListEvent {}

class FetchSearchList extends SearchListEvent {
  final String keyWord;
  FetchSearchList(this.keyWord);
  @override
  List<Object> get props => [keyWord];
}

abstract class SearchListEvent extends Equatable {
  const SearchListEvent();
  @override
  List<Object> get props => [];
}
