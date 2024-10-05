part of 'page_info_bloc.dart';

class GlobalState extends Equatable {
  int pageIdx = 1;
  int indexPageJump = -1;
  bool overlayVisible = false;

  int lastestIndexTab = 0;

  GlobalState({
    this.pageIdx = 1,
    this.overlayVisible = false,
    this.indexPageJump = -1,
    this.lastestIndexTab = 0,
  });

  GlobalState copyWith({
    int? pageIdx,
    bool? overlayVisible,
    int? indexPageJump,
    int? lastestIndexTab,
    
  }) =>
      GlobalState(
        pageIdx: pageIdx ?? this.pageIdx,
        overlayVisible: overlayVisible ?? this.overlayVisible,
        indexPageJump: indexPageJump ?? this.indexPageJump,
        lastestIndexTab: lastestIndexTab ?? this.lastestIndexTab,
        
        
      );

  @override
        
  List<Object> get props => [pageIdx,overlayVisible,indexPageJump,lastestIndexTab];
}
