part of 'page_info_cubit.dart';

class PageInfoState extends Equatable {
  int pageIdx = 1;
  bool overlayVisible = false;

  PageInfoState({
    this.pageIdx = 1,
    this.overlayVisible = false,
  });

  PageInfoState copyWith({
    int? pageIdx,
    bool? overlayVisible,
  }) =>
      PageInfoState(
        pageIdx: pageIdx ?? this.pageIdx,
        overlayVisible: overlayVisible ?? this.overlayVisible,
      );

  @override
        
  List<Object> get props => [pageIdx,overlayVisible];
}
