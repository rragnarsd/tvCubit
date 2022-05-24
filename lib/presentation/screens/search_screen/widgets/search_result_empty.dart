import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchResultEmpty extends StatelessWidget {
  const SearchResultEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          size: 55,
        ),
        const SizedBox(height: 20),
        Text(
          'No results to display',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
      ],
    );
  }
}
