import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/blocs/PageInfo/global_bloc.dart';
import 'package:quran/blocs/PageInfo/global_event.dart';
import 'package:quran/consts/ayat_text_info.dart';
import 'package:quran/consts/page_info.dart';
import 'package:quran/consts/surah_info.dart';
import 'package:quran/consts/text_and_vars.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode _focusNode = FocusNode();
  OutlineInputBorder _border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  );
  @override
  void initState() {
    super.initState();
    if(context.read<GlobalBloc>().state.lastedSearched.length == 0) {
          _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    void onChange(String text) async {
      await AyatTextInfo.parseData();
      context.read<GlobalBloc>().add(SearchForAya(text));
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              _search_bar(onChange),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: BlocBuilder<GlobalBloc, GlobalState>(
                    builder: (context, state) {
                      if (state.lastedSearched.length != 0 &&
                          state.searchedAyat.length == 0) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                Consts.NO_FOUND_ARABIC_TEXT,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        );
                      } else if (state.lastedSearched.length == 0) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                Consts.SEARCH_FOR_AYAT,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.searchedAyat.length,
                        itemBuilder: (context, index) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: SearchedAyaPreview(
                            searchResualt: state.searchedAyat[index],
                            searchedText: state.lastedSearched,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _search_bar(void onChange(String text)) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Container(
          height: 60,
          margin: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              initialValue: state.lastedSearched,
              focusNode: _focusNode,
              cursorColor: Color(0xFF808080),
              onChanged: (text) => onChange(text),
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: _border,
                enabledBorder: _border,
                focusedBorder: _border,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF808080),
                ),
                label: Text(
                  Consts.SEARCH_FOR_AYA_ARABIC_TEXT,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF505050),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SearchedAyaPreview extends StatelessWidget {
  SearchedAyaPreview({
    super.key,
    required this.searchResualt,
    required this.searchedText,
  });

  SearchResualtMeta searchResualt;
  String searchedText;

  void onSelectAya(BuildContext context) {
    context.read<GlobalBloc>().add(JumpToPage(
        SurahInfo.getSurah(int.parse(searchResualt.aya.key.split(":")[0]))
            .startPage));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => onSelectAya(context),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: searchResualt.aya.text
                          .substring(0, searchResualt.start),
                    ),
                    TextSpan(
                      text: searchedText,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: searchResualt.aya.text
                          .substring(searchResualt.start + searchedText.length),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  SurahInfo.getSurah(
                              int.parse(searchResualt.aya.key.split(":")[0]))
                          .name_arabic +
                      " : " +
                      searchResualt.aya.key.split(":")[1],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
