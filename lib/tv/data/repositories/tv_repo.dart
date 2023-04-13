import 'package:movies/tv/data/data_sources/tv_remote_datasource.dart';
import 'package:movies/tv/data/models/details_tv_model.dart';
import 'package:movies/tv/domain/repositories/base_tv_repo.dart';
import '../models/tv_model.dart';

class TvRepositories extends BaseTvRepositories{
  final BaseTvRemoteDataSource baseTvRemoteDataSource ;
  TvRepositories(this.baseTvRemoteDataSource);

  @override
  Future<List<TvModel>> getOnTheAir()async {
    final res = await baseTvRemoteDataSource.getOnTheAir();
    return res;
  }

  @override
  Future<List<TvModel>> getTvPopular(int page)async {
   final res = await baseTvRemoteDataSource.getPopular(page);
   return res;
  }

  @override
  Future<List<TvModel>> getTvTopRated(int page)async {
    final res= await baseTvRemoteDataSource.getTopRated(page);
    return res;
  }

  @override
  Future<DetailsModelTv> getTvDetails(int id,String lang) async{
    final res = await baseTvRemoteDataSource.getTvDetails(id,lang);
    return res;
  }

  @override
  Future<List<TvModel>> getTvSearch(String query, int page)async {
    final res= await baseTvRemoteDataSource.getTvSearch(query, page);
    return res;
  }
}