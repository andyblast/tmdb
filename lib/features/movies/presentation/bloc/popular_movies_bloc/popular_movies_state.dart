part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class Empty extends PopularMoviesState {}

class Loading extends PopularMoviesState {}

class Loaded extends PopularMoviesState {
  final List<MovieModel> popularMovies;
  Loaded(this.popularMovies);

  @override
  List<Object> get props => [popularMovies];
}

class Error extends PopularMoviesState {
  final String message;
  Error(this.message);
}
