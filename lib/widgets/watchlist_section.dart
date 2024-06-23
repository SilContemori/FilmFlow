import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmflow/features/user_auth/firebase_auth_services.dart';
import 'package:filmflow/models/movie.dart';
import 'package:filmflow/services/database_service.dart';
import 'package:filmflow/widgets/carosel_movies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WatchlistSection extends StatelessWidget {
  WatchlistSection({
    super.key,
  });

  final FirebaseAuthServices auth = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    User? user = auth.auth.currentUser;
    final databaseService = DatabaseService(user: user);

    return StreamBuilder(
        stream: databaseService.getMovies(),
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
          if (movies.isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Watchlist",
                style: GoogleFonts.ebGaramond(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                  child:
                      CaroselMovies(listMovies: movies, canAutoRepeat: false)),
            ],
          );
        });
  }
}
