import 'package:flutter/material.dart';
import 'package:tmdb/core/constansts.dart';
import 'package:tmdb/features/movies/data/models/movie_model.dart';

class MoviePage extends StatefulWidget {
  final MovieModel movie;

  const MoviePage({Key key, @required this.movie}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    final halfWidth = MediaQuery.of(context).size.width / 2 - 15;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _buildHeader(halfWidth),
            SizedBox(height: 15),
            Text(
              '${widget.movie.overview ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Text(
              '${widget.movie.tagline ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildHeader(double halfWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          '$POSTER_PATH/${widget.movie.posterPath}',
          width: halfWidth,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return _buildLoader(halfWidth);
          },
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;

            return _buildLoader(halfWidth);
          },
        ),
        SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.movie.title,
                overflow: TextOverflow.fade,
                softWrap: true,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${widget.movie.year ?? ''}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '${widget.movie.tagline ?? ''}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Rating: ${widget.movie.voteAverage}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildLoader(double halfWidth) {
    return Container(
      width: halfWidth,
      height: 286,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MoviePageArgs {
  final MovieModel movie;

  MoviePageArgs({this.movie});
}
