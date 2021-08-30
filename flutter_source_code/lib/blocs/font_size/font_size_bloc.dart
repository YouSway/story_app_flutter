import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/font_size/font_size_event.dart';

class FontSizeBloc extends Bloc<FontSizeEvent, double> {
  @override
  double get initialState => 16;

  @override
  Stream<double> mapEventToState(FontSizeEvent event) async* {
    if (event is IncreaseSize) {
      if (state < 20) {
        yield (state + 1);
      }
    } else if (event is DecreaseSize) {
      if (state > 10) {
        yield (state - 1);
      }
    }
  }
}
