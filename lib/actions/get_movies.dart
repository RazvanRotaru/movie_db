import 'package:movie_db/models/movie.dart';

class GetMoviesAction {}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.movies);

  final List<Movie> movies;

  @override
  String toString() {
    return 'GetMoviesSuccessful{movies: ${movies.map((Movie elm) => elm.title)}}';
  }
}

class GetMoviesError {
  GetMoviesError(this.err);

  final Object err;

  @override
  String toString() {
    return 'GetMoviesError{err: $err}';
  }
}
