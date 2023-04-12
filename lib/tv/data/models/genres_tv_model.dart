import '../../domain/entities/genres.dart';

class GenresModelTv extends GenresTv{
  const GenresModelTv({required super.id, required super.name});

  factory GenresModelTv.fromJson(Map<String, dynamic> json) {
    return GenresModelTv(
        id: json['id'],
        name: json['name'],
    );
  }
}