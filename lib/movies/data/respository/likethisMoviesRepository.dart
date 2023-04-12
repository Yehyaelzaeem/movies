import 'package:dartz/dartz.dart';
import 'package:movies/movies/data/datasource/reomteDataSource.dart';
import 'package:movies/movies/domain/entities/likeThisMovies.dart';
import 'package:movies/movies/domain/respository/baseLikethisRepository.dart';
import '../../../core/networks/exception.dart';
import '../../../core/networks/failure.dart';

class LikeThisMoviesRepository extends BaseLikeThisRepository{
  final BaseRemoteDateSource baseRemoteDateSource;
  LikeThisMoviesRepository(this.baseRemoteDateSource);

  @override
  Future<Either<Failure,List<LikeThisMovies>>> getLikeThisMovies(int id)async {
    final res = await baseRemoteDateSource.getLikeThisMovies(id);
    try{
      return Right(res);
    }on ServerException catch(failure){
      return left(Serverfailure(failure.errorMessage.statusMessage));
    }
  }

}