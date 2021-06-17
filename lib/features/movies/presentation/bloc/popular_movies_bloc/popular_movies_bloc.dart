import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/movies/data/models/movie_model.dart';
import 'package:tmdb/features/movies/data/repositories/tmdb_repository_impl.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final TMDBRepository tmdbRepository;

  PopularMoviesBloc(this.tmdbRepository) : super(Empty());

  int page = 1;
  bool isLoading = false;

  @override
  Stream<PopularMoviesState> mapEventToState(
    PopularMoviesEvent event,
  ) async* {
    if (event is GetPopularMovies) {
      try {
        yield Loading();
        final movies = await tmdbRepository.getPopularMovies(page);
        if (movies == null) {
          yield Error("Empty movies list");
        } else {
          yield Loaded(movies);
          page++;
        }
      } on NetworkException {
        yield Error("Network exception");
      }
    }
  }
}
