import 'package:movies/tv/data/models/tv_model.dart';
import 'package:movies/tv/domain/repositories/base_tv_repo.dart';
import '../../data/models/details_tv_model.dart';

class TvUseCase{
  final BaseTvRepositories baseTvRepositories ;
  TvUseCase(this.baseTvRepositories);

  Future<List<TvModel>> getOnTheAir()async{
    return await baseTvRepositories.getOnTheAir();
  }

  Future<List<TvModel>> getTvPopular(int page)async{
    return await baseTvRepositories.getTvPopular(page);
  }

  Future<List<TvModel>> getTvTopRated(int page)async{
    return await baseTvRepositories.getTvTopRated(page);
  }

  Future<DetailsModelTv> getTvDetails(int id,String lang)async{
    return await baseTvRepositories.getTvDetails(id,lang);
  }

  Future<List<TvModel>> getTvSearch(String query, int page)async{
    return await baseTvRepositories.getTvSearch(query,page);
  }

}