// ignore_for_file: 

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/page_info_bloc.dart';
import 'package:quran/consts/hizb_info.dart';
import 'package:quran/consts/page_info.dart';
import 'package:quran/consts/routes.dart';
import 'package:quran/consts/surah_info.dart';
import 'package:quran/page/HomePage.dart';
import 'package:quran/page/IndexPage.dart';


void main() {
  PageInfo.parseData();
  SurahInfo.parseData();
  HizbInfo.parseData();
  
  runApp(const Quran());
}
class Quran extends StatelessWidget {
  const Quran({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalBloc(),
      child: MaterialApp(
        title: 'Quran',
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.Home: (context) => HomePage(),
          Routes.Index: (context) => IndexPage(),
        },
        initialRoute: Routes.Home ,
        home: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}
