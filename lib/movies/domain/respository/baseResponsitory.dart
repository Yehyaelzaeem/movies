import '../../data/model/movies_model.dart';

abstract class BaseMoviesRepository {
 Future<List<MoviesModel>> getPlayNow(int page);
 Future<List<MoviesModel>> getPopular(int page);
 Future<List<MoviesModel>> getTopRated(int page);
 Future<List<MoviesModel>> getSearch(String query, int page);
}