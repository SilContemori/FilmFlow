import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmflow/api/api.dart';
import 'package:filmflow/constants.dart';
import 'package:filmflow/models/combined_credits.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/models/people_description.dart';
import 'package:filmflow/pages/details_page_movie.dart';
import 'package:flutter/material.dart';

class DetailsPeoplePage extends StatefulWidget {
  const DetailsPeoplePage({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<DetailsPeoplePage> createState() => DetailsPeoplePageState();
}

class DetailsPeoplePageState extends State<DetailsPeoplePage> {
  late int currentId;
  late Future<PeopleDescription> peopleDescription;
  late Future<CombinedCredits> combinedCredits;
  late String? deathday;
  late String? biography;

  @override
  void initState() {
    super.initState();
    currentId = widget.id;
    String urlPeopleDescriprion = Api().createUrlPeopleDescription(currentId);
    String urlKnownFor = Api().createUrlKnownFor(currentId);
    peopleDescription = Api().getPeopleDescription(urlPeopleDescriprion);
    combinedCredits = Api().getCombinedCredits(urlKnownFor);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(backgroundColor: Colors.black, body: detailsBody()));
  }

  SingleChildScrollView detailsBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: peopleDescription,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.deathday != null) {
                    deathday = snapshot.data!.deathday;
                  } else {
                    deathday = '-';
                  }
                  if (snapshot.data!.biography != null) {
                    biography = snapshot.data!.biography;
                  } else {
                    biography = '-';
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 300,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${Constants.imagePath}${snapshot.data!.profilePath}'),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${snapshot.data!.nome}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Personal Info",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Known for",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data!.knownForDepartment}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Birthday",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data!.birthday}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Deathday",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              deathday.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Place of Birth",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data!.placeOfBirth}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Biography",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              biography.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "KnownFor",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          caroselKnownFor(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  FutureBuilder caroselKnownFor() {
    return FutureBuilder(
      future: combinedCredits,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          List<Movie> list = snapshot.data.cast.where((elemento) {
            return elemento.posterPath != null && elemento.title != null;
          }).toList();
          return CarouselSlider.builder(
            itemCount: list!.length,
            options: CarouselOptions(
              height: 140,
              viewportFraction: 0.3,
              // enableInfiniteScroll: false,
            ),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              // if (itemIndex < snapshot.data.cast.length) {
              //   if (snapshot.data.cast[itemIndex].posterPath != null &&
              //       snapshot.data.cast[itemIndex].title != null) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPageMovie(
                        movie: list[itemIndex],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${Constants.imagePath}${list[itemIndex].posterPath}',
                      ),
                    ),
                    Positioned(
                      left: 2,
                      right: 2,
                      top: 116,
                      bottom: 5,
                      child: Container(
                        color: Colors.black,
                        child: Text(
                          "${list[itemIndex].title}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              //   } else {
              //     return const SizedBox();
              //   }
              // } else {
              //   return const SizedBox();
              // }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
