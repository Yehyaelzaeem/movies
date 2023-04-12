import 'package:equatable/equatable.dart';
import 'genres.dart';

class Details extends Equatable{
  final String image;
  final String posterImage;
  final int id;
  final List<Genres> genres;
  final String title;
  final String date;
  final dynamic rate;
  final int runtime;
  final String description;

 const Details(
  {
    required this.image,
    required this.genres,
    required this.id,
    required this.title,
    required this.date,
    required this.rate,
    required this.runtime,
    required this.posterImage,
    required this.description,}
      );

  @override
  List<Object?> get props => [
    image,
    id,
    title,
    genres,
    date,
    rate,
    runtime,
    description,
    posterImage
  ];

}