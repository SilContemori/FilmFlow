import 'dart:convert';
import 'dart:core';

import 'package:filmflow/utils/sercure_storage.dart';
import 'package:flutter/widgets.dart';

class Movie {
  static const String listMoviesKey = "listMovies";
  String? title;
  String? backDropPath;
  String? overview;
  String? posterPath;
  double? popularity;
  String? releaseDate;
  double? voteAverage;
  int id;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.posterPath,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "backdrop_path": backDropPath,
      "overview": overview,
      "poster_path": posterPath,
      "popularity": popularity,
      "release_date": releaseDate,
      "vote_average": voteAverage,
      "id": id
    };
  }

  factory Movie.fromJson(Map<String, dynamic> jason) {
    return Movie(
        title: jason["title"],
        id: jason["id"],
        backDropPath: jason["backdrop_path"],
        overview: jason["overview"],
        posterPath: jason["poster_path"],
        popularity: jason["popularity"]?.toDouble(),
        releaseDate: jason["release_date"],
        voteAverage: jason["vote_average"]?.toDouble());
  }

  static Future<List<Movie>> getListMovieFromStorage() async {
    String? jsonString = await SecureStorage().readSecureData(listMoviesKey);
    if (jsonString == null) {
      return [];
    }
    List<dynamic> listJson = jsonDecode(jsonString);
    return listJson.map((e) => Movie.fromJson(e)).toList().where((element) {
      if (element.title == null ||
          element.overview == null ||
          element.popularity == null ||
          element.releaseDate == null ||
          element.voteAverage == null ||
          element.backDropPath == null ||
          element.posterPath == null) {
        return false;
      } else {
        return true;
      }
    }).toList();
    ;
  }

  static Future<void> writeListMovieToStorage(List<Movie> movies) async {
    List<dynamic> moviesJason = movies.map((e) => e.toJson()).toList();
    String s = jsonEncode(moviesJason);
    await SecureStorage().writeSecureData(listMoviesKey, s);
  }

  static Future<void> addMovieToStorage(Movie movie) async {
    List<Movie> list = await Movie.getListMovieFromStorage();
    list.add(movie);
    await Movie.writeListMovieToStorage(list);
  }

  static Future<void> removeMovieFromStorage(Movie movie) async {
    List<Movie> list = await Movie.getListMovieFromStorage();
    List<Movie> newList = [];
    for (Movie movieElem in list) {
      if (movieElem.id != movie.id) {
        newList.add(movieElem);
      }
    }

    await Movie.writeListMovieToStorage(newList);
  }

  static Future<bool> isInMyWatchList(Movie movie) async {
    List<Movie> list = await Movie.getListMovieFromStorage();
    return list.any((element) => element.id == movie.id);
  }
}
