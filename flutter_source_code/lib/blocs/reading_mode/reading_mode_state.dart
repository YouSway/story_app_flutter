import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_story_app/utils/constants.dart';

class DarkMode extends ReadingModeState {
  final Mode mode = new Mode(DARK_TEXT_COLOR, DARK_BACKGROUND_COLOR,
      DARK_ICON_COLOR, DARK_ICON_BACKGROUND_COLOR);
  @override
  List<Object> get props => [mode];
}

class LightMode extends ReadingModeState {
  final Mode mode = new Mode(LIGHT_TEXT_COLOR, LIGHT_BACKGROUND_COLOR,
      LIGHT_ICON_COLOR, LIGHT_ICON_BACKGROUND_COLOR);
  @override
  List<Object> get props => [mode];
}

class Mode {
  Color textColor;
  Color backgroundColor;
  Color iconColor;
  Color iconBackgroundColor;

  Mode(this.textColor, this.backgroundColor, this.iconColor,
      this.iconBackgroundColor);
}

abstract class ReadingModeState extends Equatable {
  final Mode mode = new Mode(DARK_TEXT_COLOR, DARK_BACKGROUND_COLOR,
      DARK_ICON_COLOR, DARK_ICON_BACKGROUND_COLOR);
  @override
  List<Object> get props => [mode];
}
