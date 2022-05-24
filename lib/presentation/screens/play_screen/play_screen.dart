import 'package:flutter/material.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_about_row.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_episode_text.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_image.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_info.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_play_btn.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_progress_indicator.dart';
import 'package:tv_cubit/presentation/screens/play_screen/widgets/show_title.dart';

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const ShowImage(),
              ShowInfo(season: season),
              ShowTitle(name: name),
              ShowAboutRow(info: info),
              ShowEpisodeText(episode: episode),
              ShowProgressIndicator(progress: progress),
              PlayShowBtn(button: button),
            ],
          ),
        ),
      ),
    );
  }
}
