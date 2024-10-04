import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'page_info_state.dart';

class PageInfoCubit extends Cubit<PageInfoState> {
  PageInfoCubit() : super(PageInfoState());

  void setPageIdx(int idx) {
    emit(state.copyWith(pageIdx: idx));
  }


  void toggleOverlay() {
    emit(state.copyWith(overlayVisible: !state.overlayVisible));
  }  
}
