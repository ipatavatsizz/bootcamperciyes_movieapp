import 'dart:convert';
import 'dart:developer';

import 'package:bootcamperciyes_movieapp/product/model/local_data.dart';
import 'package:http/http.dart' as http;

class LocalService {
  static Future<Response?> getData() async {
    final response =
        await http.get(Uri.parse('http://85.159.71.66:8080/api/movies'));
    if (response.statusCode != 200) return null;

    final data = Response.fromJson(json.decode(response.body));
    inspect(data);
    return data;
  }
}
