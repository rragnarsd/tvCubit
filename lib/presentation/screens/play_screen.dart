import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/presentation/widgets/glassmorphism.dart';

import '../widgets/btn_with_extra_border.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? season;
  Animation<double>? name;
  Animation<double>? info;
  Animation<double>? episode;
  Animation<double>? progress;
  Animation<double>? button;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    season = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)));
    name = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.4)));
    info = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.6)));
    episode = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)));
    progress = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)));
    button = Tween<double>(begin: 0, end: 1).animate(
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          // decoration: kBoxDecorationWithGradient,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              buildShowImg(context),
              buildShowInfo(context),
              buildShowTitle(context),
              buildShowAbout(),
              buildShowEpisode(context),
              buildShowProgress(context),
              buildShowBtn()
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildShowBtn() {
    return Positioned(
      bottom: -200,
      left: 25,
      child: FadeTransition(
        opacity: button!,
        child: const BtnWithExtraBorder(
          btnText: 'Continue Watch',
        ),
      ),
    );
  }

  Positioned buildShowProgress(BuildContext context) {
    return Positioned(
      bottom: -80,
      child: FadeTransition(
        opacity: progress!,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.88,
          alignment: Alignment.topCenter,
          child: LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.white.withOpacity(0.5),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffE7A71A)),
          ),
        ),
      ),
    );
  }

  Positioned buildShowEpisode(BuildContext context) {
    return Positioned(
      bottom: -60,
      child: FadeTransition(
        opacity: episode!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextPlay(
              context,
              'S1 : E1 "Episode 1: Arrow',
            ),
            const SizedBox(width: 165),
            buildTextPlay(
              context,
              '60 min',
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildShowAbout() {
    return Positioned(
      bottom: -15,
      child: FadeTransition(
        opacity: info!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ShowAboutText(
              mainText: '18+',
            ),
            SizedBox(width: 10),
            ShowAboutText(
              mainText: 'Locked Up',
            ),
            SizedBox(width: 10),
            ShowAboutText(
              mainText: 'Prison',
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildShowTitle(BuildContext context) {
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

  Positioned buildShowInfo(BuildContext context) {
    return Positioned(
      bottom: 80,
      child: FadeTransition(
        opacity: season!,
        child: Row(children: [
          buildTextPlay(context, 'New'),
          const SizedBox(width: 10),
          SizedBox(
            child: FaIcon(
              FontAwesomeIcons.solidCircle,
              color: Colors.white.withOpacity(0.8),
              size: 5,
            ),
          ),
          const SizedBox(width: 10),
          buildTextPlay(context, 'Season 1'),
        ]),
      ),
    );
  }

  SizedBox buildShowImg(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff211F1C),
                Colors.transparent,
              ]).createShader(
            Rect.fromLTRB(0, 0, rect.width, rect.height),
          );
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          'https://browsecat.net/sites/default/files/vis-a-vis-wallpapers-87509-978456-5904185.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Text buildTextPlay(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: Colors.white.withOpacity(0.8)),
    );
  }
}

class ShowAboutText extends StatelessWidget {
  const ShowAboutText({
    Key? key,
    required this.mainText,
  }) : super(key: key);

  final String mainText;

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      blur: 20,
      opacity: 0.6,
      radius: BorderRadius.circular(12),
      border: Border.all(
        width: 0,
        color: Colors.brown.withOpacity(0.2),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          mainText,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white.withOpacity(0.8)),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff211F1C).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        width: MediaQuery.of(context).size.width * 0.25,
      ),
    );
  }
}
