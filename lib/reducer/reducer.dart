import 'package:movie_db/actions/get_movies.dart';
import 'package:movie_db/actions/reload_movies.dart';
import 'package:movie_db/actions/select_movie.dart';
import 'package:movie_db/models/app_state.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  (AppState state, dynamic action) {
    print(action);
    return state;
  },
  TypedReducer<AppState, GetMoviesAction>(_getMovies),
  TypedReducer<AppState, ReloadMovies>(_clearMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, SelectMovie>(_selectMovie),
]);

AppState _getMovies(AppState state, GetMoviesAction action) {
  return state.rebuild((AppStateBuilder builder) {
    builder.isLoading = true;
  });
}

AppState _clearMovies(AppState state, ReloadMovies action) {
  return state.rebuild((AppStateBuilder builder) {
    builder
      ..movies.clear()
      ..isLoading = true;
  });
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder builder) {
    builder
      ..movies.addAll(action.movies)
      ..isLoading = false
      ..currentPage = state.currentPage + 1;
  });
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder builder) {
    builder
      ..isLoading = false
      ..errMessage = '${action.err}';
  });
}

AppState _selectMovie(AppState state, SelectMovie action) {
  return state.rebuild((AppStateBuilder builder) {
    builder.selectedMovieId = action.movieId;
  });
}
