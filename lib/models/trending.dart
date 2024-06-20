class Trending {
  int id;
  String? title;
  String? overview;
  String? mediaType;
  String? originalLanguage;
  double? popularity;
  String? releaseDate;
  double? voteAverage;
  double? voteCount;
  String? backDropPath;
  String? posterPath;

  


  Trending({
    required this.id,
    required this.title,
    required this.overview,
    required this.mediaType,
    required this.originalLanguage,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.backDropPath,
    required this.posterPath,
  });

  factory Trending.fromJason(Map<String, dynamic> jason) {
    return Trending(
        title: jason["title"],
        id: jason["id"],
        backDropPath: jason["backdrop_path"],
        overview: jason["overview"],
        posterPath: jason["poster_path"],
        mediaType: jason["media_type"],
        originalLanguage: jason["original_language"],
        popularity: jason["popularity"].toDouble(),
        releaseDate: jason["release_date"],
        voteAverage: jason["vote_average"].toDouble(),
        voteCount: jason["vote_count"].toDouble());
  }
}
