import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/presentation/screens/profile_screen/widgets/profile_about_text.dart';
import 'package:tv_cubit/presentation/screens/profile_screen/widgets/profile_img.dart';
import 'package:tv_cubit/presentation/screens/profile_screen/widgets/profile_tile.dart';
import 'package:tv_cubit/utils/constants.dart';

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