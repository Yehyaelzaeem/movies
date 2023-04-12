import '../../domain/entities/tv_details.dart';
import 'genres_tv_model.dart';

class DetailsModelTv extends TvDetails{
  const DetailsModelTv(
      {
        required super.image,
        required super.genres,
        required super.id,
        required super.title,
        required super.date,
        required super.rate,
        required super.seasonNumber,
        required super.description,
        required super.posterImage,
        required super.numberEpisodes,
      });

  factory DetailsModelTv.fromJson(Map<String, dynamic> json) {
    return DetailsModelTv(
        image: json['backdrop_path'],
        posterImage: json['poster_path'],
        genres: List<GenresModelTv>.from(json['genres'].map((e) => GenresModelTv.fromJson(e))),
        id: json['id'],
        title: json['original_name'],
        date: json['last_air_date'],
        rate: json['vote_average'],
        seasonNumber: json['number_of_seasons'],
        description: json['overview'],
        numberEpisodes: json['number_of_episodes'],
    );
  }
}