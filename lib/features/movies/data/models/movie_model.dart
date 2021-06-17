import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String tagline;
  final String releaseDate;
  final String overview;
  final String posterPath;
  final String voteAverage;
  final String voteCount;

  String get year => getReleaseYear(releaseDate);

  MovieModel(
      {this.id,
      this.title,
      this.tagline,
      this.releaseDate,
      this.overview,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  @override
  List<Object> get props => [id];

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      tagline: json['tagline'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toString(),
      voteCount: json['vote_count'].toString(),
    );
  }

  String getReleaseYear(String date) {
    if (date == null) return null;
    final res = date.split('-');
    return res.elementAt(0);
  }
}
