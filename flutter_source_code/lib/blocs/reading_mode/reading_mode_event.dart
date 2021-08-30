import 'package:equatable/equatable.dart';

abstract class ReadingModeEvent extends Equatable {
  const ReadingModeEvent();

  @override
  List<Object> get props => [];
}

class SwitchToDarkMode extends ReadingModeEvent {}

class SwitchToLightMode extends ReadingModeEvent {}
