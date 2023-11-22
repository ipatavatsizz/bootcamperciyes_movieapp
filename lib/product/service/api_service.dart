import 'dart:convert';

import 'package:bootcamperciyes_movieapp/product/model/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Hocamızın istediği siteden veriyi almak için bir servis(sınıf) oluşturuyoruz
/// static belirteçini kullanarak sınıfı oluşturmadan direkt içindeki veriyi kullanabiliyoruz.
/// Globale hitap ediyoruz yani - ApiService().domain değil de ApiService.domain gibi
/// Bunun sebebi her yerden tek bir ApiService sınıfına erişmek.
class ApiService {
  // Kolaylık olsun diye domain - alan ad
  static const String domain = 'https://api.themoviedb.org';
  // Kolaylık olsun diye path - yol
  static const String path = '/3/discover/movie';
  // kısımlarını ayırdık.

  // get methodu ile sitedeki veriyi alıp işledikten sonra döndürüyoruz.
  /// page, video, adult, sort değerlerini alıyor bu sayede 2.sayfa için
  /// page: 2 yazmamız daha kolay oluyor
  static Future<Response?> get({
    int page = 1,
    bool video = false,
    bool adult = false,
    SortType sort = SortType.popularityDesc,
  }) async {
    // try catch bloğu ile hataları önceden fark ediyoruz
    try {
      Future.delayed(Duration(milliseconds: 1500));
      // http.get methodu ile sitedeki veriyi almak için istek yolluyoruz giden
      // istek bize bir cevap - response döndürüyor bizde bunu aşağıda kontrol ediyoruz.
      final response = await http.get(
        Uri.parse(
          '$domain$path?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US&sort_by=${sort.parameter}&include_adult=$adult&include_video=$video&page=$page',
        ),
      );

      // Eğer cevaptan gelen durum kodu 200 değilse bir hata oldu demektir
      // if bloğu ile bunu kontrol ediyoruz, 200 değilse hata vardır, o zaman veriyi boş yolla, listemiz boş gitsin gibi.
      // debugPrint(response.request?.url.toString());
      if (response.statusCode != 200) return null;

      // verimizi alırken json formatına dönüştürmemiz gerekiyor, çünkü bize gelen bunun tam hali
      final Map<String, dynamic> data = json.decode(response.body);

      final Response result = Response.fromJson(data);

      return result;
    } catch (e) {
      debugPrint('Bir hata oldu: $e');
    }
    return null;
  }
}

// Bu kısmı henüz anlamamıza gerek yok, enhanced enumeration diye geçiyor.
// enum nedir dedikten sonra enhanced enum diye araştırabilirsiniz.
// https://dart.dev/language/enums
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
