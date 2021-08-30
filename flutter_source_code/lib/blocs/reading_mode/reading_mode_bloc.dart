import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_event.dart';
import 'package:flutter_story_app/blocs/reading_mode/reading_mode_state.dart';

class ReadingModeBloc extends Bloc<ReadingModeEvent, ReadingModeState> {
  @override
  ReadingModeState get initialState => DarkMode();

  @override
  Stream<ReadingModeState> mapEventToState(ReadingModeEvent event) async* {
    if (event is SwitchToDarkMode) {
      yield DarkMode();
    } else if (event is SwitchToLightMode) {
      yield LightMode();
    }
  }
}
