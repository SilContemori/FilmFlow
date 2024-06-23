import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmflow/constants.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/pages/details_page_movie.dart';
import 'package:flutter/material.dart';

class CaroselMovies extends StatelessWidget {
  const CaroselMovies({
    super.key,
    required this.listMovies,
    this.canAutoRepeat,
  });

  final bool? canAutoRepeat;
  final List<Movie> listMovies;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: listMovies.length,
      options: CarouselOptions(
          height: 140,
          viewportFraction: 0.3,
          enableInfiniteScroll: canAutoRepeat ?? true,
          initialPage: 0),
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPageMovie(
                  movie: listMovies[itemIndex],
                ),
              ),
            );
          },
          child: SizedBox(
            height: 50,
            width: 100,
            child: Image.network(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              '${Constants.imagePath}${listMovies[itemIndex].posterPath}',
            ),
          ),
        );
      },
    );
  }
}
