import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class AyaMeta {
  String text = "";
  String text_complex = "";
  String key = "";
  AyaMeta(String text, String text_complex, String key) {
    this.text = text;
    this.text_complex = text_complex;
    this.key = key;
  }
}

class SearchResualtMeta {
  late AyaMeta aya;
  int start = 0;
  SearchResualtMeta(int start,AyaMeta aya) { 
    this.aya = aya;
    this.start = start;
  }

}

class AyatTextInfo {
  static List<AyaMeta> _ayat = [];
  static parseData() async {
    if (_ayat.length != 0) return;

    String _data = await rootBundle.loadString("assets/versesText.json");
    List<dynamic> _DATA = json.decode(_data);
    for (var i = 0; i < _DATA.length; i++) {
      _ayat.add(AyaMeta(
          _DATA[i]["text_imlaei_simple"]!,_DATA[i]["text_uthmani"]!,_DATA[i]["key"]!),);
    }

  }

  static List<SearchResualtMeta> searchInAyat(String text) {
    List<SearchResualtMeta> out = [];
    for (var i = 0; i < _ayat.length; i++) {
      int index = _ayat[i].text.indexOf(text); 
      if(index != -1) {
        out.add(SearchResualtMeta(index,_ayat[i]));
      }
    }
    return out;
  }
}
