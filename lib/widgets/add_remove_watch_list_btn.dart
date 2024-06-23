import 'dart:convert';

import 'package:filmflow/models/movie.dart';
import 'package:filmflow/provider/wathist_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddRemoveWatchListBtn extends StatefulWidget {
  AddRemoveWatchListBtn({
    super.key,
    required this.movie,
  });

  Movie movie;

  @override
  State<AddRemoveWatchListBtn> createState() => _AddRemoveWatchListBtnState();
}

class _AddRemoveWatchListBtnState extends State<AddRemoveWatchListBtn> {
  @override
  Widget build(BuildContext context) {
    debugPrint(jsonEncode(widget.movie.toJson()));
    return SizedBox(
      width: 90,
      height: 25,
      child: FutureBuilder(
          future: Movie.isInMyWatchList(widget.movie),
          builder: (context, snapshot) {
            bool b = snapshot.data ?? false;
            return ElevatedButton(
              onPressed: () async {
                if (b == true) {
                  // await Movie.removeMovieFromStorage(widget.movie);
                  await context
                      .read<WatchlistProvider>()
                      .removeMovieFromWatchlist(widget.movie);
                } else {
                  await context
                      .read<WatchlistProvider>()
                      .addMovieToWatchlist(widget.movie);
                  // await Movie.addMovieToStorage(widget.movie);
                }

                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(231, 255, 216, 59)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(1.0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                        color: Color.fromARGB(231, 255, 216, 59)),
                  ),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    b ? " - " : " + ",
                    style: GoogleFonts.ebGaramond(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    b ? "Remove" : "Watch List",
                    style: GoogleFonts.ebGaramond(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
