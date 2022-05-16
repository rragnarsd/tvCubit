import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_cubit/screens/about_screen.dart';

import '../cubit/tv_cubit.dart';
import '../data/tv_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            TvCubit(tvRepository: RepositoryProvider.of<TvRepository>(context))
              ..getTvShows(),
        child: const TvList(),
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
    return BlocConsumer<TvCubit, TvState>(
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
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.tvList!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.tvList![index].name),
                  subtitle: Text(state.tvList![index].country),
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
              );
            case TvStatus.failure:
              return const Center(
                child: Text('Error'),
              );
          }
        });
      },
    );
  }
}
