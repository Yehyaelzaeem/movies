import 'package:movies/tv/data/models/likethismovies_tv_model.dart';
import '../repositories/baseLikethisRepositoryTv.dart';

class GetLikeThisMoviesTvUseCase {
  final BaseLikeThisRepositoryTv baseLikeThisRepositoryTv;
  GetLikeThisMoviesTvUseCase(this.baseLikeThisRepositoryTv);

  Future<List<LikeThisMoviesModelTv>> execute(int id)async{
    return await baseLikeThisRepositoryTv.getLikeThisMovies(id);
  }
}