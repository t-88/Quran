part of 'global_bloc.dart';

class GlobalState extends Equatable {
  int pageIdx = 1;
  int indexPageJump = -1;
  bool overlayVisible = false;
  bool toggleUpdate = false;
  
  int lastestIndexTab = 0;

  int lastReadPage = 0;

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
  this.lastReadPage = 0,
  });

  GlobalState copyWith({
    int? pageIdx,
    bool? overlayVisible,
    int? indexPageJump,
    int? lastestIndexTab,
    List<SearchResualtMeta>? searchedAyat,
    String? lastedSearched,
    bool? toggleUpdate,
    int ? lastReadPage

  })  {


      var gs =  GlobalState(
        pageIdx: pageIdx ?? this.pageIdx,
        overlayVisible: overlayVisible ?? this.overlayVisible,
        indexPageJump: indexPageJump ?? this.indexPageJump,
        lastestIndexTab: lastestIndexTab ?? this.lastestIndexTab,
        searchedAyat: searchedAyat ?? this.searchedAyat,
        lastedSearched: lastedSearched ?? this.lastedSearched,
        toggleUpdate: toggleUpdate ?? this.toggleUpdate,
        lastReadPage: lastReadPage ?? this.lastReadPage,
      );
      gs.lastReadPage = gs.pageIdx;
      
      SharedPrefs.prefs.setInt(SharedPrefs.LastPage, gs.lastReadPage);
      return gs;
  }

  @override
  List<Object> get props =>
      [pageIdx, overlayVisible, indexPageJump, lastestIndexTab, searchedAyat,toggleUpdate,lastReadPage];
}
