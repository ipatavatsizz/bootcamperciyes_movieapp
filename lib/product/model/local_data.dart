class Response {
  List<Filmler> filmler;

  Response({
    required this.filmler,
  });

  Map<String, dynamic> toJson() {
    return {
      'filmler': filmler,
    };
  }

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      filmler: (json['filmler'] as List<dynamic>)
          .map((e) => Filmler.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Filmler {
  int id;
  String title;
  String description;
  String categoryname;
  String imagepath;

  Filmler({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryname,
    required this.imagepath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryname': categoryname,
      'imagepath': imagepath,
    };
  }

  factory Filmler.fromJson(Map<String, dynamic> json) {
    return Filmler(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      categoryname: json['categoryname'] as String,
      imagepath: json['imagepath'] as String,
    );
  }
}
