import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/global_bloc.dart';
import 'package:quran/blocs/PageInfo/global_event.dart';
import 'package:quran/consts/hizb_info.dart';
import 'package:quran/consts/page_info.dart';
import 'package:quran/consts/routes.dart';
import 'package:quran/consts/surah_info.dart';
import 'package:quran/consts/text_and_vars.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    controller = TabController(
        length: 2,
        vsync: this,
        initialIndex: context.read<GlobalBloc>().state.lastestIndexTab)
      ..addListener(() {
        context.read<GlobalBloc>().add(SetLatestIndexTab(controller.index));
        setState(() {
          controller.index;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Consts.FAHRAS_ARABIC_TEXT),
            backgroundColor: Colors.white,
            elevation: 2,
            surfaceTintColor: Colors.grey.withOpacity(0.1),
            shadowColor: Colors.grey.withOpacity(0.2),
            bottom: TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              controller: controller,
              tabs: [
                Tab(text: Consts.AL_SUWAR_ARABIC_TEXT),
                Tab(text: Consts.AL_AHZAB_ARABIC_TEXT),
              ],
            ),
          ),
          body: controller.index == 0 ? _suwar_index() : _ahzab_index(),
        ),
      ),
    );
  }

  ListView _suwar_index() {
    void onSelectSurah(int index) {
      context
          .read<GlobalBloc>()
          .add(JumpToPage(SurahInfo.getSurah(index).startPage));
      Navigator.pop(context);
    }

    void onSelectSurahInfo(int index) {}

    return ListView.builder(
      itemCount: 114,
      itemBuilder: (context, index) => index == 0
          ? SizedBox()
          : InkWell(
              onTap: () {
                onSelectSurah(index);
              },
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? Colors.grey.withOpacity(0.05)
                      : Colors.white.withOpacity(0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SurahInfo.getSurah(index).name_arabic,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 32),
                    Text(
                      SurahInfo.getSurah(index).startPage.toString() +
                          "  " *
                              (max(
                                0,
                                3 -
                                    SurahInfo.getSurah(index)
                                        .startPage
                                        .toString()
                                        .length,
                              )),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  ListView _ahzab_index() {
    void onSelectHizb(index) {
      context
          .read<GlobalBloc>()
          .add(JumpToPage(HizbInfo.getHizb(index).startPage));
      Navigator.pop(context);
    }

    return ListView.builder(
      itemCount: 61,
      itemBuilder: (context, index) => index == 0
          ? SizedBox()
          : InkWell(
              onTap: () => onSelectHizb(index - 1),
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? Colors.grey.withOpacity(0.05)
                      : Colors.white.withOpacity(0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "حزب  ${index}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          textAlign: TextAlign.start,
                          HizbInfo.getHizb(index - 1).startVerse.toString(),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Row(
                      children: [
                        Text(
                          HizbInfo.getHizb(index - 1).startPage.toString() +
                              "  " *
                                  (max(
                                      0,
                                      3 -
                                          HizbInfo.getHizb(index - 1)
                                              .startPage
                                              .toString()
                                              .length)),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
