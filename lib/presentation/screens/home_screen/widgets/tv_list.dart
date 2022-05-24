import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_cubit/presentation/screens/home_screen/home_screen.dart';

import '../../../../cubit/tv_cubit.dart';
import '../../../../utils/constants.dart';

class TvList extends StatelessWidget {
  const TvList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocConsumer<TvCubit, TvState>(listener: (context, state) {
          if (state.status == TvStatus.success) {}
          if (state.status == TvStatus.loading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == TvStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.exception}'),
              ),
            );
          }
        }, builder: (context, state) {
          switch (state.status) {
            case TvStatus.loading:
              return Container(
                decoration: kBoxDecorationWithGradient,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case TvStatus.initial:
            case TvStatus.success:
              return buildTvGrid(context, state);
            case TvStatus.failure:
              return const Center(
                child: Text('Error'),
              );
          }
        }));
  }
}
