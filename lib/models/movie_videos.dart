class MovieVideos {
  String? key;
  String? type;

  MovieVideos({
    required this.key,
    required this.type,
  });

  factory MovieVideos.fromJason(Map<String, dynamic> jason) {
    return MovieVideos(
      key: jason["key"],
      type: jason["type"],
    );
  }
}
