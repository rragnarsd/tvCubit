import 'package:flutter/material.dart';

class ProfileAboutText extends StatelessWidget {
  const ProfileAboutText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Regina',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          const SizedBox(height: 10),
          Text(
            'Manage your favorite tv-shows, personal info and privacy here!',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white.withOpacity(0.8), letterSpacing: 1),
          )
        ],
      ),
    );
  }
}