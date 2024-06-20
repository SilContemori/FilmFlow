class TvShows {
  String? backDropPath;
  int id;
  String? name;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  double? voteAverage;
  double? voteCount;

  TvShows({
    required this.backDropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShows.fromJason(Map<String, dynamic> jason) {
    return TvShows(
        id: jason["id"],
        name: jason["name"],
        firstAirDate: jason["first_air_date"],
        backDropPath: jason["backdrop_path"],
        overview: jason["overview"],
        posterPath: jason["poster_path"],
        popularity: jason["popularity"].toDouble(),
        voteAverage: jason["vote_average"].toDouble(),
        voteCount: jason["vote_count"].toDouble());
  }
}
