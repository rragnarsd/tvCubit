import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
    required this.radius,
    required this.border,
  }) : super(key: key);

  final double blur;
  final double opacity;
  final Widget child;
  final BorderRadius radius;
  final Border border;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff2f2c28).withOpacity(
              opacity,
            ),
            borderRadius: radius,
            border: border,
          ),
          child: child,
        ),
      ),
    );
  }
}
