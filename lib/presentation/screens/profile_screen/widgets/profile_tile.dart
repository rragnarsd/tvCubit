import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {Key? key,
      required this.text,
      required this.iconLeft,
      required this.widget})
      : super(key: key);
  final String text;
  final Widget widget;
  final IconData iconLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ListTile(
        leading: FaIcon(
          iconLeft,
          color: Colors.white.withOpacity(0.5),
        ),
        title: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white.withOpacity(0.5)),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: widget,
        ),
      ),
    );
  }
}
