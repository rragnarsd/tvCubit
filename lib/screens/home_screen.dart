import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_cubit/screens/about_screen.dart';

import '../cubit/tv_cubit.dart';
import '../data/tv_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: Row(children: [CircleAvatar(), Row(children: [Text() ))],)]),),
        backgroundColor: const Color(0xff211F1C),
        body: BlocProvider(
          create: (_) => TvCubit(
              tvRepository: RepositoryProvider.of<TvRepository>(context))
            ..getTvShows(),
          child: const TvList(),
        ),
      ),
    );
  }
}

class TvList extends StatelessWidget {
  const TvList({
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
                return GridView.builder(
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      child: InkWell(
                        child: Stack(children: [
                          Image.network(
                            state.tvList![index].imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width / 2.5,
                          ),
                          Positioned(
                            bottom: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff564F4A).withOpacity(0.8),
                              ),
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    state.tvList![index].name,
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
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
}
