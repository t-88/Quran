import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundBluredContainer extends StatelessWidget {
  BackgroundBluredContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: child,
      ),
    );
  }
}