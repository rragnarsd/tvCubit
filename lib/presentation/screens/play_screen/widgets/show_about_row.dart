import 'package:flutter/material.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_about_text.dart';

class ShowAboutRow extends StatelessWidget {
  const ShowAboutRow({
    Key? key,
    required this.info,
  }) : super(key: key);

  final Animation<double>? info;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -15,
      child: FadeTransition(
        opacity: info!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ShowAboutText(
              mainText: '18+',
            ),
            SizedBox(width: 10),
            ShowAboutText(
              mainText: 'Locked Up',
            ),
            SizedBox(width: 10),
            ShowAboutText(
              mainText: 'Prison',
            ),
          ],
        ),
      ),
    );
  }
}
