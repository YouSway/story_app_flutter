import 'package:equatable/equatable.dart';

class PageControllerChangePage extends PageControllerEvent {
  final pageNumber;
  PageControllerChangePage(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

abstract class PageControllerEvent extends Equatable {
  const PageControllerEvent();

  @override
  List<Object> get props => [];
}
