import 'package:dartz/dartz.dart';
import 'package:movies/movies/domain/respository/baseLikethisRepository.dart';
import '../../../core/networks/failure.dart';
import '../entities/likeThisMovies.dart';

class GetLikeThisMovies {
  final BaseLikeThisRepository baseLikeThisRepository;
  GetLikeThisMovies(this.baseLikeThisRepository);

  Future<Either<Failure,List<LikeThisMovies>>> execute(int id)async{
    return await baseLikeThisRepository.getLikeThisMovies(id);
  }
}