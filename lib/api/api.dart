import 'dart:convert';
import 'package:filmflow/constants.dart';
import 'package:filmflow/models/combined_credits.dart';
import 'package:filmflow/models/credits.dart';
import 'package:filmflow/models/genres_movie.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/models/movie_videos.dart';
import 'package:filmflow/models/people.dart';
import 'package:filmflow/models/people_description.dart';
import 'package:filmflow/models/trending.dart';
import 'package:filmflow/models/tv_shows.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const trendingUrl =
      '$baseUrl/trending/all/day?api_key=${Constants.apiKey}';
  static const topRatedMovieUrl =
      '$baseUrl/movie/top_rated?api_key=${Constants.apiKey}';
  static const upcomingMovie =
      '$baseUrl/movie/upcoming?api_key=${Constants.apiKey}';
  static const topRatedTvShows =
      '$baseUrl/tv/top_rated?api_key=${Constants.apiKey}';
  static const popularPeople =
      '$baseUrl/person/popular?api_key=${Constants.apiKey}';

  String createUrlCredits(int movieId) {
    return "$baseUrl/movie/$movieId/credits?api_key=${Constants.apiKey}";
  }

  String createUrlMovieVideos(int movieId) {
    return "$baseUrl/movie/$movieId/videos?api_key=${Constants.apiKey}";
  }

  String createUrlGenresMovie(int movieId) {
    return "$baseUrl/movie/$movieId?api_key=${Constants.apiKey}";
  }

  String createUrlPeopleDescription(int peopleId) {
    return "$baseUrl/person/$peopleId?api_key=${Constants.apiKey}";
  }

  String createUrlKnownFor(int peopleId) {
    return "$baseUrl/person/$peopleId?api_key=${Constants.apiKey}&&language=en-US&append_to_response=combined_credits";
  }

  Future<List<Trending>> getTrending() async {
    final response = await http.get(Uri.parse(trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      List<Trending> listWithNull = decodedData.map((trending) {
        return Trending.fromJason(trending);
      }).toList();
      return listWithNull.where((element) {
        if (element.title == null ||
            element.overview == null ||
            element.mediaType == null ||
            element.originalLanguage == null ||
            element.popularity == null ||
            element.releaseDate == null ||
            element.voteAverage == null ||
            element.voteCount == null ||
            element.backDropPath == null ||
            element.posterPath == null) {
          return false;
        } else {
          return true;
        }
      }).toList();
    } else {
      throw Exception('Something happend');
    }
  }

  Future<List<Movie>> getTopRated() async {
    final response = await http.get(Uri.parse(topRatedMovieUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) {
        return Movie.fromJason(movie);
      }).toList();
    } else {
      throw Exception('Something happend');
    }
  }

  Future<List<Movie>> getUpcomingMovie() async {
    final response = await http.get(Uri.parse(upcomingMovie));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) {
        return Movie.fromJason(movie);
      }).toList();
    } else {
      throw Exception('Something happend');
    }
  }

  Future<List<TvShows>> getTopRatedTvShows() async {
    final response = await http.get(Uri.parse(topRatedTvShows));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvShows) {
        return TvShows.fromJason(tvShows);
      }).toList();
    } else {
      throw Exception('Something happend');
    }
  }

  Future<List<People>> getPopularPeople() async {
    final response = await http.get(Uri.parse(popularPeople));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      try {
        List<People> result = decodedData.map((people) {
          return People.fromJason(people);
        }).toList();
        debugPrint("${result.length}");
        return result.where((element) {
          if (element.profilePath == null ||
              element.knownForDepartment == null ||
              element.name == null ||
              element.popularity == null ||
              element.knownFor == null) {
            return false;
          } else {
            return true;
          }
        }).toList();
      } catch (e) {
        debugPrint("error: $e");
        List<People> result = [];
        return result;
      }
    } else {
      throw Exception('Something happend');
    }
  }

  Future<CombinedCredits> getCombinedCredits(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['combined_credits'];
      CombinedCredits creditsWithNull = CombinedCredits.fromJason(decodedData);
      creditsWithNull.cast = creditsWithNull.cast!.where((element) {
        if (element.title == null || element.posterPath == null) {
          return false;
        } else {
          return true;
        }
      }).toList();
      return creditsWithNull;
    } else {
      return Future.error(
          'Stay tuned....                                                                           The data will be updated soon');
    }
  }

  Future<Credits> getCredits(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      Credits creditsWithNull = Credits.fromJason(decodedData);
      creditsWithNull.cast = creditsWithNull.cast!.where((element) {
        if (element.knownForDepartment == null ||
            element.name == null ||
            element.originalName == null ||
            element.popularity == null ||
            element.character == null ||
            element.creditId == null) {
          return false;
        } else {
          return true;
        }
      }).toList();
      creditsWithNull.crew = creditsWithNull.crew!.where((element) {
        if (element.knownForDepartment == null ||
            element.name == null ||
            element.originalName == null ||
            element.popularity == null ||
            element.department == null ||
            element.job == null) {
          return false;
        } else {
          return true;
        }
      }).toList();
      return creditsWithNull;
    } else {
      return Future.error(
          'Stay tuned....                                                                           The data will be updated soon');
    }
  }

  Future<List<GenresMovie>> getGenresMovie(String url) async {
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      final decodedData = json.decode(responce.body)['genres'] as List;
      List<GenresMovie> genresMovieList = decodedData.map((genresMovie) {
        return GenresMovie.fromJason(genresMovie);
      }).toList();
      return genresMovieList.where((element) {
        if (element.name == null) {
          return false;
        } else {
          return true;
        }
      }).toList();
    } else {
      throw Exception('Something happend');
    }
  }

  Future<List<MovieVideos>> getMovieVideos(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      // debugPrint("---------------------------------------------$decodedData");
      List<MovieVideos> movieVideosList = decodedData.map((movieVideos) {
        return MovieVideos.fromJason(movieVideos);
      }).toList();
      return movieVideosList.where((element) {
        if (element.type != "Trailer") {
          return false;
        } else {
          return true;
        }
      }).toList();
    } else {
      throw Exception('Something happend');
    }
  }

  Future<PeopleDescription> getPeopleDescription(String url) async {
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      final decodedData = json.decode(responce.body);
      debugPrint(
          "-------------------------------------------------------------$decodedData");
      PeopleDescription peopleDescription =
          PeopleDescription.fromJason(decodedData);
      return peopleDescription;
    } else {
      throw Exception('Something happend');
    }
  }
}
