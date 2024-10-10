import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/global_bloc.dart';
import 'package:quran/blocs/PageInfo/global_event.dart';
import 'package:quran/comps/InfoOverlay.dart';
import 'package:quran/comps/ReadingArea.dart';
import 'package:quran/consts/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  void initState() {
    context.read<GlobalBloc>().add(JumpToPage(SharedPrefs.prefs.getInt(SharedPrefs.LastPage) ?? 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ReadingArea(),
          ...InfoOverlay(context),
        ],
      ),
    );
  }
}
