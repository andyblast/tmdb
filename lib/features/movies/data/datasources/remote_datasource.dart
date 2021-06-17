import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tmdb/core/constansts.dart';

import 'package:tmdb/features/movies/data/models/movie_model.dart';

abstract class RemoteDataSource {
  Future<List<MovieModel>> getPopularMovies(int page);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$API_ENDPOINT/discover/movie?api_key=$API_KEY&sort_by=popularity.desc&page=$page'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final movies = jsonResponse['results'] as List;

        List<MovieModel> result = [];

        movies.forEach((movie) {
          final newMovie = MovieModel.fromJson(movie);
          result.add(newMovie);
        });
        return result;
      } else {
        throw Error();
      }
    } on SocketException catch (_) {
      throw Exception('SocketException');
    }
  }
}
