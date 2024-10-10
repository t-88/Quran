import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/global_bloc.dart';
import 'package:quran/blocs/PageInfo/global_event.dart';
import 'package:quran/comps/BackgroundBluredContainer.dart';
import 'package:quran/consts/page_info.dart';
import 'package:quran/consts/routes.dart';
import 'package:quran/consts/shared_prefs.dart';
import 'package:quran/consts/surah_info.dart';
import 'package:quran/consts/text_and_vars.dart';

const Duration _opacityDuration = Duration(milliseconds: 200);
late Color _backgroundColor;

enum _Options { more, bookmark, search, iindex, jump }

void selectOption(BuildContext context, _Options option) async {
  switch (option) {
    case _Options.iindex:
      Navigator.pushNamed(context, Routes.Index);
      break;
    case _Options.search:
      Navigator.pushNamed(context, Routes.Search);
      break;
    case _Options.bookmark:
      context.read<GlobalBloc>().add(BookmarkPage());

      break;

    case _Options.more:
      break;

    case _Options.jump:
      int index = SharedPrefs.prefs.getInt(SharedPrefs.SavedPage)!;
      if (index != 0) index -= 1;
      context.read<GlobalBloc>().add(JumpToPage(index));
      break;
  }
}

List<Widget> InfoOverlay(BuildContext context) {
  _backgroundColor = Colors.black.withOpacity(0.8);

  return [
    _cur_page_info(),
    _bottom_options(),
  ];
}

Widget _cur_page_info() {
  return Positioned(
    top: 0,
    child: BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) => AnimatedOpacity(
        opacity: state.overlayVisible ? 1 : 0,
        duration: _opacityDuration,
        child: IgnorePointer(
          child: Material(
            color: Colors.transparent,
            child: BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                return BackgroundBluredContainer(
                  child: Container(
                    color: _backgroundColor,
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Text.rich(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            TextSpan(
                              children: [
                                TextSpan(text: Consts.HIZB_ARABIC_TEXT),
                                TextSpan(
                                  text: PageInfo.getPageInfo(state.pageIdx)
                                      .juzNum
                                      .toString(),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: (MediaQuery.of(context).size.width -
                                  ("${state.pageIdx - 1}".length + 1) * 16) /
                              2,
                          child: Text(
                            (state.pageIdx - 1).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Text(
                            Consts.SURAH_ARABIC_TEXT +
                                SurahInfo.getSurah(
                                  PageInfo.getPageInfo(state.pageIdx).surahNum!,
                                ).name_arabic,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _bottom_options() {
  List<Map<String, Object>> data = [
    {
      "option": _Options.more,
      "icon": Icon(Icons.more_vert, color: Colors.white),
    },
    {
      "option": _Options.bookmark,
      "icon": Icon(Icons.bookmark_outline, color: Colors.white),
      "filled": Icon(Icons.bookmark, color: Colors.white),
    },
    {
      "option": _Options.jump,
      "icon": Icon(Icons.bookmark_added, color: Colors.white),
    },
    {
      "option": _Options.search,
      "icon": Icon(Icons.search, color: Colors.white),
    },
    {
      "option": _Options.iindex,
      "icon": Icon(Icons.toc_outlined, color: Colors.white),
    },
  ];

  return Positioned(
    bottom: 0,
    child: BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) => AnimatedOpacity(
        opacity: state.overlayVisible ? 1 : 0,
        duration: _opacityDuration,
        child: Material(
          color: Colors.transparent,
          child: BackgroundBluredContainer(
            child: Container(
              color: _backgroundColor,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () => selectOption(
                            context, data[0]["option"] as _Options),
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          height: 100,
                          child: data[0]["icon"] as Icon,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: state.pageIdx !=
                                    (SharedPrefs.prefs
                                            .getInt(SharedPrefs.SavedPage) ??
                                        -1) &&
                                SharedPrefs.prefs
                                        .getInt(SharedPrefs.SavedPage) !=
                                    null
                            ? () => selectOption(context, _Options.jump)
                            : null,
                        child: Container(
                          height: 100,
                          child: Icon(Icons.bookmark_added,
                              color: state.pageIdx !=
                                          (SharedPrefs.prefs.getInt(
                                                  SharedPrefs.SavedPage) ??
                                              -1) &&
                                      SharedPrefs.prefs
                                              .getInt(SharedPrefs.SavedPage) !=
                                          null
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () => selectOption(
                            context, data[1]["option"] as _Options),
                        child: Container(
                          height: 100,
                          child: state.pageIdx ==
                                  (SharedPrefs.prefs
                                          .getInt(SharedPrefs.SavedPage) ??
                                      -1)
                              ? data[1]["filled"] as Icon
                              : data[1]["icon"] as Icon,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () => selectOption(
                            context, data[3]["option"] as _Options),
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          height: 100,
                          child: data[3]["icon"] as Icon,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () => selectOption(
                            context, data[4]["option"] as _Options),
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          height: 100,
                          child: data[4]["icon"] as Icon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
