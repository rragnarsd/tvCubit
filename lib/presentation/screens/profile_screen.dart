import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? title;
  Animation<double>? description;
  Animation<double>? divider;
  Animation<double>? listTileOne;
  Animation<double>? listTileTwo;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    title = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)));
    description = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.4)));
    divider = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.6)));
    listTileOne = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)));
    listTileTwo = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1)));

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _switch = false;

    return Container(
      decoration: kBoxDecorationWithGradient,
      child: SafeArea(
        child: Scaffold(
          body: Column(children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                //TODO - shimmer?
                child: FadeInImage.assetNetwork(
                  placeholderFit: BoxFit.cover,
                  height: 200,
                  fadeInCurve: Curves.easeIn,
                  placeholder: 'assets/placeholder.png',
                  image:
                      'https://images.pexels.com/photos/1188750/pexels-photo-1188750.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                    opacity: title!,
                    child: Text(
                      'Welcome, Regina',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeTransition(
                    opacity: description!,
                    child: Text(
                      'Manage your favorite tv-shows, personal info and privacy here!',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 1),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: divider!,
              child: Divider(
                thickness: 1.5,
                color: Colors.white.withOpacity(0.6),
                endIndent: 20,
                indent: 20,
              ),
            ),
            FadeTransition(
              opacity: listTileOne!,
              child: ProfileTile(
                text: 'Personal Info',
                iconLeft: FontAwesomeIcons.user,
                widget: FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
            FadeTransition(
              opacity: listTileTwo!,
              child: ProfileTile(
                text: 'Switch Theme',
                iconLeft: FontAwesomeIcons.user,
                widget: CupertinoSwitch(
                  activeColor: const Color(0xffE7A71A),
                  value: _switch,
                  onChanged: (value) {},
                ),
              ),
            ),
          ]),
        ),
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
