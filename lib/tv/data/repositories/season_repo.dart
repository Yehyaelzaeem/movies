import 'package:movies/tv/data/models/seasons_tv.dart';
import '../../domain/repositories/base_seasons_repo.dart';
import '../data_sources/seasons_remote_datasource.dart';

class SeasonRepo extends BaseSeasonsRepo{
  final BaseSeasonsDataSource baseSeasonsDataSource ;
  SeasonRepo(this.baseSeasonsDataSource);

  @override
  Future<SeasonsModel> getEpisode(int id, int seasonNumber,String lang)async {
  return await baseSeasonsDataSource.getSeasonsData(id, seasonNumber,lang);
  }
}