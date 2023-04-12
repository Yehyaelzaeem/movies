import 'package:movies/tv/data/models/likethismovies_tv_model.dart';
import '../../domain/repositories/baseLikethisRepositoryTv.dart';
import '../data_sources/tv_remote_datasource.dart';

class LikeThisMoviesRepositoryTv extends BaseLikeThisRepositoryTv{
  final BaseTvRemoteDataSource baseTvRemoteDataSource;
  LikeThisMoviesRepositoryTv(this.baseTvRemoteDataSource);

  @override
  Future<List<LikeThisMoviesModelTv>> getLikeThisMovies(int id)async {
    final res = await baseTvRemoteDataSource.getTvLikeThis(id);
    return res;
  }
}