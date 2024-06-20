import 'package:filmflow/models/cast.dart';
import 'package:filmflow/models/crew.dart';

class Credits {
  int? id;
  List<Cast>? cast;
  List<Crew>? crew;

  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory Credits.fromJason(Map<String, dynamic> jason) {
    var castFromJason = jason["cast"] as List;
    var crewFromJason = jason["crew"] as List;
    List<Cast> castList = castFromJason
        .map((knownForJson) => Cast.fromJason(knownForJson))
        .toList();
    List<Crew> crewList = crewFromJason
        .map((knownForJson) => Crew.fromJason(knownForJson))
        .toList();
    return Credits(
      id: jason["id"],
      cast: castList,
      crew: crewList,
    );
  }
}
