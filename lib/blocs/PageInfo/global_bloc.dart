import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran/blocs/PageInfo/global_event.dart';
import 'package:quran/consts/ayat_text_info.dart';
import 'package:quran/consts/shared_prefs.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<SetPageIndex>(setPageIndex);
    on<JumpToPage>(jumpToPage);
    on<ResetJump>(resetJump);
    on<ToggleOverlay>(toggleOverlay);
    on<SetLatestIndexTab>(setLatestIndexTab);
    on<SearchForAya>(searchForAya);
    on<BookmarkPage>(bookmarkPage);
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

  void searchForAya(SearchForAya event, emit) {
    if (event.text == "") {
      emit(state.copyWith(searchedAyat: [], lastedSearched: ""));
    } else {
      emit(
        state.copyWith(
          searchedAyat: AyatTextInfo.searchInAyat(event.text),
          lastedSearched: event.text,
        ),
      );
    }
  }

  void bookmarkPage(BookmarkPage event, emit) async {
    int pageIdx = state.pageIdx;
    int savedPage = SharedPrefs.prefs.getInt(SharedPrefs.SavedPage) ?? -1;
    if (savedPage == pageIdx) {
      await SharedPrefs.prefs.remove(SharedPrefs.SavedPage);
    } else {
      await SharedPrefs.prefs.setInt(SharedPrefs.SavedPage, pageIdx);
    }

    emit(state.copyWith(toggleUpdate: !state.toggleUpdate));
  }
}
