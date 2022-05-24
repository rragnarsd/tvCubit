import 'package:flutter/material.dart';

class ShowTitle extends StatelessWidget {
  const ShowTitle({
    Key? key,
    required this.name,
  }) : super(key: key);

  final Animation<double>? name;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      child: FadeTransition(
        opacity: name!,
        child: Text(
          'Locked Up',
          style: Theme.of(context).textTheme.headline1!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1),
        ),
      ),
    );
  }
}