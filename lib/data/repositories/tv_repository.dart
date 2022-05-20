import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/tv.dart';
import '../models/tv_info.dart';

class TvRepository {
  Future<List<TvModel>> getTvShows() async {
    final response = await http
        .get(Uri.parse('https://www.episodate.com/api/most-popular?page=1'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['tv_shows'];
      return list.map((e) => TvModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<TvModel>> getPopularTvShows() async {
    final response = await http
        .get(Uri.parse('https://www.episodate.com/api/most-popular?page=2'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['tv_shows'];
      return list.map((e) => TvModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  Future<TvInfo> getMoreInfo(String query) async {
    final response = await http
        .get(Uri.parse('https://www.episodate.com/api/show-details?q=$query'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      return TvInfo.fromJson(result);
    } else {
      throw Exception('Failed');
    }
  }

  late List<dynamic> items = [];

  Future<List<TvModel>> searchTvShows(String query) async {
    final response = await http
        .get(Uri.parse('https://www.episodate.com/api/search?q=$query'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      Iterable list = result['tv_shows'];
      // items.addAll(list);
      // setState(() {
      //   items = list as List<dynamic>;
      // });
      return list.map((e) => TvModel.fromJson(e)).toList();
    } else {
      throw Exception();
    }
  }
}
