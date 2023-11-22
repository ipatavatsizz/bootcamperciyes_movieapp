import 'results.dart';

class Response {
  num page;
  List<Results> results;
  num totalPages;
  num totalResults;

  Response({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results,
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      page: json['page'] as num,
      results: (json['results'] as List<dynamic>)
          .map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as num,
      totalResults: json['total_results'] as num,
    );
  }
}
