import 'package:flutter/material.dart';

class FadeInImg extends StatelessWidget {
  const FadeInImg({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.9,
        frameBuilder: (context, child, int? frame, bool wasLoaded) {
          if (wasLoaded) {
            return child;
          }
          return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: child);
        },
        errorBuilder: (context, object, stacktrace) {
          return const SizedBox();
        },
      ),
    );
  }
}
