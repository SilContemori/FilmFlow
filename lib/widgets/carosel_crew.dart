import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmflow/constants.dart';
import 'package:filmflow/pages/details_people.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaroselCrew extends StatelessWidget {
  const CaroselCrew({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: snapshot.data!.crew.length,
            options: CarouselOptions(height: 140, viewportFraction: 0.3),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              if (snapshot.data!.crew[itemIndex].profilePath != null) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPeoplePage(
                            id: snapshot.data.crew[itemIndex].id,
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
                            '${Constants.imagePath}${snapshot.data!.crew[itemIndex].profilePath}',
                          ),
                        ),
                        Positioned(
                          left: 2,
                          right: 2,
                          top: 116,
                          bottom: 0,
                          child: Container(
                            color: Colors.black,
                            child: Text(
                              "${snapshot.data!.crew[itemIndex].originalName}",
                              style: GoogleFonts.ebGaramond(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              } else {
                return Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                          'assets/images/Screenshot from 2024-04-30 21-54-17.png'),
                    ),
                    Positioned(
                      left: 2,
                      right: 2,
                      top: 116,
                      bottom: 0,
                      child: Container(
                        color: Colors.black,
                        child: Text(
                          "${snapshot.data!.crew[itemIndex].originalName}",
                          style: GoogleFonts.ebGaramond(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
