import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/data/models/tv.dart';

import 'package:http/http.dart' as http;

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: Color(0xff59524F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff59524F),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff59524F),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                          hintText: 'Search',
                        ),
                        onChanged: (value) {
                          query = value;
                          searchTvShows(_searchController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              items.isNotEmpty
                  ? Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView(
                          children: items
                              .map((e) => ListTile(
                                    title: Text(
                                      e['name'],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    leading: SizedBox(
                                      width: 50,
                                      child: Image.network(
                                        e['imageUrl'] ?? '',
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Placeholder();
                                        },
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    )
                  : const Text('No items')
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShow(TvModel show) => ListTile(
        leading: Image.network(
          show.imageUrl,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(show.name),
      );
}
