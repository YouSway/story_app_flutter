import 'package:equatable/equatable.dart';

class CheckFavorite extends FavoriteCheckerEvent {
  final int storyId;
  CheckFavorite(this.storyId);
  @override
  List<Object> get props => [storyId];
}

class DeleteValueEvent extends FavoriteCheckerEvent {}

abstract class FavoriteCheckerEvent extends Equatable {
  const FavoriteCheckerEvent();
  @override
  List<Object> get props => [];
}
