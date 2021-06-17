import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/network_info.dart';
import 'package:tmdb/features/movies/data/datasources/remote_datasource.dart';
import 'package:tmdb/features/movies/data/repositories/tmdb_repository_impl.dart';
import 'package:tmdb/features/movies/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:tmdb/navigator_router.dart';
import 'package:tmdb/pages/popular_movies_page/popular_movies_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      onGenerateRoute: (RouteSettings settings) =>
          NavigatorRouter(settings: settings).onGenerateRoutes(),
      home: BlocProvider(
        create: (context) => PopularMoviesBloc(TMDBRepositoryImpl(
            networkInfo: NetworkInfoImpl(),
            remoteDataSource: RemoteDataSourceImpl()))
          ..add(GetPopularMovies()),
        child: PopularMoviesPage(),
      ),
    );
  }
}
