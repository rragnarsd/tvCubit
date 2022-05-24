import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowInfo extends StatelessWidget {
  const ShowInfo({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Animation<double>? season;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      child: FadeTransition(
        opacity: season!,
        child: Row(children: [
          Text(
            'New',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(width: 10),
          SizedBox(
            child: FaIcon(
              FontAwesomeIcons.solidCircle,
              color: Colors.white.withOpacity(0.8),
              size: 5,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Season 1',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white.withOpacity(0.8)),
          ),
        ]),
      ),
    );
  }
}
