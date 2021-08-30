import 'package:equatable/equatable.dart';

abstract class TrendingListEvent extends Equatable {
  const TrendingListEvent();

  @override
  List<Object> get props => [];
}

class TrendingListFetchList extends TrendingListEvent {}
