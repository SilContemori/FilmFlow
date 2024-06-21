import 'dart:math';
import 'package:filmflow/api/api.dart';
import 'package:filmflow/constants.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/models/people.dart';
import 'package:filmflow/pages/details_page_movie.dart';
import 'package:filmflow/pages/search_movie_page.dart';
import 'package:filmflow/widgets/carosel_movies.dart';
import 'package:filmflow/widgets/carosel_people.dart';
import 'package:filmflow/widgets/carosel_trending.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> trending;
  late Future<List<Movie>> topRatedMovie;
  late Future<List<Movie>> upcomingMovie;
  late Future<List<Movie>> topRatedTvShows;
  late Future<List<People>> popularPeople;
  @override
  void initState() {
    super.initState();
    trending = Api().getTrending();
    topRatedMovie = Api().getTopRated();
    upcomingMovie = Api().getUpcomingMovie();
    // topRatedTvShows = Api().getTopRatedTvShows();
    popularPeople = Api().getPopularPeople();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: appBar(),
        body: body(),
      ),
    );
  }

  SingleChildScrollView body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: FutureBuilder(
                  future: trending,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      final random = Random(3);
                      int randomIndex = random.nextInt(snapshot.data!.length);
                      return topImage(snapshot, randomIndex);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Trending",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              child: FutureBuilder(
                future: trending,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return CaroselTrending(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Top Rated Movies",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              child: FutureBuilder(
                future: topRatedMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return CaroselMovies(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Upcoming Movies",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              child: FutureBuilder(
                future: upcomingMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return CaroselMovies(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            // const SizedBox(height: 10),
            // const Text(
            //   "Top Rated TV Shows",
            //   style: TextStyle(
            //       fontSize: 17,
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold),
            // ),
            // SizedBox(
            //   child: FutureBuilder(
            //     future: topRatedTvShows,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Center(
            //           child: Text(snapshot.error.toString()),
            //         );
            //       } else if (snapshot.hasData) {
            //         return CaroselTvShows(snapshot: snapshot);
            //       } else {
            //         return const Center(child: CircularProgressIndicator());
            //       }
            //     },
            //   ),
            // ),
            const SizedBox(height: 10),
            const Text(
              "Popular People",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              child: FutureBuilder(
                future: popularPeople,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Text("no data");
                    }
                    return CaroselPeople(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack topImage(AsyncSnapshot<List<Movie>> snapshot, int randomIndex) {
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
                    '${Constants.imagePath}${snapshot.data![randomIndex].backDropPath}'),
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 30,
          bottom: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPageMovie(
                    movie: snapshot.data![randomIndex],
                  ),
                ),
              );
            },
            child: Container(
              height: 90,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      '${Constants.imagePath}${snapshot.data![randomIndex].posterPath}',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 160,
          bottom: 80,
          child: SizedBox(
            height: 90,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${snapshot.data![randomIndex].title} ",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "(${DateTime.parse(snapshot.data![randomIndex].releaseDate!).year.toString()})",
                      style: const TextStyle(fontSize: 7, color: Colors.white),
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
                          "${snapshot.data![randomIndex].voteAverage!.toInt() * 10}%",
                          style: const TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: FutureBuilder(
                    future: Api().getGenresMovie(Api()
                        .createUrlGenresMovie(snapshot.data![randomIndex].id)),
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
              ],
            ),
          ),
        )
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        "Film Flow",
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchMoviePage()),
              );
            }),
      ],
    );
  }
}
