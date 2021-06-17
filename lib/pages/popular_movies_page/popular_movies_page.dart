import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/movies/data/models/movie_model.dart';
import 'package:tmdb/features/movies/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:tmdb/pages/popular_movies_page/widgets/movie_card.dart';

class PopularMoviesPage extends StatefulWidget {
  PopularMoviesPage({Key key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  final _scrollController = ScrollController();
  final List<MovieModel> _allMovies = [];

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      if (_scrollController.offset ==
              _scrollController.position.maxScrollExtent &&
          !BlocProvider.of<PopularMoviesBloc>(context).isLoading) {
        BlocProvider.of<PopularMoviesBloc>(context)
          ..isLoading = true
          ..add(GetPopularMovies());
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Popular movies')),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
          listener: (context, state) {
            if (state is Error) {
              _buildLoading();
            }
          },
          builder: (context, state) {
            if (state is Empty || state is Loading && _allMovies.isEmpty) {
              _buildLoading();
            }
            if (state is Loaded) {
              _allMovies.addAll(state.popularMovies);
              BlocProvider.of<PopularMoviesBloc>(context).isLoading = false;
            }
            return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                itemBuilder: (context, index) => index < _allMovies.length
                    ? MovieCard(movie: _allMovies[index])
                    : _buildLoading(),
                itemCount: _allMovies.length + 1,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
