import '../../data/models/details_tv_model.dart';
import '../../data/models/tv_model.dart';

abstract class BaseTvRepositories{
  Future<List<TvModel>> getOnTheAir();
  Future<List<TvModel>> getTvPopular(int page);
  Future<List<TvModel>> getTvTopRated(int page);
  Future<DetailsModelTv> getTvDetails(int id,String lang);
  Future<List<TvModel>> getTvSearch(String query, int page);

}