import 'package:movies/tv/domain/entities/episodes.dart';

class EpisodeModel extends Episodes{
  EpisodeModel({
    required super.id,
    required super.numberEpisode,
    required super.runTime,
    required super.dateOfEpisode,
    required super.name,
    required super.descriptionEpisode,
    required super.imageEpisode,
    required super.rate});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
        id: json['id'],
        numberEpisode: json['episode_number'],
        runTime: json['runtime'],
        dateOfEpisode: json['air_date'],
        name:json['name'],
        descriptionEpisode:json['overview'],
        imageEpisode: json['still_path'],
        rate: json['vote_average'],
    );
  }
}