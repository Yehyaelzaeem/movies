import 'package:movies/tv/domain/entities/tv.dart';

class TvModel extends Tv{
  TvModel({
    required super.image,
    required super.posterImage,
    required super.id,
    required super.title,
    required super.description,
    required super.rate,
    required super.date});

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
        image: json['backdrop_path'],
        posterImage: json['poster_path'],
        id: json['id'],
        title:json['original_name'],
        description: json['overview'],
        rate: json['vote_average'],
        date: json['first_air_date'],
    );
  }
}