import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmflow/constants.dart';
import 'package:filmflow/pages/details_people.dart';
import 'package:flutter/material.dart';

class CaroselPeople extends StatelessWidget {
  const CaroselPeople({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: snapshot.data!.length,
      options: CarouselOptions(height: 140, viewportFraction: 0.3),
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPeoplePage(
                  id: snapshot.data[itemIndex].id,
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
              '${Constants.imagePath}${snapshot.data[itemIndex].profilePath}',
            ),
          ),
        );
      },
    );
  }
}
