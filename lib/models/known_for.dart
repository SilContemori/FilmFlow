class KnownFor{
  String? backdropPath;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? title;
  String? originalLanguage;
  double? popularityMovie;
  String? releaseDate;
  double? voteAverage;
  double? voteCount;

  KnownFor({
    required this.backdropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.title,
    required this.originalLanguage,
    required this.popularityMovie,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

    factory KnownFor.fromJason(Map<String, dynamic> jason) {
    return KnownFor(
      backdropPath: jason["backdrop_path"],
      originalTitle: jason["original_title"], // inutile
      overview: jason["overview"],
      posterPath: jason["poster_path"],
      mediaType: jason["media_type"],
      title: jason["title"],
      originalLanguage: jason["original_language"],
      popularityMovie: jason["popularity"].toDouble(),
      releaseDate: jason["release_date"],
      voteAverage: jason["vote_average"].toDouble(),
      voteCount: jason["vote_count"].toDouble(),
    );
  }
}