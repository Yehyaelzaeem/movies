import 'episodes.dart';

class Seasons {
  final int? seasonId;
  final String? seasonName;
  final String? seasonImage;
  final int? seasonNumber;
  final String? seasonDescription;
  final String? seasonDate;
  final int? seasonEpisodeCount;
  final List<Episodes>? episode;

  Seasons({
    required  this.seasonId,
    required  this.seasonName,
    required  this.seasonImage,
    required  this.seasonNumber,
    required  this.seasonDescription,
    required  this.seasonDate,
    required  this.seasonEpisodeCount,
    required  this.episode

});
}