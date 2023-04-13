import '../../domain/entities/likeThisMoviesTv.dart';

class LikeThisMoviesModelTv extends LikeThisMoviesTv{
  const LikeThisMoviesModelTv({
    required super.image,
    required super.lang,
    required super.id});

  factory LikeThisMoviesModelTv.fromJson(Map<String, dynamic> json) {
    return LikeThisMoviesModelTv(
        image: json['poster_path'],
        id: json['id'],
        lang: json['original_language'],
    );
  }
}