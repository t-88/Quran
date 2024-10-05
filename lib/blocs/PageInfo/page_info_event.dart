
import 'package:equatable/equatable.dart';

sealed class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class SetPageIndex extends GlobalEvent {
  int index;
  SetPageIndex(this.index);
    @override
  List<Object> get props => [index];
}

class JumpToPage extends GlobalEvent {
  int index;
  JumpToPage(this.index);
    @override
  List<Object> get props => [index];

}

class SetLatestIndexTab extends GlobalEvent {
  int index;
  SetLatestIndexTab(this.index);
    @override
  List<Object> get props => [index];

}

class ResetJump extends GlobalEvent {
}


class ToggleOverlay extends GlobalEvent {}

