import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmflow/models/movie.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String MOVIES_COLLECTION_REF = "movies";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _moviesRef;

  DatabaseService({User? user}) {
    _moviesRef = _firestore.collection(user?.email ?? "undefined");
  }

  Future<QuerySnapshot> getData() async {
    final QuerySnapshot snapshot = await _moviesRef.get();
    return snapshot;
  }

  Stream<QuerySnapshot> getMovies() {
    return _moviesRef.snapshots();
  }

  void addMovie(Movie movie) async {
    _moviesRef.doc(movie.id.toString()).set(movie.toJson());
  }

  void upadateMovie(String movieId, Movie movie) {
    _moviesRef.doc(movieId).update(movie.toJson());
  }

  void deleteMovie(String movieId) {
    _moviesRef.doc(movieId).delete();
  }
}
