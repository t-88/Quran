import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/page_info_bloc.dart';
import 'package:quran/comps/BackgroundBluredContainer.dart';
import 'package:quran/consts/page_info.dart';
import 'package:quran/consts/routes.dart';
import 'package:quran/consts/surah_info.dart';
import 'package:quran/consts/text_and_vars.dart';

const Duration _opacityDuration = Duration(milliseconds: 200);
late Color _backgroundColor;

enum _Options { more, bookmark, search, iindex }

void selectOption(BuildContext context, _Options option) {
  switch (option) {
    case _Options.iindex:
      Navigator.pushNamed(context, Routes.Index);
      break;
    case _Options.search:
      break;
    case _Options.bookmark:
      break;
    case _Options.more:
      break;
  }
}

List<Widget> InfoOverlay(BuildContext context) {
  _backgroundColor = Colors.grey.withOpacity(0.1);

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
      "icon": Icon(Icons.more_vert, color: Colors.black),
    },
    {
      "option": _Options.bookmark,
      "icon": Icon(Icons.bookmark_outline, color: Colors.black),
    },
    {
      "option": _Options.search,
      "icon": Icon(Icons.search, color: Colors.black),
    },
    {
      "option": _Options.iindex,
      "icon": Icon(Icons.toc_outlined, color: Colors.black),
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
                        onTap: () => selectOption(
                            context, data[1]["option"] as _Options),
                        child: Container(
                            height: 100, child: data[1]["icon"] as Icon),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () => selectOption(
                            context, data[2]["option"] as _Options),
                        child: Container(
                            height: 100, child: data[2]["icon"] as Icon),
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
