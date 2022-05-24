import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.white.withOpacity(0.4),
          size: 20,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.4),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      hintText: 'Search',
      hintStyle: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Colors.white.withOpacity(0.2)),
    );
  }