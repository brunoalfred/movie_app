part of 'movies_bloc.dart';


abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class MoviesFetched extends MoviesEvent {
  const MoviesFetched();

  @override
  List<Object> get props => [];
}

class MoviesFetchFailed extends MoviesEvent {
  
  const MoviesFetchFailed({required this.message});
  
  final String message;

  @override
  List<Object> get props => [message];
}

class MovieDetailsFetched extends MoviesEvent {
  const MovieDetailsFetched({required this.movie});
  
  final Movie movie;

  @override
  List<Object> get props => [movie];
}

