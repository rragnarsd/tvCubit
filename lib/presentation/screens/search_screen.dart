import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/cubit/tv_cubit.dart';
import 'package:tv_cubit/data/models/tv.dart';

import 'package:http/http.dart' as http;
import 'package:tv_cubit/data/repositories/tv_repository.dart';
import 'package:tv_cubit/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String query;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _searchController = TextEditingController();

  late List<dynamic> items = [];

  Future<List<TvModel>> searchTvShows(String query) async {
    final response = await http
        .get(Uri.parse('https://www.episodate.com/api/search?q=$query'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      Iterable list = result['tv_shows'];
      setState(() {
        items = list as List<dynamic>;
      });

      return list.map((e) => TvModel.fromJson(e)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Container(
            decoration: kBoxDecorationWithGradient,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocProvider(
                create: (context) => TvCubit(
                  tvRepository: RepositoryProvider.of<TvRepository>(context),
                )..searchTvShow(),
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
                    return BlocBuilder<TvCubit, TvState>(
                        builder: (context, state) {
                      switch (state.status) {
                        case TvStatus.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case TvStatus.initial:
                        case TvStatus.success:
                          return buildSearchBody(context, state);
                        case TvStatus.failure:
                          return const Center(
                            child: Text('Error'),
                          );
                      }
                    });
                  },
                ),
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
      buildSearchField(context),
      const SizedBox(
        height: 30,
      ),
      items.isNotEmpty && _searchController.text.isNotEmpty
          ? buildResults(context, state)
          : buildNoResults(context)
    ]);
  }

  Form buildSearchField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
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
                query = value;
                searchTvShows(_searchController.text);
                //BlocProvider.of<TvCubit>(context).searchTvShow();
              },
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.white.withOpacity(0.4),
          size: 20,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.4),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      hintText: 'Search',
      hintStyle: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Colors.white.withOpacity(0.2)),
    );
  }

  Expanded buildResults(BuildContext context, TvState state) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView(
          children: items
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      e['name'],
                      //    e.name ?? '',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    leading: SizedBox(
                      width: 80,
                      child: Image.network(
                        e['imageUrl'] ?? '',
                        // e.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Placeholder();
                        },
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

  Column buildNoResults(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          size: 55,
        ),
        const SizedBox(height: 20),
        Text(
          'No results to display',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }

  // Widget buildShow(TvModel show) => ListTile(
  //       leading: Image.network(
  //         show.imageUrl,
  //         fit: BoxFit.cover,
  //         width: 50,
  //         height: 50,
  //       ),
  //       title: Text(show.name),
  //     );
}
