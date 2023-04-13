import '../../data/models/seasons_tv.dart';

abstract class BaseSeasonsRepo{
  Future<SeasonsModel> getEpisode(int id ,int seasonNumber,String lang);
}