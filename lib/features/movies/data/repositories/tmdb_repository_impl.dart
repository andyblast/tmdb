import 'package:tmdb/core/network_info.dart';
import 'package:tmdb/features/movies/data/datasources/remote_datasource.dart';
import 'package:tmdb/features/movies/data/models/movie_model.dart';

abstract class TMDBRepository {
  Future<List<MovieModel>> getPopularMovies(int page);
}

class TMDBRepositoryImpl implements TMDBRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TMDBRepositoryImpl({this.networkInfo, this.remoteDataSource});

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.getPopularMovies(page);
    } else {
      return null;
    }
  }
}

class NetworkException implements Exception {}
