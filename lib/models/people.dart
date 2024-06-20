import 'package:filmflow/models/known_for.dart';

class People {
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int id;
  List<KnownFor>? knownFor;

  People({
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.knownFor,
    required this.id
  });

  factory People.fromJason(Map<String, dynamic> jason) {
    var knownForFromJason = jason["known_for"] as List;
    List<KnownFor> knownForList = knownForFromJason
        .map((knownForJson) => KnownFor.fromJason(knownForJson))
        .toList();
    return People(
      knownForDepartment: jason["known_for_department"],
      id:jason["id"],
      name: jason["name"],
      originalName: jason["original_name"],
      popularity: jason["popularity"].toDouble(),
      profilePath: jason["profile_path"],
      knownFor: knownForList,
    );
  }
}
