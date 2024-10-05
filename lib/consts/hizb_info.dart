import 'dart:ffi';

var _DATA = [
  {"start_page": 1, "verse_key": "1:1"},
  {"start_page": 11, "verse_key": "2:75"},
  {"start_page": 22, "verse_key": "2:142"},
  {"start_page": 32, "verse_key": "2:203"},
  {"start_page": 42, "verse_key": "2:253"},
  {"start_page": 51, "verse_key": "3:15"},
  {"start_page": 62, "verse_key": "3:93"},
  {"start_page": 72, "verse_key": "3:171"},
  {"start_page": 82, "verse_key": "4:24"},
  {"start_page": 92, "verse_key": "4:88"},
  {"start_page": 102, "verse_key": "4:148"},
  {"start_page": 112, "verse_key": "5:27"},
  {"start_page": 121, "verse_key": "5:82"},
  {"start_page": 132, "verse_key": "6:36"},
  {"start_page": 142, "verse_key": "6:111"},
  {"start_page": 151, "verse_key": "7:1"},
  {"start_page": 162, "verse_key": "7:88"},
  {"start_page": 173, "verse_key": "7:171"},
  {"start_page": 182, "verse_key": "8:41"},
  {"start_page": 192, "verse_key": "9:34"},
  {"start_page": 201, "verse_key": "9:93"},
  {"start_page": 212, "verse_key": "10:26"},
  {"start_page": 222, "verse_key": "11:6"},
  {"start_page": 231, "verse_key": "11:84"},
  {"start_page": 242, "verse_key": "12:53"},
  {"start_page": 252, "verse_key": "13:19"},
  {"start_page": 262, "verse_key": "15:1"},
  {"start_page": 272, "verse_key": "16:51"},
  {"start_page": 282, "verse_key": "17:1"},
  {"start_page": 292, "verse_key": "17:99"},
  {"start_page": 302, "verse_key": "18:75"},
  {"start_page": 312, "verse_key": "20:1"},
  {"start_page": 322, "verse_key": "21:1"},
  {"start_page": 332, "verse_key": "22:1"},
  {"start_page": 342, "verse_key": "23:1"},
  {"start_page": 352, "verse_key": "24:21"},
  {"start_page": 362, "verse_key": "25:21"},
  {"start_page": 371, "verse_key": "26:111"},
  {"start_page": 382, "verse_key": "27:56"},
  {"start_page": 392, "verse_key": "28:51"},
  {"start_page": 402, "verse_key": "29:46"},
  {"start_page": 413, "verse_key": "31:22"},
  {"start_page": 422, "verse_key": "33:31"},
  {"start_page": 431, "verse_key": "34:24"},
  {"start_page": 442, "verse_key": "36:28"},
  {"start_page": 451, "verse_key": "37:145"},
  {"start_page": 462, "verse_key": "39:32"},
  {"start_page": 472, "verse_key": "40:41"},
  {"start_page": 482, "verse_key": "41:47"},
  {"start_page": 491, "verse_key": "43:24"},
  {"start_page": 502, "verse_key": "46:1"},
  {"start_page": 513, "verse_key": "48:18"},
  {"start_page": 522, "verse_key": "51:31"},
  {"start_page": 531, "verse_key": "55:1"},
  {"start_page": 542, "verse_key": "58:1"},
  {"start_page": 553, "verse_key": "62:1"},
  {"start_page": 562, "verse_key": "67:1"},
  {"start_page": 572, "verse_key": "72:1"},
  {"start_page": 582, "verse_key": "78:1"},
  {"start_page": 591, "verse_key": "87:1"}
];


class HizbMeta {
  int startPage = 0;
  String startVerse  = "";
  HizbMeta(int startPage,String startVerse) {
    this.startPage = startPage;
    this.startVerse = startVerse;
  } 
}

class HizbInfo { 
  static List<HizbMeta> _hizbs = [];
  static parseData() {
    if(_hizbs.length != 0) return;
    for(var i = 0; i < _DATA.length; i++) {
      _hizbs.add(HizbMeta(_DATA[i]["start_page"] as int, _DATA[i]["verse_key"] as String));
    }
  }
  static HizbMeta getHizb(int idx) {
    return _hizbs[idx];
  }
}
