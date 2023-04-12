import 'package:equatable/equatable.dart';
import 'genres.dart';

class TvDetails extends Equatable{
  final String image;
  final String posterImage;
  final int id;
  final int numberEpisodes;
  final List<GenresTv> genres;
  final String title;
  final String date;
  final dynamic rate;
  final int seasonNumber;
  final String description;

 const TvDetails(
  {
    required this.image,
    required this.genres,
    required this.id,
    required this.title,
    required this.date,
    required this.rate,
    required this.seasonNumber,
    required this.posterImage,
    required this.description,
    required this.numberEpisodes,
  }
      );

  @override
  List<Object?> get props => [
    image,
    id,
    title,
    genres,
    date,
    rate,
    seasonNumber,
    description,
    posterImage,
  ];

}