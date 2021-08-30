import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/page_controller/page_controller_event.dart';
import 'package:flutter_story_app/utils/constants.dart';

class PageControllerBloc extends Bloc<PageControllerEvent, double> {
  @override
  double get initialState => (TRENDING_LIST_ITEM_COUNT - 1).toDouble();

  @override
  Stream<double> mapEventToState(PageControllerEvent event) async* {
    if (event is PageControllerChangePage) {
      yield event.pageNumber;
    }
  }
}
