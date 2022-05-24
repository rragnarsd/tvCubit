import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/data/repositories/tv_repository.dart';
import 'package:tv_cubit/presentation/shared/widgets/btn_with_extra_border.dart';
import '../../../data/models/tv.dart';
import '../../../data/models/tv_info.dart';
import '../../../utils/constants.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key, required this.tvModel}) : super(key: key);

  final TvModel tvModel;

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? title;
  Animation<double>? genre;
  Animation<double>? rating;
  Animation<double>? description;
  Animation<double>? button;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    title = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)));
    genre = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.4)));
    rating = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.6)));
    description = Tween<double>(begin: 0, end: 1).animate(
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: kBoxDecorationWithGradient,
          child: FutureBuilder<TvInfo>(
              future: TvRepository().getMoreInfo(widget.tvModel.id.toString()),
              builder: (BuildContext context, AsyncSnapshot<TvInfo> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error loading data');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return buildAboutBody(context, snapshot);
              }),
        ),
      ),
    );
  }

  SingleChildScrollView buildAboutBody(
      BuildContext context, AsyncSnapshot<TvInfo> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              buildShaderMask(context, snapshot),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: -150 / 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    buildShowImg(snapshot),
                    const SizedBox(),
                    buildShowInfo(snapshot, context)
                  ]),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 150 / 2,
          ),
          buildShowDesc(snapshot, context),
          FadeTransition(
              opacity: button!,
              child: const BtnWithExtraBorder(btnText: 'Watch')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Padding buildShowDesc(AsyncSnapshot<TvInfo> snapshot, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FadeTransition(
        opacity: description!,
        child: Text(
          snapshot.data!.tvShow!.description!,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
        ),
      ),
    );
  }

  Container buildShowImg(AsyncSnapshot<TvInfo> snapshot) {
    return Container(
      decoration: kBoxShadow,
      height: 130,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Hero(
          tag: Text('btn'),
          child: Image.network(
            snapshot.data!.tvShow!.imageThumbnailPath!,
          ),
        ),
      ),
    );
  }

  Expanded buildShowInfo(AsyncSnapshot<TvInfo> snapshot, context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FadeTransition(
            opacity: title!,
            child: Text(
              snapshot.data!.tvShow!.name!,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          FadeTransition(
            opacity: genre!,
            child: Row(
              children: [
                for (var show in snapshot.data!.tvShow!.genres!)
                  Text(
                    '$show, ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white60),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          FadeTransition(
            opacity: rating!,
            child: Row(
              children: [
                Text(
                  snapshot.data!.tvShow!.rating!.substring(0, 3),
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                const Icon(
                  FontAwesomeIcons.solidStar,
                  size: 14,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  SizedBox buildShaderMask(
      BuildContext context, AsyncSnapshot<TvInfo> snapshot) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
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
          snapshot.data!.tvShow!.imagePath!,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
      ),
    );
  }
}
