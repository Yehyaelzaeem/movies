import 'package:movies/tv/data/models/episodes.dart';
import 'package:movies/tv/domain/entities/seasons.dart';

class SeasonsModel extends Seasons{
  SeasonsModel({
    required super.seasonId,
    required super.seasonName,
    required super.seasonImage,
    required super.seasonNumber,
    required super.seasonDescription,
    required super.seasonDate,
    required super.seasonEpisodeCount,
    required super.episode});

  factory SeasonsModel.fromJson(Map<String, dynamic> json) {
    return SeasonsModel(
        seasonId: json['id'],
        seasonName: json['name'],
        seasonImage: json['poster_path'],
        seasonNumber: json['season_number'],
        seasonDescription: json['overview'],
        seasonDate: json['air_date'],
        seasonEpisodeCount:  json['season_number'],
        episode:  List<EpisodeModel>.from(json['episodes'].map((e) => EpisodeModel.fromJson(e))),
    );
  }
}
