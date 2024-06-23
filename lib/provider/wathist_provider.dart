import 'package:filmflow/models/movie.dart';
import 'package:flutter/foundation.dart';

class WatchlistProvider extends ChangeNotifier {
  List<Movie> watchlist = [];

  Future<void> setWatchlistFromStorage() async {
    watchlist = await Movie.getListMovieFromStorage();
    notifyListeners();
  }

  Future<void> addMovieToWatchlist(Movie movie) async {
    watchlist.add(movie);
    await Movie.writeListMovieToStorage(watchlist);
    notifyListeners();
  }

  Future<void> removeMovieFromWatchlist(Movie movie) async {
    List<Movie> newList = [];
    for (Movie movieElem in watchlist) {
      debugPrint("elem id : ${movieElem.id}");
      if (movieElem.id != movie.id) {
        newList.add(movieElem);
      }
    }
    watchlist = newList;
    await Movie.writeListMovieToStorage(watchlist);
    notifyListeners();
  }
}
