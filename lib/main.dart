import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_cubit/cubit/tv_cubit.dart';
import 'package:tv_cubit/data/tv_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TvRepository(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('TvShows successfully refreshed')),
          );
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
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.tvList!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.tvList![index].name),
                  subtitle: Text(state.tvList![index].country),
                ),
              );
            case TvStatus.success:
            case TvStatus.failure:
              return const Center(child: Text('Error'));
          }
        });
      },
    );
  }
}
