import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_cubit/cubit/tv_cubit.dart';
import 'package:tv_cubit/data/repositories/tv_repository.dart';
import 'package:tv_cubit/presentation/screens/search_screen/widgets/input_decoration.dart';
import 'package:tv_cubit/utils/constants.dart';

import 'widgets/search_result_empty.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String query;

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: kBoxDecorationWithGradient,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BlocProvider(
              create: (context) => TvCubit(
                tvRepository: RepositoryProvider.of<TvRepository>(context),
              ),
              child: BlocConsumer<TvCubit, TvState>(
                listener: (context, state) {
                  if (state.status == TvStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${state.exception}'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  switch (state.status) {
                    case TvStatus.loading:
                    case TvStatus.initial:
                    case TvStatus.success:
                      return buildSearchBody(context, state);
                    case TvStatus.failure:
                      return const Center(
                        child: Text('Error'),
                      );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildSearchBody(BuildContext context, TvState state) {
    return Column(children: [
      const SizedBox(
        height: 50,
      ),
      buildTextField(context),
      const SizedBox(
        height: 30,
      ),
      state.tvList != null &&
              state.tvList!.isNotEmpty &&
              _searchController.text.isNotEmpty
          ? buildSearchTile(context, state)
          : const SearchResultEmpty()
    ]);
  }

  Expanded buildSearchTile(BuildContext context, TvState state) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView(
          children: state.tvList!
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      e.name,
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    leading: Container(
                      decoration: kBoxShadow,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          e.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Placeholder();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Row buildTextField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 45,
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.text,
            decoration: buildInputDecoration(context),
            cursorColor: Colors.white.withOpacity(0.4),
            style: TextStyle(color: Colors.white.withOpacity(0.8)),
            onChanged: (value) {
              BlocProvider.of<TvCubit>(context).searchTvShow(value);
            },
          ),
        ),
      ],
    );
  }
}
