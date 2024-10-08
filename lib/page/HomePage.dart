import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/global_bloc.dart';
import 'package:quran/comps/InfoOverlay.dart';
import 'package:quran/comps/ReadingArea.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
