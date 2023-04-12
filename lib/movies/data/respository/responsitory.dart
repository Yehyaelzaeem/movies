import 'package:movies/movies/data/datasource/reomteDataSource.dart';
import '../../domain/respository/baseResponsitory.dart';
import '../model/movies_model.dart';

class MoviesRepository extends BaseMoviesRepository{
  final BaseRemoteDateSource baseRemoteDateSource;
  MoviesRepository(this.baseRemoteDateSource);

  @override
  Future<List<MoviesModel>> getPlayNow(int page) async{
    final res= await baseRemoteDateSource.getMoviesPlayNow(page);
    return res;
  }

  @override
  Future<List<MoviesModel>> getPopular(int page) async{
    final res= await baseRemoteDateSource.getMoviesPopular(page);
    return res;
  }

  @override
  Future<List<MoviesModel>> getTopRated(int page) async{
    final res= await baseRemoteDateSource.getMoviesTopRated(page);
    return res;
  }
}