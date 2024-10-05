

import 'package:flutter/material.dart';

class QuranPage extends StatelessWidget {
  QuranPage({super.key, required this.pageIdx});

  final int pageIdx;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        "assets/imgs/$pageIdx.png",
      ),
    );
  }
}
