import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/data/tv_repository.dart';
import 'package:tv_cubit/models/tv.dart';
import 'package:tv_cubit/models/tv_info.dart';

import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key, required this.tvModel}) : super(key: key);

  final TvModel tvModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: kBoxDecorationWithGradient,
          child: FutureBuilder<TvInfo>(
              future: TvRepository().getMoreInfo(tvModel.id.toString()),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              snapshot.data!.tvShow!.description!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildShowImg(AsyncSnapshot<TvInfo> snapshot) {
    return SizedBox(
      height: 130,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          snapshot.data!.tvShow!.imageThumbnailPath!,
        ),
      ),
    );
  }

  Expanded buildShowInfo(AsyncSnapshot<TvInfo> snapshot, context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            snapshot.data!.tvShow!.name!,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          //TODO - iterate over the genres list
          Text(snapshot.data!.tvShow!.genres!.first,
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                snapshot.data!.tvShow!.rating!.substring(0, 3),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w600),
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
