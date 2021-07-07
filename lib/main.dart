import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_db/actions/get_movies.dart';
import 'package:movie_db/data/movie_api.dart';
import 'package:movie_db/middleware/movies_middleware.dart';
import 'package:movie_db/models/app_state.dart';
import 'package:movie_db/presentation/details_page.dart';
import 'package:movie_db/presentation/home_page.dart';
import 'package:movie_db/reducer/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  final MovieApi moviesApi = MovieApi();
  final MoviesMiddleware moviesMiddleware = MoviesMiddleware(api: moviesApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: moviesMiddleware.middleware,
  );

  store.dispatch(GetMoviesAction());
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          '/movie_details': (BuildContext context) {
            return const MovieDetailsPage();
          },
        },
      ),
    );
  }
}
