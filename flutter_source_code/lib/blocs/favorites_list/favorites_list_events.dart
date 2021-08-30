import 'package:equatable/equatable.dart';

abstract class FavoritesListEvent extends Equatable {
  const FavoritesListEvent();

  @override
  List<Object> get props => [];
}

class FavoritesListFetchList extends FavoritesListEvent {}
