import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/global_bloc.dart';
import 'package:quran/consts/ayat_text_info.dart';
import 'package:quran/consts/hizb_info.dart';
import 'package:quran/consts/page_info.dart';
import 'package:quran/consts/routes.dart';
import 'package:quran/consts/shared_prefs.dart';
import 'package:quran/consts/surah_info.dart';
import 'package:quran/page/HomePage.dart';
import 'package:quran/page/IndexPage.dart';
import 'package:quran/page/SeachPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


void loadAsyn() async {
  await AyatTextInfo.parseData();

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PageInfo.parseData();
  SurahInfo.parseData();
  HizbInfo.parseData();

  SharedPrefs.prefs = await SharedPreferences.getInstance(); 

  
  runApp(const Quran());
}
class Quran extends StatelessWidget {
  const Quran({super.key});



  @override
  Widget build(BuildContext context) {
  loadAsyn();

    return BlocProvider(
      create: (context) => GlobalBloc(),
      child: MaterialApp(
        title: 'Quran',
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.Home: (context) => HomePage(),
          Routes.Index: (context) => IndexPage(),
          Routes.Search: (context) => SearchPage(),
        },
        initialRoute: Routes.Home ,
      ),
    );
  }
}
