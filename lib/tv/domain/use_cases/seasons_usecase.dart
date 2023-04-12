import 'package:movies/tv/data/models/seasons_tv.dart';
import 'package:movies/tv/domain/repositories/base_seasons_repo.dart';

class SeasonUseCase{
  final BaseSeasonsRepo baseSeasonsRepo ;

  SeasonUseCase(this.baseSeasonsRepo);
  Future<SeasonsModel> getSeasonData(int id,int seasonNumber)async{
    return await baseSeasonsRepo.getEpisode(id, seasonNumber);
  }
}