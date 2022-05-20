import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/tv_cubit.dart';
import '../widgets/glassmorphism.dart';
import 'about_screen.dart';

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
              SnackBar(content: Text('${state.exception}')),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<TvCubit, TvState>(builder: (context, state) {
            switch (state.status) {
              case TvStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case TvStatus.initial:
              case TvStatus.success:
                return Column(children: [
                  buildListView(context),
                  buildGridView(state),
                ]);
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

  SizedBox buildListView(BuildContext context) {
    return SizedBox(
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
          style:
              TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14.0),
        ),
      ),
    );
  }

  GridView buildGridView(TvState state) {
    return GridView.builder(
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
      itemBuilder: (context, index) => Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: InkWell(
            child: Stack(children: [
              Image.network(
                state.tvList![index].imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2.5,
              ),
              Positioned(
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
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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

  final List<String> items = [
    'TV Shows',
    'Drama',
    'Anime',
    'Action',
    'My List',
  ];
}
