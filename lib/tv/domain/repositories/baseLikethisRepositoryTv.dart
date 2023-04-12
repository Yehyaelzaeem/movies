import 'package:movies/tv/data/models/likethismovies_tv_model.dart';

abstract class BaseLikeThisRepositoryTv {
  Future<List<LikeThisMoviesModelTv>> getLikeThisMovies(int id);
}