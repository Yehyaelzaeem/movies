import 'package:movies/movies/domain/respository/baseResponsitory.dart';
import '../../data/model/movies_model.dart';

class GetPlayNowUseCase{
  final BaseMoviesRepository baseMoviesResponsitory;
  GetPlayNowUseCase(this.baseMoviesResponsitory);

  Future<List<MoviesModel>> execute(int page)async{
   return await baseMoviesResponsitory.getPlayNow(page);
  }

  Future<List<MoviesModel>> getPopular(int page)async{
    return await baseMoviesResponsitory.getPopular(page);
  }

  Future<List<MoviesModel>> getTopRated (int page)async{
    return await baseMoviesResponsitory.getTopRated(page);
  }

  Future<List<MoviesModel>> getSearch (String query,int page)async{
    return await baseMoviesResponsitory.getSearch(query,page);
  }
}