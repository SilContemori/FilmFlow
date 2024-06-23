import 'package:filmflow/models/movie.dart';

class CombinedCredits {
  int? id;
  List<Movie>? cast;

  CombinedCredits({
    required this.id,
    required this.cast,
  });

  factory CombinedCredits.fromJason(Map<String, dynamic> jason) {
    var castFromJason = jason["cast"] as List;
    List<Movie> castList = castFromJason
        .map((knownForJson) => Movie.fromJson(knownForJson))
        .toList();
    return CombinedCredits(
      id: jason["id"],
      cast: castList,
    );
  }
}
