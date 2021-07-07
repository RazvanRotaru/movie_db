import 'package:movie_db/actions/get_movies.dart';
import 'package:movie_db/actions/reload_movies.dart';
import 'package:movie_db/data/movie_api.dart';
import 'package:movie_db/models/app_state.dart';
import 'package:movie_db/models/movie.dart';
import 'package:redux/redux.dart';

class MoviesMiddleware {
  MoviesMiddleware({required MovieApi api}) : _api = api;
  final MovieApi _api;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, GetMoviesAction>(_getMovies),
      TypedMiddleware<AppState, ReloadMovies>(_reloadMovies),
    ];
  }

  Future<void> _getMovies(Store<AppState> store, GetMoviesAction action, NextDispatcher next) async {
    next(action);

    try {
      final int page = store.state.currentPage;
      final List<Movie> movies = await _api.getMovies(page: page);
      store.dispatch(GetMoviesSuccessful(movies));
    } catch (error) {
      store.dispatch(GetMoviesError(error));
    }
  }

  Future<void> _reloadMovies(Store<AppState> store, ReloadMovies action, NextDispatcher next) async {
    next(action);

    try {
      final int page = action.randomPage;
      print(page);
      final List<Movie> movies = await _api.getMovies(page: page);
      print(movies.length);
      store.dispatch(GetMoviesSuccessful(movies));
    } catch (error) {
      store.dispatch(GetMoviesError(error));
    }
  }
}
