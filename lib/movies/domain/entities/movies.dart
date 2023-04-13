import 'package:equatable/equatable.dart';

class Movies extends Equatable {
  final String? image;
  final String? posterImage;
  final String? title;
  final int id;
  final dynamic rate;
  final String? description;
  final List<int>? genreIds;
  final String? date;
  final String? lan;

 const Movies(
  {
    required this.image,
    required this.title,
    required this.id,
    required this.rate,
    required this.description,
    required this.genreIds,
    required this.date,
    required this.posterImage,
    required this.lan,

  }
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    image,
    title,
    id,
    rate,
    description,
    genreIds,
    date,
    posterImage,
    lan
  ];
}
