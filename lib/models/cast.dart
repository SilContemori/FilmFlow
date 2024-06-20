class Cast {
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? character;
  String? creditId;
  // String? posterPath;
  // String? title;
  int id;

  Cast({
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.id,
    // required this.posterPath,
    // required this.title,
  });

  factory Cast.fromJason(Map<String, dynamic> jason) {
    return Cast(
      knownForDepartment: jason["known_for_department"],
      name: jason["name"],
      id: jason["id"],
      originalName: jason["original_name"],
      popularity: jason["popularity"].toDouble(),
      profilePath: jason["profile_path"],
      character: jason["character"],
      creditId: jason["credit_id"],
      // posterPath: jason["poster_path"],
      // title: jason["title"],
    );
  }
}
