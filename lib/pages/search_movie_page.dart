import 'package:filmflow/api/api.dart';
import 'package:filmflow/constants.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/pages/details_page_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  late Future<List<Movie>> searchMovies;
  final TextEditingController searchController = TextEditingController();
  // String input = "dune";
  @override
  void initState() {
    super.initState();
    String urlSearchMovie = Api().createUrlSerchMovie(searchController.text);
    debugPrint(
        "$urlSearchMovie-------------------------------------------------------------------");
    searchMovies = Api().getSerchMovie(urlSearchMovie);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SearchBar(
                          controller: searchController,
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          onSubmitted: (value) {
                            searchController.clear();
                          },
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(color: Colors.white)),
                          onChanged: (value) {
                            String urlSearchMovie = Api()
                                .createUrlSerchMovie(searchController.text);
                            setState(() {
                              searchMovies =
                                  Api().getSerchMovie(urlSearchMovie);
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          String urlSearchMovie =
                              Api().createUrlSerchMovie(searchController.text);
                          setState(() {
                            searchMovies = Api().getSerchMovie(urlSearchMovie);
                          });
                          searchController.clear();
                        },
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: searchMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      debugPrint("list : ${snapshot.data!.length}");
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPageMovie(
                                          movie: snapshot.data![index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 130,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                            child: Image.network(
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                              '${Constants.imagePath}${snapshot.data![index].backDropPath}',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            "${snapshot.data![index].title}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                    return Center(child: Text(snapshot.error.toString()));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
