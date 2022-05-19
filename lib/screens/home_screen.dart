import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_cubit/screens/about_screen.dart';

import '../cubit/tv_cubit.dart';
import '../data/tv_repository.dart';
import '../utils/constants.dart';
import '../widgets/appbar.dart';
import '../widgets/glassmorphism.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: kBoxDecorationWithGradient,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Appbar(),
                const SizedBox(
                  height: 15.0,
                ),
                BlocProvider(
                  create: (_) => TvCubit(
                    tvRepository: RepositoryProvider.of<TvRepository>(context),
                  )..getTvShows(),
                  child: TvList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TvList extends StatelessWidget {
  TvList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocConsumer<TvCubit, TvState>(
        listener: (context, state) {
          if (state.status == TvStatus.success) {
          } else if (state.status == TvStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.exception}'),
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<TvCubit, TvState>(builder: (context, state) {
            switch (state.status) {
              case TvStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TvStatus.initial:
              case TvStatus.success:
                return buildTvGrid(context, state);
              case TvStatus.failure:
                return const Center(
                  child: Text('Error'),
                );
            }
          });
        },
      ),
    );
  }

  Column buildTvGrid(BuildContext context, TvState state) {
    return Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width * 0.90,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 60.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) => Text(
            items[index],
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
          ),
        ),
      ),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        shrinkWrap: true,
        itemCount: state.tvList!.length,
        itemBuilder: (context, index) => buildTvGridItem(state, index, context),
      ),
    ]);
  }

  Container buildTvGridItem(TvState state, int index, BuildContext context) {
    return Container(
      decoration: kBoxShadow,
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: InkWell(
            child: Stack(children: [
              Hero(
                tag: Text('btn'),
                child: Image.network(
                  state.tvList![index].imageUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
              ),
              buildTvGridText(context, state, index),
            ]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutScreen(
                    tvModel: state.tvList![index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Positioned buildTvGridText(BuildContext context, TvState state, int index) {
    return Positioned(
      bottom: 0.0,
      child: GlassMorphism(
        blur: 20,
        opacity: 0.5,
        radius: BorderRadius.zero,
        border: Border.all(
          width: 0,
          color: Colors.brown.withOpacity(0.2),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                state.tvList![index].name,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final List<String> items = [
    'TV Shows',
    'Drama',
    'Anime',
    'Action',
    'My List',
  ];
}
