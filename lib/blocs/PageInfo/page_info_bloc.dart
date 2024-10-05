import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran/blocs/PageInfo/page_info_event.dart';

part 'page_info_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<SetPageIndex>(setPageIndex);
    on<JumpToPage>(jumpToPage);
    on<ResetJump>(resetJump);
    on<ToggleOverlay>(toggleOverlay);
    on<SetLatestIndexTab>(setLatestIndexTab);
  }

  void setPageIndex(SetPageIndex event, emit) {
    emit(state.copyWith(pageIdx: event.index));
  }

  void jumpToPage(JumpToPage event, emit) {
    emit(state.copyWith(indexPageJump: event.index, overlayVisible: true));
  }

  void resetJump(ResetJump event, emit) {
    if (state.indexPageJump == -1) return;
    emit(state.copyWith(indexPageJump: -1, pageIdx: state.indexPageJump + 1));
  }

  void toggleOverlay(ToggleOverlay event, emit) {
    emit(state.copyWith(overlayVisible: !state.overlayVisible));
  }

  void setLatestIndexTab(SetLatestIndexTab event, emit) {
    emit(state.copyWith(lastestIndexTab: event.index));
  }
}
