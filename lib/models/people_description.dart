class PeopleDescription {
  String? biography;
  String? birthday;
  String? deathday;
  String? placeOfBirth;
  String? nome;
  String? knownForDepartment;
  String? profilePath;
  int id;

  PeopleDescription({
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.placeOfBirth,
    required this.nome,
    required this.knownForDepartment,
    required this.profilePath,
    required this.id,
  });

  factory PeopleDescription.fromJason(Map<String, dynamic> jason) {
    return PeopleDescription(
      biography: jason["biography"],
      birthday: jason["birthday"],
      deathday: jason["deathday"],
      placeOfBirth: jason["place_of_birth"],
      knownForDepartment: jason["known_for_department"],
      id: jason["id"],
      nome: jason["name"],
      profilePath: jason["profile_path"],
    );
  }
}
