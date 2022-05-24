import 'package:flutter/material.dart';
import 'package:tv_cubit/presentation/shared/widgets/glassmorphism.dart';

class ShowAboutText extends StatelessWidget {
  const ShowAboutText({
    Key? key,
    required this.mainText,
  }) : super(key: key);

  final String mainText;

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      blur: 20,
      opacity: 0.6,
      radius: BorderRadius.circular(12),
      border: Border.all(
        width: 0,
        color: Colors.brown.withOpacity(0.2),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          mainText,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white.withOpacity(0.8)),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff211F1C).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        width: MediaQuery.of(context).size.width * 0.25,
      ),
    );
  }
}
