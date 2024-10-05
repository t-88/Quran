import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/page_info_bloc.dart';
import 'package:quran/blocs/PageInfo/page_info_event.dart';
import 'package:quran/comps/QuranPage.dart';

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
      if(context.read<GlobalBloc>().state.indexPageJump != -1) return;
      int nextIdx =
          (_scrollController.offset / MediaQuery.of(context).size.width)
                  .round() +
              1;
      if (nextIdx != context.read<GlobalBloc>().state.pageIdx) {
        context.read<GlobalBloc>().add(SetPageIndex(nextIdx));
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
        onTap: () => context.read<GlobalBloc>().add(ToggleOverlay()),
        child: BlocListener<GlobalBloc, GlobalState>(
          listener: (context, state) async {

            if (state.indexPageJump != -1 && _scrollController.hasClients) {
              await _scrollController.animateTo(
                state.indexPageJump * MediaQuery.of(context).size.width,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
              );
              context.read<GlobalBloc>().add(ResetJump());
            }
          },
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            
            reverse: true,
            
            itemCount: 605,
            itemBuilder: (ctx, idx) => QuranPage(pageIdx: idx),
          ),
        ),
      ),
    );
  }
}
