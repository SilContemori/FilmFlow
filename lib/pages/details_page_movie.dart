import 'package:filmflow/api/api.dart';
import 'package:filmflow/constants.dart';
import 'package:filmflow/models/credits.dart';
import 'package:filmflow/models/genres_movie.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/models/movie_videos.dart';
import 'package:filmflow/widgets/carosel_cast.dart';
import 'package:filmflow/widgets/carosel_crew.dart';
import 'package:filmflow/widgets/error_container.dart';
import 'package:filmflow/widgets/trailer_movie.dart';
import 'package:flutter/material.dart';

class DetailsPageMovie extends StatefulWidget {
  const DetailsPageMovie({super.key, required this.movie});

  final Movie movie;

  @override
  State<DetailsPageMovie> createState() => _DetailsPageMovieState();
}

class _DetailsPageMovieState extends State<DetailsPageMovie> {
  late Future<Credits> credits;
  late Movie currentMovie;
  late DateTime movieYear;
  late Future<List<MovieVideos>> movieVideos;
  late Future<List<GenresMovie>> genresMovie;

  @override
  void initState() {
    super.initState();
    currentMovie = widget.movie;
    String urlCredits = Api().createUrlCredits(currentMovie.id);
    credits = Api().getCredits(urlCredits);
    movieYear = DateTime.parse(currentMovie.releaseDate!);
    String urlMovieVideo = Api().createUrlMovieVideos(currentMovie.id);
    movieVideos = Api().getMovieVideos(urlMovieVideo);
    String urlGenresMovie = Api().createUrlGenresMovie(currentMovie.id);
    genresMovie = Api().getGenresMovie(urlGenresMovie);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: detailsBody(),
      ),
    );
  }

  SingleChildScrollView detailsBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topImage(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Overview",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${currentMovie.overview}",
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Cast",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            castCotainer(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Crew",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            crewCotainer(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Trailer",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 400,
                width: double.infinity,
                child: FutureBuilder(
                  future: movieVideos,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Text("Non ci sono trailer disponibili");
                      } else {
                        return TrailerMovie(
                          snapshot: snapshot,
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox castCotainer() {
    return SizedBox(
      child: FutureBuilder(
        future: credits,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorContainer(snapshot: snapshot);
          } else if (snapshot.hasData) {
            return CaroselCast(snapshot: snapshot);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  SizedBox crewCotainer() {
    return SizedBox(
      child: FutureBuilder(
        future: credits,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorContainer(snapshot: snapshot);
          } else if (snapshot.hasData) {
            return CaroselCrew(snapshot: snapshot);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stack topImage() {
    return Stack(
      children: [
        Opacity(
          opacity: 0.4,
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    '${Constants.imagePath}${currentMovie.backDropPath}'),
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 30,
          bottom: 80,
          child: Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    '${Constants.imagePath}${currentMovie.posterPath}',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 160,
          bottom: 70,
          child: SizedBox(
            height: 90,
            width: 200,
            // color: Colors.yellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${currentMovie.title} ",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "(${movieYear.year.toString()})",
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      // color: Colors.yellow,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Center(
                        child: Text(
                          "${currentMovie.voteAverage!.toInt() * 10}%",
                          style: const TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: genresMovie,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, itexmIndex) {
                              if (itexmIndex != snapshot.data!.length - 1) {
                                return Text(
                                  "${snapshot.data![itexmIndex].name} - ",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 9),
                                );
                              } else {
                                return Text(
                                  "${snapshot.data![itexmIndex].name}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 9),
                                );
                              }
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                // SizedBox(
                //   height: 70,
                //   child: SingleChildScrollView(
                //     child: Text(
                //       "${currentMovie.overview}",
                //       style: const TextStyle(fontSize: 9, color: Colors.white),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
