import 'package:movies/movies/domain/entities/movies.dart';

class MoviesModel extends Movies{
  const MoviesModel(
      {
        required super.image,
        required super.title,
        required super.id,
        required super.rate,
        required super.description,
        required super.genreIds,
        required super.date,
        required super.posterImage,
        required super.lan,
      });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
        image: json['backdrop_path'],
        title: json['original_title'],
        id: json['id'],
        rate: json['vote_average'],
        description: json['overview'],
        genreIds: List<int>.from(json['genre_ids'].map((e) => e)),
        date: json['release_date'],
        posterImage:json['poster_path'],
        lan: json['original_language']
    );
  }


}