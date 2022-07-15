import 'dart:ui';

import 'package:flutter/material.dart';

Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(20, 10, animValue)!;
      return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        elevation: elevation,
        color: Theme.of(context).primaryColorLight,
        shadowColor: Colors.blue[300],
        child: child,
      );
    },
    child: child,
  );
}