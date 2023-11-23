import 'dart:convert';

import 'package:bootcamperciyes_movieapp/product/model/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String domain = 'https://api.themoviedb.org';
  static const String path = '/3/discover/movie';

  static Future<Response?> get({
    int page = 1,
    bool video = false,
    bool adult = false,
    SortType sort = SortType.popularityDesc,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$domain$path?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US&sort_by=${sort.parameter}&include_adult=$adult&include_video=$video&page=$page',
        ),
      );

      if (response.statusCode != 200) return null;

      final Map<String, dynamic> data = json.decode(response.body);

      final Response result = Response.fromJson(data);

      debugPrint('Api Service: loaded page $page');
      return result;
    } catch (e) {
      debugPrint('Bir hata oldu: $e');
    }
    return null;
  }
}

enum SortType {
  popularityAsc(parameter: 'popularity.asc'),
  popularityDesc(parameter: 'popularity.desc'),
  releaseDateAsc(parameter: 'release_date.asc'),
  releaseDateDesc(parameter: 'release_date.desc'),
  revenueAsc(parameter: 'revenue.asc'),
  revenueDesc(parameter: 'revenue.desc'),
  primaryReleaseDateAsc(parameter: 'primary_release_date.asc'),
  primaryReleaseDateDesc(parameter: 'primary_release_date.desc'),
  originalTitleAsc(parameter: 'original_title.asc'),
  originalTitleDesc(parameter: 'original_title.desc'),
  voteAverageAsc(parameter: 'vote_average.asc'),
  voteAverageDesc(parameter: 'vote_average.desc'),
  voteCountAsc(parameter: 'vote_count.asc'),
  voteCountDesc(parameter: 'vote_count.desc');

  final String parameter;

  const SortType({required this.parameter});
}
