import 'package:equatable/equatable.dart';

class DecreaseSize extends FontSizeEvent {}

abstract class FontSizeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IncreaseSize extends FontSizeEvent {}
