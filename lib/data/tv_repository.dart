import 'dart:convert';

import 'package:tv_cubit/models/tv.dart';
import 'package:http/http.dart' as http;

class TvRepository {
  TvRepository();

  Future<List<TvModel>> getMovies() async {
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
}
