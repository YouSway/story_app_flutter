import 'package:equatable/equatable.dart';

abstract class FavoriteCheckerState extends Equatable {
  final bool isFavorite = null;
  @override
  List<Object> get props => [isFavorite];
}

class HasValueState extends FavoriteCheckerState {
  final bool isFavorite;
  HasValueState(this.isFavorite);
  @override
  List<Object> get props => [isFavorite];
}

class InitialNullState extends FavoriteCheckerState {
  final bool isFavorite = null;
  @override
  List<Object> get props => [isFavorite];
}
