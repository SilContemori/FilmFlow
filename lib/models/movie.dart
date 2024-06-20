import 'dart:core';

class Movie {
  String? title;
  String? backDropPath;
  //String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  double? popularity;
  String? releaseDate;
  double? voteAverage;
  double? voteCount;
  int id;

  Movie({
    required this.title,
    required this.backDropPath,
    // required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.id,
  });

  factory Movie.fromJason(Map<String, dynamic> jason) {
    return Movie(
        title: jason["title"],
        id: jason["id"],
        backDropPath: jason["backdrop_path"],
        // originalTitle: jason["original_title"], /// inutile
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
