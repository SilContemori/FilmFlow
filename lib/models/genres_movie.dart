class GenresMovie {
  String? name;

  GenresMovie({required this.name});

  factory GenresMovie.fromJason(Map<String, dynamic> jason) {
    return GenresMovie(name: jason["name"]);
  }
}
