class MoviePeople {
  String? posterPath;
  String? title;
  int id;

  MoviePeople({
    required this.id,
    required this.posterPath,
    required this.title,
  });

  factory MoviePeople.fromJason(Map<String, dynamic> jason) {
    return MoviePeople(
      id: jason["id"],
      posterPath: jason["poster_path"],
      title: jason["title"],
    );
  }
}
