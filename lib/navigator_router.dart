import 'package:flutter/material.dart';
import 'package:tmdb/pages/movie_page/movie_page.dart';
import 'package:tmdb/pages/popular_movies_page/popular_movies_page.dart';

class NavigatorRouter {
  final BuildContext context;
  final RouteSettings settings;

  NavigatorRouter({this.context, this.settings});

  PageRoute<MaterialPageRoute> onGenerateRoutes() {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (BuildContext context) => PopularMoviesPage());

      case '/moviePage':
        return MaterialPageRoute(builder: (BuildContext context) {
          final arg = settings.arguments as MoviePageArgs;
          return MoviePage(
            movie: arg.movie,
          );
        });
    }

    return MaterialPageRoute(
        builder: (BuildContext context) => PopularMoviesPage());
  }
}
