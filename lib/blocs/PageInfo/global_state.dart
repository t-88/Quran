part of 'global_bloc.dart';

class GlobalState extends Equatable {
  int pageIdx = 1;
  int indexPageJump = -1;
  bool overlayVisible = false;
  bool toggleUpdate = false;
  
  int lastestIndexTab = 0;

  String lastedSearched;
  List<SearchResualtMeta> searchedAyat;

  GlobalState({
    this.pageIdx = 1,
    this.overlayVisible = false,
    this.toggleUpdate = false,
    
    this.indexPageJump = -1,
    this.lastestIndexTab = 0,
    this.searchedAyat = const [],
  this.lastedSearched = "",
  });

  GlobalState copyWith({
    int? pageIdx,
    bool? overlayVisible,
    int? indexPageJump,
    int? lastestIndexTab,
    List<SearchResualtMeta>? searchedAyat,
    String? lastedSearched,
    bool? toggleUpdate,

  }) =>
      GlobalState(
        pageIdx: pageIdx ?? this.pageIdx,
        overlayVisible: overlayVisible ?? this.overlayVisible,
        indexPageJump: indexPageJump ?? this.indexPageJump,
        lastestIndexTab: lastestIndexTab ?? this.lastestIndexTab,
        searchedAyat: searchedAyat ?? this.searchedAyat,
        lastedSearched: lastedSearched ?? this.lastedSearched,
        toggleUpdate: toggleUpdate ?? this.toggleUpdate,
        
      );

  @override
  List<Object> get props =>
      [pageIdx, overlayVisible, indexPageJump, lastestIndexTab, searchedAyat,toggleUpdate];
}
