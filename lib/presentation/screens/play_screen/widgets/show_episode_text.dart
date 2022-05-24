import 'package:flutter/material.dart';

class ShowEpisodeText extends StatelessWidget {
  const ShowEpisodeText({Key? key, required this.episode}) : super(key: key);

  final Animation<double>? episode;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -60,
      child: FadeTransition(
        opacity: episode!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'S1 : E1 "Episode 1: Un mal día',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(width: 140),
            Text(
              '53 min',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}
