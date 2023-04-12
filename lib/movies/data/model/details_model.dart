import 'package:movies/movies/data/model/genres_model.dart';
import 'package:movies/movies/domain/entities/movies_details.dart';

class DetailsModel extends Details{
  const DetailsModel(
      {
        required super.image,
        required super.genres,
        required super.id,
        required super.title,
        required super.date,
        required super.rate,
        required super.runtime,
        required super.description,
        required super.posterImage,
      });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
        image: json['backdrop_path'],
        posterImage: json['poster_path'],
        genres: List<GenresModel>.from(json['genres'].map((e) => GenresModel.fromJson(e))),
        id: json['id'],
        title: json['title'],
        date: json['release_date'],
        rate: json['vote_average'],
        runtime: json['runtime'],
        description: json['overview'],
    );
  }


}