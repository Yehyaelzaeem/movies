import 'package:movies/movies/domain/entities/likeThisMovies.dart';

class LikeThisMoviesModel extends LikeThisMovies{
  const LikeThisMoviesModel({
    required super.image,
    required super.id,
    required super.lan});

  factory LikeThisMoviesModel.fromJson(Map<String, dynamic> json) {
    return LikeThisMoviesModel(
        image: json['poster_path'],
        id: json['id'],
        lan: json['original_language']);
  }


}