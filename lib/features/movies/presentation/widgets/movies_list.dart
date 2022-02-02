import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/constants/constants.dart';

import 'package:movie_app/features/movies/presentation/presentation.dart';
import 'package:movie_app/features/movies/presentation/widgets/bottom_loader.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              switch (state.status) {
                case MoviesStatus.failure:
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        context.read<MoviesBloc>().add(
                              const MoviesFetched(),
                            );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          kAssetPrimaryColor,
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Oops!, Tap to retry',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                case MoviesStatus.success:
                  if (state.movies.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  }
                  return ListView.builder(
                    itemCount: state.hasReachedMax
                        ? state.movies.length
                        : state.movies.length + 1,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return index >= state.movies.length
                          ? const BottomLoader()
                          : MovieItem(
                              movie: state.movies[index],
                            );
                    },
                  );
                case MoviesStatus.initial:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<MoviesBloc>().add(const MoviesFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
