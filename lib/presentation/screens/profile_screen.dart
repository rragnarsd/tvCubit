import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/utils/constants.dart';

import '../widgets/fade_in_img.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _switch = false;

    return Container(
      decoration: kBoxDecorationWithGradient,
      child: SafeArea(
        child: Scaffold(
          body: Column(children: [
            const ProfileImg(),
            const SizedBox(height: 20),
            const ProfileAboutText(),
            const SizedBox(height: 20),
            Divider(
              thickness: 1.5,
              color: Colors.white.withOpacity(0.6),
              endIndent: 20,
              indent: 20,
            ),
            ProfileTile(
              text: 'Personal Info',
              iconLeft: FontAwesomeIcons.user,
              widget: FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            ProfileTile(
              text: 'Switch Theme',
              iconLeft: FontAwesomeIcons.lightbulb,
              widget: CupertinoSwitch(
                activeColor: const Color(0xffE7A71A),
                value: _switch,
                onChanged: (value) {},
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ProfileImg extends StatelessWidget {
  const ProfileImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FadeInImg(
        imgUrl:
            'https://images.pexels.com/photos/1188750/pexels-photo-1188750.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
    );
  }
}

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
