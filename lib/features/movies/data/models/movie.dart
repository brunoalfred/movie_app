import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie(
      {required this.id,
      required this.title,
      required this.rating,
      required this.genre,
      required this.language,
      required this.coverImageUrl,
      required this.backgroundImageOriginal,
      required this.summary,});

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        rating = json['rating'] as num,
        genre = json['genre'] as List<dynamic>?,
        language = json['language'] as String,
        coverImageUrl = json['coverImageUrl'] as String,
        backgroundImageOriginal = json['background_image_original'] as String,
        summary = json['summary'] as String;

  final int id;
  final String title;
  final num rating;
  final List<dynamic>? genre;
  final String language;
  final String coverImageUrl;
  final String backgroundImageOriginal;
  final String summary;

  @override
  List<Object> get props => [id, title, rating, language, coverImageUrl];
}
