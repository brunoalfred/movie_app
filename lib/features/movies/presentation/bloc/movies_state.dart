part of 'movies_bloc.dart';

enum MoviesStatus {
  initial,
  success,
  failure,
}

class MoviesState extends Equatable {
  const MoviesState({
    this.status = MoviesStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
    
  });

  final MoviesStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;

  MoviesState copyWith({
    MoviesStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''MoviesState { status: $status, hasReachedMax: $hasReachedMax, posts: ${movies.length} }''';
  }

  @override
  List<Object> get props => [status, movies, hasReachedMax];
}

enum MoviesSuggestionStatus {
  initial,
  success,
  failure,
}

class MoviesSuggestionsState extends Equatable {
  const MoviesSuggestionsState({
    this.status = MoviesSuggestionStatus.initial,
    this.movies = const <Movie>[],
  });

  MoviesSuggestionsState copyWith({
    MoviesSuggestionStatus? status,
    List<Movie>? movies,
  }) {
    return MoviesSuggestionsState(
      status: this.status,
      movies: movies,
    );
  }

  final MoviesSuggestionStatus status;
  final List<Movie>? movies;

  @override
  String toString() {
    return '''MoviesState { status: $status,  posts: $movies }''';
  }

  @override
  List<Object> get props => [
        status,
        
      ];
}
