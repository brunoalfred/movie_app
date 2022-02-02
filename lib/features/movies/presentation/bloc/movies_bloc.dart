// ignore_for_file: avoid_dynamic_calls, 

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/constants/constants.dart';
import 'package:movie_app/features/movies/data/models/movie.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movies_event.dart';
part 'movies_state.dart';

const int _moviesLimit = 10;
const throttleDuration = Duration(milliseconds: 100);


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({required this.httpClient}) : super(const MoviesState()) {
    on<MoviesFetched>(
      _onMoviesFetched,
      transformer: throttleDroppable<MoviesFetched>(throttleDuration),
    );
  }
  final http.Client httpClient;

  Future<void> _onMoviesFetched(
    MoviesFetched event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MoviesStatus.initial) {
        final movies = await _fetchMovies();

        return emit(
          state.copyWith(
            status: MoviesStatus.success,
            movies: movies,
            hasReachedMax: false,
          ),
        );
      }

      // determine the next page to fetch

      final startPage = state.movies.length ~/ _moviesLimit;

      final movies = await _fetchMovies(startPage);

      movies.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MoviesStatus.success,
                movies: List.of(state.movies)..addAll(movies),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MoviesStatus.failure));
    }
  }

  Future<List<Movie>> _fetchMovies([int startPage = 1]) async {
    final response = await httpClient.get(
      Uri.parse(
        '$listMovies?limit=$_moviesLimit&page=$startPage',
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data']['movies'] as List;
      try {
        return body.map((dynamic json) {
          return Movie(
            id: json['id'] as int,
            title: json['title_long'] as String,
            rating: json['rating'] as num,
            genre: json['genres'] as List<dynamic>,
            language: json['language'] as String,
            coverImageUrl: json['medium_cover_image'] as String,
            backgroundImageOriginal:
                json['background_image_original'] as String,
            summary: json['summary'] as String,
          );
        }).toList();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    throw Exception('error fetching movies');
  }
}

class MoviesSuggestionsCubit extends Cubit<MoviesSuggestionsState> {
  MoviesSuggestionsCubit(
    MoviesSuggestionsState initialState, {
    required this.httpClient,
  }) : super(initialState);

  final http.Client httpClient;

  Future<void> onMovieSuggestionsFetched(Movie movie) async {
    if (state.status == MoviesSuggestionStatus.initial) {
      final movies = await _fetchSuggestedMovies(movie.id);
    
      try {
        return emit(
          state.copyWith(
            status: MoviesSuggestionStatus.success,
            movies: movies,
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<List<Movie>> _fetchSuggestedMovies(int movieId) async {
    final response = await httpClient.get(
      Uri.parse(
        '$movieSuggestion?movie_id=$movieId',
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data']['movies'] as List;

      try {
        return body.map((dynamic json) {
          return Movie(
            id: json['id'] as int,
            title: json['title_long'] as String,
            rating: json['rating'] as num,
            genre: json['genres'] as List<dynamic>?,
            language: json['language'] as String,
            coverImageUrl: json['medium_cover_image'] as String,
            backgroundImageOriginal:
                json['background_image_original'] as String,
            summary: json['summary'] as String,
          );
        }).toList();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    throw Exception('error fetching movies');
  }
}
