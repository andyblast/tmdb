import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tmdb/features/movies/data/models/movie_model.dart';
import 'package:tmdb/pages/movie_page/movie_page.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({
    Key key,
    @required this.movie,
  }) : super(key: key);

  void _handleOpenMoviePage(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      '/moviePage',
      arguments: MoviePageArgs(movie: movie),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleOpenMoviePage(context),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      movie.releaseDate ?? 'coming soon',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.voteAverage,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'votes: ${movie.voteCount}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
