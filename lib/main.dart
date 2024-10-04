import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/page_info_cubit.dart';
import 'package:quran/consts/page_info.dart';
import 'package:quran/consts/surah_info.dart';

const MAX_PAGES = 605;
const HIZB_ARABIC_TEXT = "الحزب ";
const JUZ_ARABIC_TEXT = "الجزء ";
const RUB_ARABIC_TEXT = "الريع ";
const SURAH_ARABIC_TEXT = "سورة ";

void main() {
  PageInfo.parseData();
  SurahInfo.parseData();
  runApp(const Quran());
}

class Quran extends StatelessWidget {
  const Quran({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageInfoCubit(),
      child: MaterialApp(
        title: 'Quran',
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Stack(
            children: [
              ReadingArea(),
              ...Overlay(context),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundBluredContainer extends StatelessWidget {
  BackgroundBluredContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: child,
      ),
    );
  }
}

List<Widget> Overlay(context) {
  List<Icon> icons = [
    Icon(
      Icons.more_vert,
      color: Colors.black,
    ),
    Icon(
      Icons.bookmark_outline,
      color: Colors.black,
    ),
    Icon(
      Icons.search,
      color: Colors.black,
    ),
    Icon(
      Icons.toc_outlined,
      color: Colors.black,
    ),
  ];

  List<String> options = ["more", "bookmark", "search", "index"];

  void selectOption(String option) {
    if (options.indexOf(option) == -1) return;
    debugPrint(option);
  }

  Duration opacityDuration = Duration(milliseconds: 200);

  Widget _cur_page_info() {
    return Positioned(
      top: 0,
      child: BlocBuilder<PageInfoCubit, PageInfoState>(
        builder: (context, state) => AnimatedOpacity(
          opacity: state.overlayVisible ? 1 : 0,
          duration: opacityDuration,
          child: IgnorePointer(
            child: Material(
              color: Colors.transparent,
              child: BlocBuilder<PageInfoCubit, PageInfoState>(
                builder: (context, state) {
                  return BackgroundBluredContainer(
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
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
                                  TextSpan(text: HIZB_ARABIC_TEXT),
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
                              SURAH_ARABIC_TEXT +
                                  SurahInfo.getSurah(
                                    PageInfo.getPageInfo(state.pageIdx)
                                        .surahNum!,
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
    return Positioned(
      bottom: 0,
      child: BlocBuilder<PageInfoCubit, PageInfoState>(
        builder: (context, state) => AnimatedOpacity(
          opacity: state.overlayVisible ? 1 : 0,
          duration: opacityDuration,
          child: Material(
            color: Colors.transparent,
            child: BackgroundBluredContainer(
              child: Container(
                color: Colors.grey.withOpacity(0.1),
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
                          onTap: () => selectOption(options[0]),
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            height: 100,
                            child: icons[0],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () => selectOption(options[1]),
                          child: Container(height: 100, child: icons[1]),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () => selectOption(options[2]),
                          child: Container(height: 100, child: icons[2]),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () => selectOption(options[3]),
                          child: Container(
                              padding: EdgeInsets.only(right: 20),
                              height: 100,
                              child: icons[3]),
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

  return [
    _cur_page_info(),
    _bottom_options(),
  ];

}

class ReadingArea extends StatefulWidget {
  ReadingArea({super.key});

  @override
  State<ReadingArea> createState() => _ReadingAreaState();
}

class _ReadingAreaState extends State<ReadingArea> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      int nextIdx =
          (_scrollController.offset / MediaQuery.of(context).size.width)
                  .round() +
              1;
      if (nextIdx != context.read<PageInfoCubit>().state.pageIdx) {
        context.read<PageInfoCubit>().setPageIdx(nextIdx);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: GestureDetector(
        onTap: () => context.read<PageInfoCubit>().toggleOverlay(),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: 605,
                itemBuilder: (ctx, idx) => QuranPage(pageIdx: idx),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuranPage extends StatelessWidget {
  QuranPage({super.key, required this.pageIdx});

  final int pageIdx;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        "assets/imgs/$pageIdx.png",
      ),
    );
  }
}
