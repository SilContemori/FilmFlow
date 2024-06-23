import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmflow/features/user_auth/firebase_auth_services.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final FirebaseAuthServices auth = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    User? user = auth.auth.currentUser;

    final _databaseService = DatabaseService(user: user);
    return SizedBox(
      width: 90,
      height: 25,
      child: FutureBuilder(
          future: _databaseService.getData(),
          builder: (context, snapshot) {
            List<Movie>? movies =
                snapshot.data?.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Movie.fromJson(data);
            }).toList();

            if (movies == null) {
              return const SizedBox();
            }

            bool isInWatchList = false;
            for (var elem in movies) {
              if (elem.id == widget.movie.id) {
                isInWatchList = true;
              }
            }
            return ElevatedButton(
              onPressed: () async {
                if (isInWatchList == true) {
                  _databaseService.deleteMovie(widget.movie.id.toString());
                } else {
                  _databaseService.addMovie(widget.movie);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isInWatchList ? " - " : " + ",
                    style: GoogleFonts.ebGaramond(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    isInWatchList ? "Remove" : "Watch List",
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
