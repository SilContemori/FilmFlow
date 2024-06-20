import 'package:filmflow/models/cast.dart';
import 'package:filmflow/models/crew.dart';
import 'package:filmflow/models/movie_people.dart';

class CombinedCredits {
  int? id;
  List<MoviePeople>? cast;

  CombinedCredits({
    required this.id,
    required this.cast,
  });

  factory CombinedCredits.fromJason(Map<String, dynamic> jason) {
    var castFromJason = jason["cast"] as List;
    List<MoviePeople> castList = castFromJason
        .map((knownForJson) => MoviePeople.fromJason(knownForJson))
        .toList();
    return CombinedCredits(
      id: jason["id"],
      cast: castList,
    );
  }
}
