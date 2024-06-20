class Crew {
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? department;
  String? job;
  int id;

  Crew({
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.department,
    required this.job,
    required this.id,
  });

  factory Crew.fromJason(Map<String, dynamic> jason) {
    return Crew(
        knownForDepartment: jason["known_for_department"],
        name: jason["name"],
        originalName: jason["original_name"],
        popularity: jason["popularity"].toDouble(),
        profilePath: jason["profile_path"],
        department: jason["department"],
        job: jason["job"],
        id: jason["id"]);
  }
}
