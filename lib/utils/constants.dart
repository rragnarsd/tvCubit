import 'package:flutter/material.dart';

const kBoxDecorationWithGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xff211F1C),
      Color(0xff605C56),
      Color(0xff59524F),
      Color(0xff2f2c28),
    ],
  ),
);

final kBoxShadow = BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
    BoxShadow(
      color: const Color(0xff211F1C).withOpacity(0.4),
      offset: const Offset(
        3.0,
        3.0,
      ),
      blurRadius: 10.0,
    ), //BoxShadow
  ],
);
